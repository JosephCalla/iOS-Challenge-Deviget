//
//  RedditPostResponse.swift
//  iOS-Challenge
//
//  Created by Joseph Calla Moreyra on 9/09/21.
//
import Foundation
struct RedditPost: Codable {
    
    let id: String
    let author: String
    let title: String
    let thumbnail: String
    let url: String
    let num_comments: Int
    let created_utc: TimeInterval
    
}
