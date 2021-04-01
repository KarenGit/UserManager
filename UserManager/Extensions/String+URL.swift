//
//  String+URL.swift
//  UserManager
//
//  Created by Karen Madoyan on 2021/3/28.
//

import Foundation

extension String {
    var url: URL {
        URL(string: self)!
    }
}
