//
//  Extensions+View.swift
//  CoreLibrary
//
//  Created by Pavlo Novak on 2024-10-10.
//

import SwiftUI

extension View {
    func themeColors(isSelected: Bool) -> some View {
        self
            .background(isSelected ? .spotifyGreen : .spotifyDarkGray)
            .foregroundColor(isSelected ? .spotifyBlack : .spotifyWhite)
    }
}
