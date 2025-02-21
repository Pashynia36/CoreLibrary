//
//  InterestPillView.swift
//  CoreLibrary
//
//  Created by Pavlo Novak on 2024-10-31.
//

import SwiftUI

struct InterestPillView: View {

    var iconName: String? = "heart.fill"
    var emoji: String? = "☠️"
    var text: String = "Graduate degree"

    var body: some View {
        HStack(spacing: 4){
            if let iconName {
                Image(systemName: iconName)
            } else if let emoji {
                Text(emoji)
            }

            Text(text)
        }
        .font(.callout)
        .fontWeight(.medium)
        .padding(.vertical, 6)
        .padding(.horizontal, 12)
        .foregroundStyle(.bumbleBlack)
        .background(.bumbleLightYellow)
        .cornerRadius(32)
    }
}
