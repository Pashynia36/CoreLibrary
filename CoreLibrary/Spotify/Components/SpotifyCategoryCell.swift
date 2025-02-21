//
//  SpotifyCategoryCell.swift
//  CoreLibrary
//
//  Created by Pavlo Novak on 2024-10-03.
//

import SwiftUI

struct SpotifyCategoryCell: View {
    let title: String
    var isSelected: Bool = false

    var body: some View {
        Text(title)
            .font(.callout)
            .frame(minWidth: 35)
            .padding(.vertical, 8)
            .padding(.horizontal, 10)
            .themeColors(isSelected: isSelected)
            .cornerRadius(16)
    }
}

#Preview {
    ZStack {
        Color.black.ignoresSafeArea()

        VStack(spacing: 40) {
            SpotifyCategoryCell(title: "All")
            SpotifyCategoryCell(title: "Music", isSelected: true)
            SpotifyCategoryCell(title: "Podcasts")
        }
    }
}
