//
//  RedditPostResponse.swift
//  iOS-Challenge
//
//  Created by Joseph Calla Moreyra on 9/09/21.
//
import Foundation
struct RedditPostResponse: Codable {
    let id: String
    let author: String
    let title: String
    let thumbnail: String
    let url: String
    let num_comments: Int
    let created_utc: TimeInterval
    
    var read: Bool? = false
    var dismiss: Bool? = false
    
}
extension RedditPostResponse: Equatable {
    static func == (lhs: RedditPostResponse, rhs: RedditPostResponse) -> Bool {
        return lhs.id == rhs.id
    }
}
