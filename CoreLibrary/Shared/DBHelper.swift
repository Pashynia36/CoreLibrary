//
//  DBHelper.swift
//  CoreLibrary
//
//  Created by Pavlo Novak on 2024-10-01.
//

import Foundation

struct DBHelper {
    func getProduct() async throws -> [Product] {
        guard let url = URL(string: Constants.randomProducts) else { throw URLError(.badURL) }

        let (data, _) = try await URLSession.shared.data(from: url)
        let products = try JSONDecoder().decode(ProductArray.self, from: data)
        return products.products
    }

    func getUsers() async throws -> [User] {
        guard let url = URL(string: Constants.randomUsers) else { throw URLError(.badURL) }

        let (data, _) = try await URLSession.shared.data(from: url)
        let users = try JSONDecoder().decode(UserArray.self, from: data)
        return users.users
    }
}
