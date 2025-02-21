//
//  SongRowView.swift
//  CoreLibrary
//
//  Created by Pavlo Novak on 2024-10-21.
//

import SwiftUI

struct SongRowView: View {

    var imageSize: CGFloat = 50
    var imageName: String = Constants.randomImage
    var title: String = "Some title"
    var subtitle: String = "Some subtitle describing stuff"
    var onCellPressed: (() -> Void)?

    var body: some View {
        HStack(spacing: 8) {
            ImageLoaderView(urlString: imageName)
                .frame(width: imageSize, height: imageSize)
                .background(.spotifyWhite)

            VStack(alignment: .leading, spacing: 8) {
                Text(title)
                    .font(.body)
                    .fontWeight(.medium)
                    .foregroundStyle(.spotifyWhite)

                Text(subtitle)
                    .font(.callout)
                    .foregroundStyle(.spotifyLightGray)
            }
            .lineLimit(1)
            .frame(maxWidth: .infinity, alignment: .leading)

            Image(systemName: "ellipsis")
                .font(.subheadline)
                .foregroundStyle(.spotifyLightGray)
                .padding(16)
                .background(Color.black.opacity(0.001))
                .onTapGesture {
                    onCellPressed?()
                }
        }
        .onTapGesture {
            onCellPressed?()
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

#Preview {
    ZStack {
        Color.black.ignoresSafeArea()

        VStack {
            SongRowView()
            SongRowView()
            SongRowView()
            SongRowView()
        }
    }
}
