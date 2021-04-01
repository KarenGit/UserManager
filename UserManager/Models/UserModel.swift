//
//  UserModel.swift
//  UserManager
//
//  Created by Karen Madoyan on 2021/3/28.
//

import Foundation

struct UserModel {
    var user: User
    
    var id: Int {
        return self.user.id
    }
    
    var name: String {
        return self.user.firstName ?? ""
    }
    
    var fullName: String {
        return (self.user.firstName ?? "") + " " + (self.user.lastName ?? "")
    }
    
    var email: String {
        return self.user.email
    }
    
    var avatar: String {
        return self.user.avatar
    }
    
    init(user: User) {
        self.user = user
    }
}
