//
//  RedditViewModel.swift
//  iOS-Challenge
//
//  Created by Joseph Calla Moreyra on 9/09/21.
//

import Foundation

class RedditViewModel {
    var service = RedditPostService()
    var posts: [RedditPostResponse]?
    var dismissedId = [String]()
    
    var count: Int {
        if let entries = self.posts {
            return entries.filter({ $0.dismiss == false || $0.dismiss == nil }).count
        } else {
            return 0
        }
    }
    
    func getAllPosts(completion: @escaping () -> Void) {
        self.service.getAllPosts { data, error in
            self.posts = data
            completion()
        }
    }
}
