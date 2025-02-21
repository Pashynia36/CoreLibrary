//
//  ImageTitleRowCell.swift
//  CoreLibrary
//
//  Created by Pavlo Novak on 2024-10-14.
//

import SwiftUI

struct ImageTitleRowCell: View {

    var imageSize: CGFloat = 100
    var imageName: String = Constants.randomImage
    var title: String = "Some item name"

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            ImageLoaderView(urlString: imageName)

            Text(title)
                .font(.callout)
                .foregroundStyle(.spotifyLightGray)
                .lineLimit(2)
                .padding(4)
        }
        .frame(width: imageSize, height: imageSize)
    }
}

#Preview {
    ZStack {
        Color.black.ignoresSafeArea()

        ImageTitleRowCell()
    }
}
