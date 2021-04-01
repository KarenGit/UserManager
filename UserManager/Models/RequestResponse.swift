//
//  RequestResponse.swift
//  UserManager
//
//  Created by Karen Madoyan on 2021/3/27.
//

struct RequestResponse: Codable {
    let page: Int!
    let perPage: Int!
    let total: Int!
    let totalPages: Int!
    let users: [User]!
    
    private enum CodingKeys: String, CodingKey {
        case page, perPage = "per_page", total, totalPages = "total_pages", users = "data"
    }
}
