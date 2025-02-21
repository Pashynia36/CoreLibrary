//
//  BumbleChatView.swift
//  CoreLibrary
//
//  Created by Pavlo Novak on 2024-11-12.
//

import SwiftUI

struct BumbleChatView: View {

    var body: some View {
        ZStack {
            Color.bumbleWhite.ignoresSafeArea()

            VStack(spacing: 0) {
                header
                    .padding(16)

                matchQueueSection

                recentChatsSection

                Spacer()
            }
        }
        .task {
            await getData()
        }
        .toolbar(.hidden, for: .navigationBar)
    }

    @State private var allUsers: [User] = []

    private var header: some View {
        HStack(spacing: 0) {
            Image(systemName: "line.horizontal.3")
            Spacer(minLength: 0)
            Image(systemName: "magnifyingglass")
        }
        .font(.title)
        .fontWeight(.medium)
    }

    private var matchQueueSection: some View {
        VStack(alignment: .leading, spacing: 8) {
            Group {
                Text("Match Queue")
                +
                Text(" (\(allUsers.count))")
                    .foregroundStyle(.bumbleGray)
            }
            .padding(.horizontal, 16)

            ScrollView(.horizontal) {
                LazyHStack(spacing: 16) {
                    ForEach(allUsers) { user in
                        BumbleProfileImageView(
                            imageName: user.image
                        )
                    }
                }
                .padding(.horizontal, 16)
            }
            .scrollIndicators(.hidden)
            .frame(height: 100)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }

    private var recentChatsSection: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack(spacing: 0) {
                Group {
                    Text("Chats")
                    +
                    Text(" (Recent)")
                        .foregroundStyle(.bumbleGray)
                }
                Spacer(minLength: 0)
                Image(systemName: "line.horizontal.3.decrease")
                    .font(.title2)
            }
            .padding(.horizontal, 16)

            ScrollView(.vertical) {
                LazyVStack(spacing: 16) {
                    ForEach(allUsers) { user in
                        BumbleChatPreviewView(
                            imageName: user.images.randomElement() ?? user.image,
                            userName: user.firstName,
                            lastChatMessage: user.aboutMe
                        )
                    }
                }
                .padding(16)
            }
            .scrollIndicators(.hidden)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }

    private func getData() async {
        guard allUsers.isEmpty else { return }
        do {
            allUsers = try await DBHelper().getUsers()
        } catch {

        }
    }
}
