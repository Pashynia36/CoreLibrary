//
//  SpotifyPlaylistView.swift
//  CoreLibrary
//
//  Created by Pavlo Novak on 2024-10-17.
//

import SwiftUI
import SwiftfulUI

struct SpotifyPlaylistView: View {

    var product: Product = .mock
    var user: User = .mock

    var body: some View {
        ZStack {
            Color.spotifyBlack.ignoresSafeArea()

            ScrollView(.vertical) {
                LazyVStack(spacing: 12) {
                    PlaylistHeaderView(
                        height: 250,
                        title: product.title,
                        subtitle: product.description,
                        imageName: product.firstImage
                    )
                    .readingFrame { frame in
                        showHeader = frame.maxY < 150
                    }

                    PlaylistDescriptionView(
                        descriptionText: product.description,
                        userName: user.username,
                        subheadline: product.category
                    )
                    .padding(.horizontal, 16)
                    
                    ForEach(products) { product in
                        SongRowView(
                            imageSize: 50,
                            imageName: product.firstImage,
                            title: product.title,
                            subtitle: product.brand ?? "") {
                                //
                            }
                    }
                    .padding(.leading, 16)
                }
            }
            .scrollIndicators(.hidden)

            ZStack {
                Text(product.title)
                    .font(.headline)
                    .padding(.vertical, 20)
                    .frame(maxWidth: .infinity)
                    .background(Color.spotifyBlack)
                    .offset(y: showHeader ? 0 : -40)
                    .opacity(showHeader ? 1 : 0)

                Image(systemName: "chevron.left")
                    .font(.title3)
                    .padding(10)
                    .background(showHeader ? Color.black.opacity(0.001) : Color.spotifyGray.opacity(0.7))
                    .clipShape(Circle())
                    .onTapGesture {
                        router.dismissScreen()
                    }
                    .padding(.leading, 16)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            .animation(.smooth(duration: 0.2), value: showHeader)
            .frame(maxWidth: .infinity)
            .frame(maxHeight: .infinity, alignment: .top)
        }
        .task {
            await getData()
        }
        .toolbar(.hidden, for: .navigationBar)
    }

    // MARK: - Private
    @State private var products: [Product] = []
    @State private var showHeader: Bool = true
    @State private var offset: CGFloat = 0

    @Environment(\.router) private var router

    private func getData() async {
        do {
            products = try await DBHelper().getProduct()

        } catch {

        }
    }
}

#Preview {
    SpotifyPlaylistView()
}
