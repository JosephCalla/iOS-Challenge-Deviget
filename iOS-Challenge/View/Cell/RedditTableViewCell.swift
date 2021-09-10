//
//  RedditTableViewCell.swift
//  iOS-Challenge
//
//  Created by Joseph Calla Moreyra on 9/09/21.
//

import UIKit

class RedditTableViewCell: UITableViewCell {
    @IBOutlet weak var readNotificationImage: UIImageView!
    @IBOutlet weak var hoursAgoLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var postImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var commentsLabel: UILabel!
    @IBOutlet weak var removeCellButton: UIButton!
    @IBOutlet weak var removeLabel: UILabel!
    
    var post: RedditPostResponse? {
        didSet { setupCell(post: post)
        }
    }
    var hoursAgo = String()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        postImage.image = UIImage(named: "noImageFound")
    }
    
    func setupCell(post: RedditPostResponse?) {
        self.titleLabel.text = post?.title
        self.hoursAgoLabel.text = hoursAgo.timeAgo(post?.created_utc ?? 0.01)
        self.authorLabel.text = post?.author
        self.postImage.setImageFrom(link: post?.thumbnail)
        self.commentsLabel.text = "\(post?.num_comments ?? 0) comments"
    }
}
