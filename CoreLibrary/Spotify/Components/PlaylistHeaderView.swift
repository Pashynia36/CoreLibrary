//
//  PlaylistHeaderView.swift
//  CoreLibrary
//
//  Created by Pavlo Novak on 2024-10-17.
//

import SwiftUI
import SwiftfulUI

struct PlaylistHeaderView: View {

    var height: CGFloat = 300
    var title: String = "Some playlist title goes here"
    var subtitle: String = "Subtitle is here"
    var imageName: String = Constants.randomImage
    var shadowColor: Color = .spotifyBlack.opacity(0.8)

    var body: some View {
        Rectangle()
            .opacity(0)
            .overlay(
                ImageLoaderView(urlString: imageName)
            )
            .overlay(
                VStack(alignment: .leading, spacing: 8) {
                    Text(subtitle)
                        .font(.headline)

                    Text(title)
                        .font(.largeTitle)
                        .fontWeight(.bold)
                }
                    .foregroundStyle(.spotifyWhite)
                    .padding(16)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(
                        LinearGradient(
                            colors: [shadowColor.opacity(0), shadowColor],
                            startPoint: .top,
                            endPoint: .bottom)
                    )
                , alignment: .bottomLeading
            )
            .asStretchyHeader(startingHeight: height)
    }
}

#Preview {
    ZStack {

        Color.black.ignoresSafeArea()

        ScrollView {
            PlaylistHeaderView()
        }
        .ignoresSafeArea()
    }
}
