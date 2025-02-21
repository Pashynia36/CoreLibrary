//
//  NetflixMovieCell.swift
//  CoreLibrary
//
//  Created by Pavlo Novak on 2024-11-25.
//

import SwiftUI

struct NetflixMovieCell: View {

    var width: CGFloat = 90
    var height: CGFloat = 140
    var imageName: String = Constants.randomImage
    var title: String? = "Movie Title"
    var recentlyAdded: Bool = Bool.random()
    var topTenRanking: Int? = nil

    var body: some View {
        HStack(alignment: .bottom, spacing: -8) {
            if let topTenRanking {
                Text("\(topTenRanking)")
                    .font(.system(size: 100, weight: .medium, design: .serif))
                    .offset(y: 20)
            }

            ZStack(alignment: .bottom) {
                ImageLoaderView(urlString: imageName)

                VStack(spacing: 0) {
                    if let title {
                        Text(title)
                            .font(.subheadline)
                            .fontWeight(.medium)
                            .lineLimit(2)
                    }

                    Text("Recently Added")
                        .padding(.horizontal, 4)
                        .padding(.vertical, 2)
                        .frame(maxWidth: .infinity)
                        .background(Color.netflixRed1)
                        .cornerRadius(2)
                        .lineLimit(1)
                        .font(.caption2)
                        .fontWeight(.bold)
                        .minimumScaleFactor(0.1)
                        .padding(.horizontal, 8)
                        .opacity(recentlyAdded ? 1 : 0)
                }
                .padding(.top, 6)
                .background(
                    LinearGradient(
                        colors: [
                            .netflixBlack.opacity(0),
                            .netflixBlack.opacity(0.3),
                            .netflixBlack.opacity(0.4),
                            .netflixBlack.opacity(0.4)
                        ],
                        startPoint: .top,
                        endPoint: .bottom
                    )
                )
            }
            .cornerRadius(4)
            .frame(width: width, height: height)
        }
        .foregroundStyle(.netflixWhite)
    }
}
