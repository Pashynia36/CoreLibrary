//
//  RateButton.swift
//  CoreLibrary
//
//  Created by Pavlo Novak on 2024-12-03.
//

import SwiftUI

enum RateOption: String, CaseIterable {
    case like, dislike, love

    var title: String {
        switch self {
        case .dislike:
            return "Not for me"
        case .like:
            return "I like this"
        case .love:
            return "I love this!"
        }
    }

    var iconName: String {
        switch self {
        case .dislike:
            return "hand.thumbsdown"
        case .like:
            return "hand.thumbsup"
        case .love:
            return "bolt.heart"
        }
    }
}

struct RateButton: View {

    var onRatingSelected: ((RateOption) -> Void)? = nil

    var body: some View {
        VStack(spacing: 8) {
                Image(systemName: "hand.thumbsup")
            .font(.title)

            Text("Rate")
                .font(.caption)
                .foregroundStyle(.netflixLightGray)
        }
        .foregroundStyle(.netflixWhite)
        .padding(8)
        .background(Color.black.opacity(0.001))
        .onTapGesture {
            showPopover.toggle()
        }
        .popover(isPresented: $showPopover) {
            ZStack {
                Color.netflixDarkGray.ignoresSafeArea()

                HStack(spacing: 12) {
                    ForEach(RateOption.allCases, id: \.self) { option in
                        rateButton(option: option)
                    }
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
            }
            .presentationCompactAdaptation(.popover)
        }
    }

    private func rateButton(option: RateOption) -> some View {
        VStack(spacing: 8) {
            Image(systemName: option.iconName)
                .font(.title2)
            Text(option.title)
                .font(.caption)
        }
        .foregroundStyle(.netflixWhite)
        .padding(4)
        .background(Color.black.opacity(0.001))
        .onTapGesture {
            showPopover = false
            onRatingSelected?(option)
        }
    }

    @State private var showPopover: Bool = false
}
