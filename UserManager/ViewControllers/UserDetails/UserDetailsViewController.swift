//
//  UserDetailsPageViewController.swift
//  UserManager
//
//  Created by Karen Madoyan on 2021/3/28.
//

import UIKit
import Kingfisher


class UserDetailsViewController: UIViewController {
    @IBOutlet private weak var userPictureImageView: UIImageView!
    @IBOutlet private weak var userFullNameLabel: UILabel!
    @IBOutlet private weak var userEmailTitleLabel: UILabel!
    @IBOutlet private weak var userEmailLabel: UILabel!
    var userDetailsViewModel: UserDetailsViewModel!
//    var userModel: UserModel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.cofigureView()
    }
    
    
    // MARK: - Private Methods -
    
    private func cofigureView() {
        self.userPictureImageView.kf.setImage(with: self.userDetailsViewModel.userModel.avatar.url)
        self.userFullNameLabel.text = self.userDetailsViewModel.userModel.fullName
        self.userEmailTitleLabel.text = "Email:"
        self.userEmailLabel.text = self.userDetailsViewModel.userModel.email
    }
}
