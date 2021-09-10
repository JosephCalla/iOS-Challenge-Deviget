//
//  RedditTableViewCell.swift
//  iOS-Challenge
//
//  Created by Joseph Calla Moreyra on 9/09/21.
//

import UIKit

class RedditTableViewCell: UITableViewCell {
    @IBOutlet weak var readNotificationImage: UIImageView!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var postImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var commentsLabel: UILabel!
    @IBOutlet weak var removeCellButton: UIButton!
    @IBOutlet weak var removeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        postImage.image = UIImage(named: "noImageFound")
    }
}
