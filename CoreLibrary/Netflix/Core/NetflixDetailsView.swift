//
//  NetflixDetailsView.swift
//  CoreLibrary
//
//  Created by Pavlo Novak on 2024-12-02.
//

import SwiftUI

struct NetflixDetailsView: View {

    var product: Product = .mock

    var body: some View {
        ZStack {
            Color.netflixBlack.ignoresSafeArea()
            Color.netflixDarkGray.opacity(0.3).ignoresSafeArea()

            VStack(spacing: 0) {
                NetflixDetailsHeaderView(
                    imageName: product.firstImage,
                    progress: progress) {

                    } onXmarkPressed: {
                        router.dismissScreen()
                    }

                ScrollView(.vertical) {
                    VStack(alignment: .leading, spacing: 16) {
                        detailsProductSection

                        buttonsSection

                        moreLikeThisSection
                    }
                    .padding(8)
                }
                .scrollIndicators(.hidden)
            }
        }
        .task {
            await getData()
        }
        .toolbar(.hidden, for: .navigationBar)
    }

    @State private var progress: Double = 0.2
    @State private var isMyList: Bool = false
    @State private var products: [Product] = []

    @Environment(\.router) var router

    private var detailsProductSection: some View {
        NetflixDetailsDescriptionView(
            title: product.title,
            yearReleased: "2024",
            seasonsCount: 2,
            hasClosedCaptions: true,
            rank: 1,
            description: product.description) {

            } onDownloadPressed: {

            }
    }

    private var buttonsSection: some View {
        HStack(spacing: 32) {
            MyListButton(isInMyList: isMyList) {
                isMyList.toggle()
            }

            RateButton { selection in
                // do smth with selection
            }

            ShareButton()
        }
        .padding(.leading, 32)
    }

    private var moreLikeThisSection: some View {
        VStack(alignment: .leading) {
            Text("More Like This")
                .font(.headline)

            LazyVGrid(
                columns: Array(
                    repeating: GridItem(.flexible(), spacing: 8),
                    count: 3
                ),
                alignment: .center,
                spacing: 8
            ) {
                ForEach(products) { product in
                    NetflixMovieCell(
                        imageName: product.firstImage,
                        title: product.title,
                        recentlyAdded: product.recentlyAdded ?? Bool.random(),
                        topTenRanking: nil
                    )
                    .onTapGesture {
                        onProductPressed(product)
                    }
                }
            }
        }
        .foregroundStyle(.netflixWhite)
    }

    private func onProductPressed(_ product: Product) {
        router.showScreen(.sheet) { _ in
            NetflixDetailsView(product: product)
        }
    }

    private func getData() async {
        guard products.isEmpty else { return }

        do {
            products = try await DBHelper().getProduct()
        } catch {

        }
    }
}
