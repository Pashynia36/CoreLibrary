//
//  BubmleHeartView.swift
//  CoreLibrary
//
//  Created by Pavlo Novak on 2024-10-28.
//

import SwiftUI

struct BubmleHeartView: View {
    var body: some View {
        ZStack {
            Circle()
                .fill(.bumbleYellow)
                .frame(width: 40, height: 40)

            Image(systemName: "bubble.fill")
                .foregroundStyle(.bumbleBlack)
                .font(.system(size: 22))
                .offset(y: 2)

            Image(systemName: "heart.fill")
                .foregroundStyle(.bumbleYellow)
                .font(.system(size: 10))
        }
        .onTapGesture {

        }
    }
}
