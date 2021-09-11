//
//  RedditViewModel.swift
//  iOS-Challenge
//
//  Created by Joseph Calla Moreyra on 9/09/21.
//

import Foundation

class RedditViewModel {
    var service = RedditPostService()
    var posts: [RedditPostResponse]? = []
    var postsIdDeleted: [RedditPostResponse] = []
    var dismissedId = [String]()
    
    var count: Int {
        if let entries = self.posts {
            return entries.filter({ $0.dismiss == false || $0.dismiss == nil }).count
        } else {
            return 0
        }
    }
    
    func getAllPosts(_ firstPage: Bool, completion:  @escaping ([RedditPostResponse]?, String?) -> ()) {
        self.posts = []
        self.service.getAllPosts(firstPage) { data, error in
            for item in data! {
                if !self.postsIdDeleted.contains(item) {
                    self.posts?.append(item)
                }
            }
            completion(data, error)
        }
    }
    
    func deletePost(post: RedditPostResponse){
        self.postsIdDeleted.append(post)
    }
}
