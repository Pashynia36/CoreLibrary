//
//  ImageLoaderView.swift
//  CoreLibrary
//
//  Created by Pavlo Novak on 2024-10-01.
//

import SwiftUI

struct ImageLoaderView: View {
    let urlString: String
    let resizingMode: ContentMode

    init(urlString: String = Constants.randomImage, resizingMode: ContentMode = .fit) {
        self.urlString = urlString
        self.resizingMode = resizingMode
    }

    var body: some View {
        Rectangle()
            .opacity(0.001)
            .overlay(
                AsyncImage(url: URL(string: urlString)) { result in
                    result.image?
                        .resizable()
                        .aspectRatio(contentMode: resizingMode)
                        .allowsHitTesting(false)
                }
            )
            .clipped()
    }
}
