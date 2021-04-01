//
//  RealmManager.swift
//  UserManager
//
//  Created by Karen Madoyan on 2021/3/28.
//

import RealmSwift

struct RealmManager {
    static func addUserModel(_ user: User) -> RealmUserModel {
        let realmUserModel = RealmUserModel()
        realmUserModel.id = user.id
        realmUserModel.email = user.email
        realmUserModel.first_name = user.firstName
        realmUserModel.last_name = user.lastName
        realmUserModel.avatar = user.avatar
        
        return realmUserModel
    }
}
