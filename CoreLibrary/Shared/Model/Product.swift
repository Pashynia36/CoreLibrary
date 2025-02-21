//
//  Product.swift
//  CoreLibrary
//
//  Created by Pavlo Novak on 2024-10-01.
//

import Foundation

struct ProductArray: Codable {
    let products: [Product]
    let total, skip, limit: Int
}

struct Product: Codable, Identifiable {
    let id: Int
    let title, description: String
    let price: Double
    let discountPercentage, rating: Double
    let stock: Int
    let brand: String?
    let category: String
    let thumbnail: String
    let images: [String]

    var firstImage: String {
        images.first ?? Constants.randomImage
    }

    var _brand: String {
        brand ?? ""
    }

    var recentlyAdded: Bool? = {
        return Int.random(in: 1...4) == 1
    }()

    static var mock: Product {
        Product(
            id: 123,
            title: "Example product title",
            description: "This is some mock product description that goes here.",
            price: 999,
            discountPercentage: 15,
            rating: 4.5,
            stock: 50,
            brand: "Apple",
            category: "Electronic Devices",
            thumbnail: Constants.randomImage,
            images: [Constants.randomImage, Constants.randomImage, Constants.randomImage]
        )
    }
}

struct ProductRow: Identifiable {
    let id = UUID().uuidString
    let title: String
    let products: [Product]
}
