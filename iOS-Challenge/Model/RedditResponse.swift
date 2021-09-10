//
//  File.swift
//  iOS-Challenge
//
//  Created by Joseph Calla Moreyra on 9/09/21.
//
import Foundation
struct RedditResponse: Codable {
    let data: RedditData
}

struct RedditData: Codable {
    struct RedditChildrenData: Codable {
        let data: RedditPostResponse
    }
    let children: [RedditChildrenData]
    let after: String

}
