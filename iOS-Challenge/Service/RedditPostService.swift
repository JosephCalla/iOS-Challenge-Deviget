//
//  RedditPostService.swift
//  iOS-Challenge
//
//  Created by Joseph Calla Moreyra on 9/09/21.
//

import Foundation

class RedditPostService {
    typealias PostsResponse = ([RedditPostResponse]?, String?) -> ()
    
    let defaultSession = URLSession(configuration: .default)
    var dataTask: URLSessionDataTask?
    var errorMessage: String = ""
    let baseURL = "https://www.reddit.com/top.json"
    var posts = [PostsResponse]()
    
    func getAllPosts(_ completion: @escaping PostsResponse) {
        getPostsURL(after: nil, before: nil) {[unowned self] (data, errorMessage) in
            guard errorMessage == nil || (errorMessage?.isEmpty)! else { return }
            completion(data, errorMessage)
        }
    }
    
    func getPostsURL(after: String?, before: String?, completion: @escaping PostsResponse) {
        dataTask?.cancel()
        guard let  url = URL(string: baseURL) else { return }
        dataTask = URLSession.shared.jsonDecodableTask(with: url) { (result: Result<RedditResponse, Error>) in
            switch result {
            case .success(let response):
                var post: [RedditPostResponse]?
                post = response.data.children.map { $0.data }
                print("Response --> \(post)")
                completion(post, nil)
                
            case .failure(let error):
                print(error)
                completion(nil, error.localizedDescription)
                
            }
        }
        dataTask?.resume()
    }
}
