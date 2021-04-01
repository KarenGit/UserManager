//
//  UIViewController+PushPop.swift
//  UserManager
//
//  Created by Karen Madoyan on 2021/3/28.
//

import UIKit

extension UIViewController {
    func push(_ viewController: UIViewController, _ animated: Bool = true) {
        self.navigationController?.pushViewController(viewController, animated: animated)
    }
    
    func pop(_ animated: Bool = true) {
        self.navigationController?.popViewController(animated: animated)
    }
}
