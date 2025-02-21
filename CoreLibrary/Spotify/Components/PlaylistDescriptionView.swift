//
//  PlaylistDescriptionView.swift
//  CoreLibrary
//
//  Created by Pavlo Novak on 2024-10-17.
//

import SwiftUI

struct PlaylistDescriptionView: View {

    var descriptionText: String = Product.mock.description
    var userName: String = "Pasha"
    var subheadline: String = "Headline goes here"
    var onAddToPlaylistPressed: (() -> Void)? = nil
    var onDownloadPressed: (() -> Void)? = nil
    var onSharePressed: (() -> Void)? = nil
    var onMorePressed: (() -> Void)? = nil

    var onShufflePressed: (() -> Void)? = nil
    var onPlayPressed: (() -> Void)? = nil

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(descriptionText)
                .foregroundStyle(.spotifyLightGray)
                .frame(maxWidth: .infinity, alignment: .leading)

            madeForYouView

            Text(subheadline)

            buttonsView
        }
        .font(.caption)
        .fontWeight(.medium)
        .foregroundStyle(.spotifyLightGray)
    }

    // MARK: - Private
    private var madeForYouView: some View {
        HStack(spacing: 8) {
            Image(systemName: "applelogo")
                .font(.title3)
                .foregroundStyle(.spotifyGreen)

            Text("Made for ")
            +
            Text(userName)
                .bold()
                .foregroundStyle(.spotifyWhite)
        }
    }

    private var buttonsView: some View {
        HStack(spacing: 0) {
            HStack(spacing: 0) {
                Image(systemName: "plus.circle")
                    .padding(8)
                    .background(Color.blue.opacity(0.001))
                    .onTapGesture {
                        
                    }
                Image(systemName: "arrow.down.circle")
                    .padding(8)
                    .background(Color.blue.opacity(0.001))
                    .onTapGesture {

                    }
                Image(systemName: "square.and.arrow.up")
                    .padding(8)
                    .background(Color.blue.opacity(0.001))
                    .onTapGesture {

                    }
                Image(systemName: "ellipsis")
                    .padding(8)
                    .background(Color.blue.opacity(0.001))
                    .onTapGesture {

                    }
            }
            .offset(x: -8)
            .frame(maxWidth: .infinity, alignment: .leading)

            HStack(spacing: 8) {
                Image(systemName: "shuffle")
                    .font(.system(size: 24))
                    .background(Color.blue.opacity(0.001))
                    .onTapGesture {

                    }

                Image(systemName: "play.circle.fill")
                    .font(.system(size: 46))
                    .background(Color.blue.opacity(0.001))
                    .onTapGesture {

                    }
            }
            .foregroundStyle(.spotifyGreen)
        }
        .font(.title2)
    }
}

#Preview {
    ZStack {
        Color.black.ignoresSafeArea()

        PlaylistDescriptionView()
            .padding()
    }
}
