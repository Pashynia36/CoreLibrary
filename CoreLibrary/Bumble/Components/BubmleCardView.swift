//
//  BubmleCardView.swift
//  CoreLibrary
//
//  Created by Pavlo Novak on 2024-10-28.
//

import SwiftUI
import SwiftfulUI

struct BubmleCardView: View {

    var user: User = .mock

    var body: some View {
        ScrollView(.vertical) {
            LazyVStack(spacing: 0) {
                headerView
                    .frame(height: headerFrame.height)

                aboutMeSection
                    .padding(.horizontal, 24)
                    .padding(.vertical, 24)

                locationSection
                    .padding(.horizontal, 24)
                    .padding(.vertical, 24)

                myInterestsSection
                    .padding(.horizontal, 24)
                    .padding(.vertical, 24)

                ForEach(user.images, id: \.self) { image in
                    ImageLoaderView(urlString: image)
                        .frame(height: headerFrame.height)
                }

                buttonsSection
            }
        }
        .scrollIndicators(.hidden)
        .background(.bumbleBackgroundYellow)
        .overlay(
            superLikeButton
            , alignment: .bottomTrailing
        )
        .cornerRadius(32)
        .readingFrame { frame in
            headerFrame = frame
        }
    }

    // MARK: - Private

    @State private var headerFrame: CGRect = .zero

    private var headerView: some View {
        ZStack(alignment: .bottomLeading) {
            ImageLoaderView(urlString: user.image)

            VStack(alignment: .leading, spacing: 8) {
                Text("\(user.firstName), \(user.age)")
                    .font(.largeTitle)
                    .fontWeight(.semibold)

                HStack(spacing: 4) {
                    Image(systemName: "suitcase")
                    Text(user.work)
                }

                HStack(spacing: 4) {
                    Image(systemName: "graduationcap")
                    Text(user.education)
                }

                BubmleHeartView()
            }
            .padding(24)
            .font(.callout)
            .fontWeight(.medium)
            .foregroundStyle(.bumbleWhite)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(
                LinearGradient(
                    colors: [
                        .bumbleBlack.opacity(0),
                        .bumbleBlack.opacity(0.6),
                        .bumbleBlack.opacity(0.6)
                    ],
                    startPoint: .top,
                    endPoint: .bottom
                )
            )
        }
    }

    private var aboutMeSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            sectionTitle(title: "About Me")

            Text(user.aboutMe)
                .font(.body)
                .fontWeight(.semibold)
                .foregroundStyle(.bumbleBlack)

            HStack(spacing: 0) {
                BubmleHeartView()

                Text("Send a compliment")
                    .font(.caption)
                    .fontWeight(.semibold)
            }
            .padding([.horizontal, .trailing], 8)
            .background(.bumbleYellow)
            .cornerRadius(32)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }

    private var locationSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack(spacing: 8) {
                Image(systemName: "mappin.and.ellipse.circle.fill")
                Text(user.firstName + "'s Location")
            }
            .foregroundStyle(.bumbleGray)
            .font(.body)
            .fontWeight(.medium)

            Text("10 Kilometers away")
                .font(.headline)
                .foregroundStyle(.bumbleBlack)

            InterestPillView(iconName: nil, emoji: "🇨🇭", text: "Lives in Zug, Suisse")
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }

    private var myInterestsSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            VStack(alignment: .leading, spacing: 8) {
                sectionTitle(title: "Basics")
                InterestPillGridView(interests: user.basics)
            }

            VStack(alignment: .leading, spacing: 8) {
                sectionTitle(title: "My interests")
                InterestPillGridView(interests: user.interests)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }

    private var buttonsSection: some View {
        VStack(spacing: 20) {
            HStack(spacing: 0) {
                Button {
                    // action
                } label: {
                    Circle()
                        .fill(.bumbleYellow)
                        .overlay(
                            Image(systemName: "xmark")
                                .font(.title)
                                .fontWeight(.semibold)
                                .foregroundStyle(.bumbleBlack)
                        )
                        .frame(width: 60, height: 60)
                }

                Spacer(minLength: 0)

                Button {
                    // action
                } label: {
                    Circle()
                        .fill(.bumbleYellow)
                        .overlay(
                            Image(systemName: "checkmark")
                                .font(.title)
                                .fontWeight(.semibold)
                                .foregroundStyle(.bumbleBlack)
                        )
                        .frame(width: 60, height: 60)
                }

            }
        }
    }

    private var superLikeButton: some View {
        Button {
            // action
        } label: {
            Image(systemName: "hexagon.fill")
                .foregroundStyle(.bumbleYellow)
                .font(.system(size: 60))
                .overlay(
                    Image(systemName: "star.fill")
                        .foregroundStyle(.bumbleBlack)
                        .font(.system(size: 30, weight: .medium))
                )
                .padding(24)
        }
    }

    private func sectionTitle(title: String) -> some View {
        Text(title)
            .font(.body)
            .foregroundStyle(.bumbleGray)
    }
}
