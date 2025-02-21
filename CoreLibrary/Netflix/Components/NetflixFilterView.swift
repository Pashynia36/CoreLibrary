//
//  NetflixFilterView.swift
//  CoreLibrary
//
//  Created by Pavlo Novak on 2024-11-15.
//

import SwiftUI

struct NetflixFilterView: View {

    var title: String = "Categories"
    var isDropdown: Bool = true
    var isSelected: Bool = false

    var body: some View {
        HStack(spacing: 4) {
            Text(title)

            if isDropdown {
                Image(systemName: "chevron.down")
            }
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 8)
        .background(
            ZStack {
                Capsule(style: .circular)
                    .fill(.netflixDarkGray)
                    .opacity(isSelected ? 1 : 0)

                Capsule(style: .circular)
                    .stroke(lineWidth: 1)
            }
        )
        .foregroundStyle(.netflixLightGray)
    }
}
