//
//  BumbleFilterView.swift
//  CoreLibrary
//
//  Created by Pavlo Novak on 2024-10-24.
//

import SwiftUI

struct BumbleFilterView: View {

    @Binding var selection: String

    var tabs: [String] = ["Everyone", "Trending"]

    var body: some View {
        HStack(alignment: .top, spacing: 32) {
            ForEach(tabs, id: \.self) { tab in
                VStack(spacing: 8) {
                    Text(tab)
                        .frame(maxWidth: .infinity)
                        .font(.subheadline)
                        .fontWeight(.medium)

                    if selection == tab {
                        RoundedRectangle(cornerRadius: 2)
                            .frame(height: 1.5)
                            .matchedGeometryEffect(id: "selection", in: namespace)
                    }
                }
                .padding(.top, 8)
                .background(Color.black.opacity(0.001))
                .foregroundStyle(selection == tab ? .bumbleBlack : .bumbleGray)
                .onTapGesture {
                    selection = tab
                }
            }
        }
        .animation(.smooth, value: selection)
    }

    // MARK: - Private
    @Namespace private var namespace
}
