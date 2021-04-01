//
//  RealmUserModel.swift
//  UserManager
//
//  Created by Karen Madoyan on 2021/3/28.
//

import Foundation
import RealmSwift

class RealmUserModel: Object, Codable {
    @objc dynamic var id: Int = 0
    @objc dynamic var email: String?
    @objc dynamic var first_name: String?
    @objc dynamic var last_name: String?
    @objc dynamic var avatar: String?
}
