//
//  User.swift
//  UserManager
//
//  Created by Karen Madoyan on 2021/3/27.
//

struct User : Codable {
    let id: Int!
    let email: String!
    let firstName: String!
    let lastName: String!
    let avatar: String!
    
    private enum CodingKeys: String, CodingKey {
        case id, email, firstName = "first_name", lastName = "last_name", avatar
    }
}
