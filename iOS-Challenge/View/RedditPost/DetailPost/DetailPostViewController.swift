//
//  DetailPostViewController.swift
//  iOS-Challenge
//
//  Created by Joseph Calla Moreyra on 10/09/21.
//

import UIKit

class DetailPostViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var postImage: UIImageView!
    @IBOutlet weak var authorLabel: UILabel!
    
    var postDetail: RedditPostResponse!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard postDetail != nil else { return }

        setupView(post: postDetail!)
    }
    
    func setupView(post: RedditPostResponse) {
        self.titleLabel?.text = post.title
        self.authorLabel?.text = post.author
        self.postImage?.setImageFrom(link: post.thumbnail)
    }
}
