//
//  MyListButton.swift
//  CoreLibrary
//
//  Created by Pavlo Novak on 2024-12-03.
//

import SwiftUI

struct MyListButton: View {

    var isInMyList: Bool = false
    var onButtonPressed: (() -> Void)? = nil

    var body: some View {
        VStack(spacing: 8) {
            ZStack {
                Image(systemName: "checkmark")
                    .opacity(isInMyList ? 1 : 0)
                    .rotationEffect(Angle(degrees: isInMyList ? 0 : 180))
                Image(systemName: "plus")
                    .opacity(isInMyList ? 0 : 1)
                    .rotationEffect(Angle(degrees: isInMyList ? -180 : 0))
            }
            .font(.title)

            Text("My List")
                .font(.caption)
                .foregroundStyle(.netflixLightGray)
        }
        .foregroundStyle(.netflixWhite)
        .padding(8)
        .background(Color.black.opacity(0.001))
        .animation(.bouncy, value: isInMyList)
        .onTapGesture {
            onButtonPressed?()
        }
    }
}
