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
    var redditData: RedditData?
    var posts = [PostsResponse]()
    
    func getAllPosts(_ firstPage: Bool,_ completion: @escaping PostsResponse) {
        getPostsURL(firstPage: firstPage) {[unowned self] (data, errorMessage) in
            guard errorMessage == nil || (errorMessage?.isEmpty)! else { return }
            completion(data, errorMessage)
        }
    }
    
    func getPostsURL(firstPage: Bool = false, completion: @escaping PostsResponse) {
        dataTask?.cancel()
        var urlComponents = URLComponents(string: baseURL)
        
        urlComponents?.queryItems = [ URLQueryItem(name: "after", value: firstPage ? "" : redditData?.after) ]
        let url = urlComponents?.url
            
        dataTask = URLSession.shared.jsonDecodableTask(with: url!) { [weak self] (result: Result<RedditResponse, Error>) in
            switch result {
            case .success(let response):
                var post: [RedditPostResponse]?
                self?.redditData = response.data
                post = response.data.children.map { $0.data }
                
                completion(post, nil)
                
            case .failure(let error):
                print(error)
                completion(nil, error.localizedDescription)
                
            }
        }
        dataTask?.resume()
    }
}
