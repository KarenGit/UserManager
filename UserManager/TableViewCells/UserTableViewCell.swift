//
//  UserTableViewCell.swift
//  UserManager
//
//  Created by Karen Madoyan on 2021/3/28.
//

import UIKit
import Kingfisher

class UserTableViewCell: UITableViewCell {
    @IBOutlet private weak var userPictureImageView: UIImageView!
    @IBOutlet private weak var userNameLabel: UILabel!
    @IBOutlet private weak var userEmailLabel: UILabel!
    var userModel: UserModel! {
        didSet {
            self.userPictureImageView.kf.setImage(with: self.userModel.avatar.url)
            self.userNameLabel.text = self.userModel.name
            self.userEmailLabel.text =  self.userModel.email
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
