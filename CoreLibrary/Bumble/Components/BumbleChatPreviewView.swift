//
//  BumbleChatPreviewView.swift
//  CoreLibrary
//
//  Created by Pavlo Novak on 2024-11-11.
//

import SwiftUI

struct BumbleChatPreviewView: View {

    var imageName: String = Constants.randomImage
    var remaining: Double = Double.random(in: 0...1)
    var hasNewMessage: Bool = Bool.random()
    var userName: String = "Pasha"
    var lastChatMessage: String? = "Open to see the message..."
    var isYourMove: Bool = Bool.random()

    var body: some View {
        HStack(spacing: 16) {
            BumbleProfileImageView(
                imageName: imageName,
                remaining: remaining,
                hasNewMessage: hasNewMessage
            )

            VStack(alignment: .leading, spacing: 4) {
                HStack(spacing: 0) {
                    Text(userName)
                        .font(.headline)
                        .foregroundStyle(.bumbleBlack)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    if isYourMove {
                        Text("Your move")
                            .font(.caption2)
                            .bold()
                            .padding(.vertical, 4)
                            .padding(.horizontal, 6)
                            .background(.bumbleYellow)
                            .cornerRadius(32)
                    }
                }

                if let lastChatMessage {
                    Text(lastChatMessage)
                        .font(.headline)
                        .foregroundStyle(.bumbleGray)
                        .lineLimit(1)
                        .padding(.trailing, 32)
                }
            }
        }
    }
}
