//
//  NetflixDetailsDescriptionView.swift
//  CoreLibrary
//
//  Created by Pavlo Novak on 2024-12-02.
//

import SwiftUI
import SwiftfulUI

struct NetflixDetailsDescriptionView: View {

    var title: String = "Movie Title"
    var isNew: Bool = Bool.random()
    var yearReleased: String = "2024"
    var seasonsCount: Int? = 2
    var hasClosedCaptions: Bool = true
    var rank: Int? = 6
    var description: String? = "Some random description of a movie that has a title. Usually descriptions go multiple lines so that's why we have so much text here: to test it."
    var castText: String? = "Cast: Pashka"
    var onPlayPressed: (() -> Void)? = nil
    var onDownloadPressed: (() -> Void)? = nil

    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.headline)
                .frame(maxWidth: .infinity, alignment: .leading)

            HStack(spacing: 8) {
                if isNew {
                    Text("New")
                        .foregroundStyle(.green)
                }

                Text(yearReleased)

                if let seasonsCount {
                    Text("\(seasonsCount) Seasons")
                }

                if hasClosedCaptions {
                    Image(systemName: "captions.bubble")
                }
            }
            .foregroundStyle(.netflixLightGray)

            if let rank {
                HStack {
                    topTenIcon

                    Text("#\(rank) in TV Shows Today")
                }
            }

            VStack(spacing: 8) {
                HStack {
                    Image(systemName: "play.fill")
                    Text("Play")
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 8)
                .foregroundStyle(.netflixDarkGray)
                .background(.netflixWhite)
                .cornerRadius(4)
                .asButton(.press) {
                    onPlayPressed?()
                }

                HStack {
                    Image(systemName: "arrow.down.to.line.alt")
                    Text("Download")
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 8)
                .foregroundStyle(.netflixWhite)
                .background(.netflixDarkGray )
                .cornerRadius(4)
                .asButton(.press) {
                    onDownloadPressed?()
                }
            }
            .font(.callout)
            .fontWeight(.medium)

            Group {
                if let description {
                    Text(description)
                }

                if let castText {
                    Text(castText)
                        .foregroundStyle(.netflixLightGray)
                }
            }
            .font(.callout)
            .frame(maxWidth: .infinity, alignment: .leading)
            .multilineTextAlignment(.leading)
        }
        .foregroundStyle(.netflixWhite)
    }

    private var topTenIcon: some View {
        HStack(spacing: 8) {
            Rectangle()
                .fill(.netflixRed1)
                .frame(width: 28, height: 28)
                .overlay(
                    VStack(spacing: -2){
                        Text("TOP")
                            .fontWeight(.bold)
                            .font(.system(size: 8))
                        Text("10")
                            .fontWeight(.bold)
                            .font(.system(size: 16))
                    }
                        .offset(y: 1)
                )
        }
    }
}
