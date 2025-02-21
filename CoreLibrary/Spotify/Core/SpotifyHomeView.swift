//
//  SpotifyHomeView.swift
//  CoreLibrary
//
//  Created by Pavlo Novak on 2024-10-03.
//

import SwiftUI
import SwiftfulUI
import SwiftfulRouting

struct SpotifyHomeView: View {
    var body: some View {
        ZStack {
            Color.spotifyBlack.ignoresSafeArea()

            ScrollView(.vertical) {
                LazyVStack(spacing: 5,
                           pinnedViews: [.sectionHeaders],
                           content: {
                    Section {
                        VStack(spacing: 16) {
                            recentsSection
                                .padding(.horizontal, 16)

                            if let product = products.first {
                                newReleaseSection(product: product)
                                    .padding(.horizontal, 16)
                            }
                        }

                        listRows
                    } header: {
                        header
                    }

                })
                .padding(.top, 8)
            }
            .scrollIndicators(.hidden)
            .clipped()
        }
        .task {
            await getData()
        }
        .toolbar(.hidden, for: .navigationBar)
    }

    @State private var currentUser: User? = nil
    @State private var selectedCategory: Category? = nil
    @State private var products: [Product] = []
    @State private var productRows: [ProductRow] = []

    @Environment(\.router) private var router

    private func getData() async {
        guard products.isEmpty else { return }
        do {
            currentUser = try await DBHelper().getUsers().first
            products = try await Array(DBHelper().getProduct().prefix(upTo: 8))

            // Fake data
            var rows: [ProductRow] = []
            let allBrands = Set(products.map { $0.brand })
            for brand in allBrands {
//                let products = self.products.filter { $0.brand == brand }
                rows.append(ProductRow(title: brand?.capitalized ?? "Unidentified", products: products))
            }

            productRows = rows
        } catch {

        }
    }

    private var header: some View {
        HStack(spacing: 0) {
            ZStack {
                if let currentUser {
                    ImageLoaderView(urlString: currentUser.image)
                        .background(.spotifyWhite)
                        .clipShape(Circle())
                        .onTapGesture {
                            router.dismissScreen()
                        }
                }
            }
            .frame(width: 35, height: 35)

            ScrollView(.horizontal) {
                HStack(spacing: 8) {
                    ForEach(Category.allCases, id: \.self) { category in
                        SpotifyCategoryCell(
                            title: category.rawValue.capitalized,
                            isSelected: category == selectedCategory
                        )
                        .onTapGesture {
                            selectedCategory = category
                        }
                    }
                }
                .padding(.horizontal, 16)
            }
            .scrollIndicators(.hidden)
        }
        .padding(.vertical, 24)
        .padding(.leading, 8)
        .background(Color.spotifyBlack)
    }

    private var recentsSection: some View {
        NonLazyVGrid(columns: 2,
                     alignment: .center,
                     spacing: 10,
                     items: products) { product in
            if let product {
                SpotifyRecentsCell(imageName: product.firstImage,
                                   title: product.title)
                .asButton(.press) {
                    goToPlaylistView(product: product)
                }
            }
        }
    }

    private func goToPlaylistView(product: Product) {
        guard let currentUser else { return }

        router.showScreen(.push) { _ in
            SpotifyPlaylistView(product: product, user: currentUser)
        }
    }

    private func newReleaseSection(product: Product) -> some View {
        SpotifyNewReleaseCell(
            imageName: product.firstImage,
            headline: product.brand,
            subheadline: product.category,
            title: product.title,
            subtitle: product.description,
            onAddToPlaylistAction: nil,
            onPlayAction: { goToPlaylistView(product: product) }
        )
    }

    private var listRows: some View {
        ForEach(productRows) { row in
            VStack(spacing: 8) {
                Text(row.title)
                    .font(.title)
                    .fontWeight(.semibold)
                    .foregroundStyle(.spotifyWhite)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, 16)

                ScrollView(.horizontal) {
                    HStack(alignment: .top, spacing: 16) {
                        ForEach(row.products) { product in
                            ImageTitleRowCell(
                                imageSize: 120,
                                imageName: product.firstImage,
                                title: product.title
                            )
                            .asButton(.press) {
                                goToPlaylistView(product: product)
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

#Preview {
    SpotifyHomeView()
}
