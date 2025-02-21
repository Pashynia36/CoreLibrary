//
//  User.swift
//  CoreLibrary
//
//  Created by Pavlo Novak on 2024-10-01.
//

import Foundation

struct UserArray: Codable {
    let users: [User]
    let total, skip, limit: Int
}

struct User: Codable, Identifiable {
    let id: Int
    let firstName, lastName: String
    let age: Int
    let email, phone, username, password: String
    let image: String
    let height: Double
    let weight: Double

    var work: String {
        "Worker as Some Job"
    }
    
    var education: String {
        "Graduate Degree"
    }

    var aboutMe: String {
        "This is a sentence about me that will look good on my profile!"
    }

    var images: [String] {
        ["https://picsum.photos/500/500", "https://picsum.photos/600/600", "https://picsum.photos/700/700"]
    }

    var basics: [UserInterest] {
        [
            UserInterest(iconName: "ruler", emoji: nil, text: "\(height)"),
            UserInterest(iconName: "graduationcap", emoji: nil, text: education),
            UserInterest(iconName: "wineglass", emoji: nil, text: "Rarely"),
            UserInterest(iconName: "moon.stars.fill", emoji: nil, text: "Capricorn"),
        ]
    }

    var interests: [UserInterest] {
        [
            UserInterest(iconName: nil, emoji: "🚶", text: "Walking"),
            UserInterest(iconName: nil, emoji: "🎸", text: "Guitar"),
            UserInterest(iconName: nil, emoji: "🏋️", text: "Gym"),
            UserInterest(iconName: nil, emoji: "👨‍🍳", text: "Cooking"),
        ]
    }

    static var mock: User {
        User(
            id: 444,
            firstName: "Pasha",
            lastName: "Someone",
            age: 76,
            email: "hi@hi.com",
            phone: "",
            username: "",
            password: "",
            image: Constants.randomImage,
            height: 180,
            weight: 200
        )
    }
}
