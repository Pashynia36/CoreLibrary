//
//  ShareButton.swift
//  CoreLibrary
//
//  Created by Pavlo Novak on 2024-12-03.
//

import SwiftUI

struct ShareButton: View {

    var urlString: String = "https://www.youtube.com/@pasha7324"

    var body: some View {
        if let url = URL(string: urlString) {
            ShareLink(item: url) {
                VStack(spacing: 8) {
                    Image(systemName: "paperplane")
                        .font(.title)

                    Text("Share")
                        .font(.caption)
                        .foregroundStyle(.netflixLightGray)
                }
                .foregroundStyle(.netflixWhite)
                .padding(8)
                .background(Color.black.opacity(0.001))
            }
        }
    }
}

#Preview {
    ShareButton()
}
