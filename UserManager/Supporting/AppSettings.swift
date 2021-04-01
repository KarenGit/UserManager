//
//  AppSettings.swift
//  UserManager
//
//  Created by Karen Madoyan on 2021/3/28.
//

import Foundation
import RealmSwift

class AppSettings {
    static let shared: AppSettings = AppSettings()
    
    var realm = try! Realm()
}
