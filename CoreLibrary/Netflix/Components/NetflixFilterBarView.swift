//
//  NetflixFilterBarView.swift
//  CoreLibrary
//
//  Created by Pavlo Novak on 2024-11-15.
//

import SwiftUI

struct FilterModel: Hashable, Equatable {
    let title: String
    let isDropdown: Bool

    static var mockArray: [FilterModel] {
        [
            FilterModel(title: "TV Shows", isDropdown: false),
            FilterModel(title: "Movies", isDropdown: true),
            FilterModel(title: "Categotries", isDropdown: true)
        ]
    }
}

struct NetflixFilterBarView: View {

    var filters: [FilterModel] = FilterModel.mockArray
    var onXmarkPressed: (() -> Void)? = nil
    var onFilterPressed: ((FilterModel) -> Void)? = nil
    var selectedFilter: FilterModel? = nil

    var body: some View {
        ScrollView(.horizontal) {
            HStack {
                if selectedFilter != nil {
                    Image(systemName: "xmark")
                        .padding(8)
                        .background(
                            Circle()
                                .stroke(lineWidth: 1)
                        )
                        .foregroundStyle(.netflixLightGray)
                        .background(Color.black.opacity(0.001))
                        .onTapGesture {
                            onXmarkPressed?()
                        }
                        .transition(AnyTransition.move(edge: .leading))
                        .padding(.leading, 16)
                }

                ForEach(filters, id: \.self) { filter in
                    if selectedFilter == nil || selectedFilter == filter {
                        NetflixFilterView(
                            title: filter.title,
                            isDropdown: filter.isDropdown,
                            isSelected: selectedFilter == filter
                        )
                        .background(Color.black.opacity(0.001))
                        .onTapGesture {
                            onFilterPressed?(filter)
                        }
                        .padding(.leading, (selectedFilter == nil && filter == filters.first) ? 16 : 0)
                    }
                }
            }
            .padding(.vertical, 4)
        }
        .scrollIndicators(.hidden)
        .animation(.bouncy, value: selectedFilter)
    }
}
