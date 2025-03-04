//
//  BumbleHomeView.swift
//  CoreLibrary
//
//  Created by Pavlo Novak on 2024-10-23.
//

import SwiftUI
import SwiftfulUI
import SwiftfulRouting

struct BumbleHomeView: View {

    var body: some View {
        ZStack {
            Color.bumbleWhite.ignoresSafeArea()

            VStack(spacing: 12) {
                header

                BumbleFilterView(selection: $selectedTab, tabs: tabs)
                    .background(Divider(), alignment: .bottom)

                Spacer()

//                BubmleCardView(user: .mock)

                ZStack {
                    if !allUsers.isEmpty {
                        ForEach(Array(allUsers.enumerated()), id: \.offset) { index, user in

                            let isCurrent = selectedIndex == index
                            let isNext = (selectedIndex + 1) == index
                            let isPrevious = (selectedIndex - 1) == index
                            if isPrevious || isCurrent || isNext {

                                let offsetValue = cardOffsets[user.id]

                                userProfileView(user: user, index: index)
                                    .zIndex(Double(allUsers.count - index))
                                    .offset(x: offsetValue == nil ? 0 : offsetValue == true ? 900 : -900)
                            }
                        }
                    } else {
                        ProgressView()
                    }

                    overlaySwipingIndicators
                        .zIndex(99999)
                }
                .frame(maxHeight: .infinity)
                .padding(4)
                .animation(.smooth, value: cardOffsets)
            }
            .padding(8)
        }
        .task {
            await getData()
        }
        .toolbar(.hidden, for: .navigationBar)
    }

    // MARK: - Private
    @State private var tabs: [String] = ["Everyone", "Trending"]
    @State private var allUsers: [User] = []
    @State private var selectedIndex: Int = 0
    @State private var cardOffsets: [Int: Bool] = [:] // [UserID: swiped right]
    @State private var currentSwipeOffset: CGFloat = 0

    @Environment(\.router) var router

    @AppStorage("bumble_home_filter") private var selectedTab: String = "Everyone"

    private var header: some View {
        HStack(spacing: 0) {
            HStack(spacing: 0) {
                Image(systemName: "line.horizontal.3")
                    .padding(8)
                    .background(Color.black.opacity(0.001))
                    .onTapGesture {

                    }

                Image(systemName: "arrow.uturn.left")
                    .padding(8)
                    .background(Color.black.opacity(0.001))
                    .onTapGesture {
                        router.dismissScreen()
                    }
            }
            .frame(maxWidth: .infinity, alignment: .leading)

            Text("bumble")
                .font(.title)
                .foregroundStyle(Color.bumbleYellow)
                .frame(maxWidth: .infinity, alignment: .center)

            Image(systemName: "slider.horizontal.3")
                .padding(8)
                .background(Color.black.opacity(0.001))
                .onTapGesture {
                    router.showScreen(.push) { _ in
                        BumbleChatView()
                    }
                }
                .frame(maxWidth: .infinity, alignment: .trailing)
        }
        .font(.title2)
        .fontWeight(.medium)
        .foregroundStyle(.bumbleBlack)
    }

    private var overlaySwipingIndicators: some View {
        ZStack {
            Circle()
                .fill(.bumbleGray.opacity(0.4))
                .overlay(
                    Image(systemName: "xmark")
                        .font(.title)
                        .fontWeight(.semibold)
                )
                .frame(width: 60, height: 60)
                .scaleEffect(abs(currentSwipeOffset) > 100 ? 1.5 : 1.0)
                .offset(x: min(-currentSwipeOffset, 150))
                .offset(x: -100)
                .frame(maxWidth: .infinity, alignment: .leading)

            Circle()
                .fill(.bumbleGray.opacity(0.4))
                .overlay(
                    Image(systemName: "checkmark")
                        .font(.title)
                        .fontWeight(.semibold)
                )
                .frame(width: 60, height: 60)
                .scaleEffect(abs(currentSwipeOffset) > 100 ? 1.5 : 1.0)
                .offset(x: max(-currentSwipeOffset, -150))
                .offset(x: 100)
                .frame(maxWidth: .infinity, alignment: .trailing)
        }
        .animation(.smooth, value: currentSwipeOffset)
    }

    private func userProfileView(user: User, index: Int) -> some View {
        BubmleCardView(user: user)
            .withDragGesture(
                .horizontal,
                minimumDistance: 10,
                resets: true,
                animation: .smooth,
                rotationMultiplier: 1.05,
                scaleMultiplier: 0.95,
                onChanged: { dragOffset in
                    currentSwipeOffset = dragOffset.width
                },
                onEnded: { dragOffset in
                    if dragOffset.width < -65 {
                        userDidSelect(index: index, isLike: false)
                    } else if dragOffset.width > 65 {
                        userDidSelect(index: index, isLike: true)
                    }
                }
            )
    }

    private func getData() async {
        guard allUsers.isEmpty else { return }
        do {
            allUsers = try await DBHelper().getUsers()
        } catch {

        }
    }

    private func userDidSelect(index: Int, isLike: Bool) {
        let user = allUsers[index]
        cardOffsets[user.id] = isLike

        selectedIndex += 1
    }
}
