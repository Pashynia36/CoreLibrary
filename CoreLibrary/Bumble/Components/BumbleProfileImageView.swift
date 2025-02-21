//
//  BumbleProfileImageView.swift
//  CoreLibrary
//
//  Created by Pavlo Novak on 2024-11-11.
//

import SwiftUI

struct BumbleProfileImageView: View {

    var imageName: String = Constants.randomImage
    var remaining: Double = Double.random(in: 0...1)
    var hasNewMessage: Bool = Bool.random()

    var body: some View {
        ZStack {
            Circle()
                .stroke(.bumbleGray, lineWidth: 2)

            Circle()
                .trim(from: 0, to: remaining)
                .stroke(.bumbleYellow, lineWidth: 2)
                .rotationEffect(Angle(degrees: -90))
                .scaleEffect(x: -1, y: 1, anchor: .center)

            ImageLoaderView(urlString: imageName)
                .clipShape(Circle())
                .padding(4)
                .overlay(
                    ZStack {
                        if hasNewMessage {
                            Circle()
                                .fill(.bumbleWhite)
                            Circle()
                                .fill(.bumbleYellow)
                                .padding(4)
                        }
                    }
                        .frame(width: 24, height: 24)
                        .offset(x: 2, y: 2)
                    , alignment: .bottomTrailing
                )
        }
        .frame(width: 75, height: 75)

    }
}
