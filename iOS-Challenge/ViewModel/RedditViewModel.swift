//
//  RedditViewModel.swift
//  iOS-Challenge
//
//  Created by Joseph Calla Moreyra on 9/09/21.
//

import Foundation

class RedditViewModel {
    var service = RedditPostService()
    
    func getAllPosts(completion: @escaping () -> Void) {
        self.service.getAllPosts {
            completion()
        }
    }
}
