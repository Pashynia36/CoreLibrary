//
//  NetflixHomeView.swift
//  CoreLibrary
//
//  Created by Pavlo Novak on 2024-11-14.
//

import SwiftUI
import SwiftfulUI
import SwiftfulRouting

// This view implementation sucks.
struct NetflixHomeView: View {
    var body: some View {
        ZStack(alignment: .top) {
            Color.netflixBlack.ignoresSafeArea()

            gradientLayer

            scrollViewLayer

            fullHeaderWithFilters
        }
        .foregroundStyle(.netflixWhite)
        .task {
            await getData()
        }
        .toolbar(.hidden, for: .navigationBar)
    }

    // MARK: - Private

    @State private var filters = FilterModel.mockArray
    @State private var selectedFilter: FilterModel? = nil

    @State private var heroProduct: Product? = nil

    @State private var fullHeaderSize: CGSize = .zero

    @State private var productRows: [ProductRow] = []
    @State private var currentUser: User? = nil

    @State private var scrollViewOffset: CGFloat = 0

    @Environment(\.router) var router

    private var gradientLayer: some View {
        ZStack {
            LinearGradient(
                colors: [.netflixDarkGray.opacity(1), .netflixDarkGray.opacity(0)],
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()

            LinearGradient(
                colors: [.netflixDarkRed.opacity(5), .netflixDarkGray.opacity(0)],
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()
        }
        .frame(maxHeight: max(10, 400 + (scrollViewOffset * 0.75)))
        .opacity(scrollViewOffset < -250 ? 0 : 1)
        .animation(.easeInOut, value: scrollViewOffset)
    }

    private var header: some View {
        HStack(spacing: 0) {
            Text("For You")
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.title)
                .onTapGesture {
                    router.dismissScreen()
                }

            HStack(spacing: 16) {
                Image(systemName: "tv.badge.wifi")
                    .onTapGesture {

                    }
                Image(systemName: "magnifyingglass")
                    .onTapGesture {

                    }
            }
            .font(.title2)
        }
    }

    private var fullHeaderWithFilters: some View {
        VStack(spacing: 0) {
            header
                .padding(.horizontal, 16)
                .background(Color.netflixLightGray.blur(radius: 50))

            if scrollViewOffset > -20 {
                NetflixFilterBarView(
                    filters: filters,
                    onXmarkPressed: {
                        selectedFilter = nil
                    },
                    onFilterPressed: { filter in
                        selectedFilter = filter
                    },
                    selectedFilter: selectedFilter
                )
                .padding(.top, 16)
                .transition(.move(edge: .top).combined(with: .opacity))
            }
        }
        .padding(.bottom, 8)
        .background(
            ZStack {
                if scrollViewOffset < -70 {
                    Rectangle()
                        .fill(Color.clear)
                        .background(.ultraThinMaterial)
                        .brightness(-0.2)
                        .ignoresSafeArea()
                }
            }
        )
        .animation(.smooth, value: scrollViewOffset)
        .readingFrame { frame in
            if fullHeaderSize == .zero {
                fullHeaderSize = frame.size
            }
        }
    }

    private func heroView(product: Product) -> some View {
        NetflixHeroView(
            imageName: product.firstImage,
            isNetflixFilm: true,
            title: product.title) {
                onProductPressed(product)
            } onPlayPressed: {
                onProductPressed(product)
            } onMyListPressed: {

            }
            .padding(24)
    }

    private var scrollViewLayer: some View {
        ScrollViewWithOnScrollChanged(
            .vertical,
            showsIndicators: false) {
                VStack(spacing: 8) {
                    Rectangle()
                        .opacity(0)
                        .frame(height: fullHeaderSize.height)

                    if let heroProduct {
                        heroView(product: heroProduct)
                    }

                    LazyVStack(spacing: 16) {
                        ForEach(Array(productRows.enumerated()), id: \.offset) { rowIndex, row in
                            VStack(alignment: .leading, spacing: 6) {
                                Text(row.title)
                                    .font(.headline)
                                    .padding(.leading, 16)

                                ScrollView(.horizontal) {
                                    LazyHStack {
                                        ForEach(Array(row.products.enumerated()), id: \.offset) { index, product in
                                            NetflixMovieCell(
                                                imageName: product.firstImage,
                                                title: product.title,
                                                recentlyAdded: product.recentlyAdded ?? false,
                                                topTenRanking: rowIndex == 1 ? index + 1 : nil
                                            )
                                            .onTapGesture {
                                                onProductPressed(product)
                                            }
                                        }
                                    }
                                    .padding(.horizontal, 16)
                                }
                                .scrollIndicators(.hidden)
                            }
                        }
                    }
                }
            } onScrollChanged: { offset in
                scrollViewOffset = min(0, offset.y)
            }
    }

    private func onProductPressed(_ product: Product) {
        router.showScreen(.sheet) { _ in
            NetflixDetailsView(product: product)
        }
    }

    private func getData() async {
        guard productRows.isEmpty else { return }
        do {
            currentUser = try await DBHelper().getUsers().first
            let products = try await DBHelper().getProduct()
            heroProduct = products.first

            // Fake data
            var rows: [ProductRow] = []
            let allBrands = Set(products.map { $0.brand })
            for brand in allBrands {
//                let products = self.products.filter { $0.brand == brand }
                rows.append(ProductRow(title: brand?.capitalized ?? "Unidentified", products: products.shuffled()))
            }

            productRows = rows
        } catch {

        }
    }
}
