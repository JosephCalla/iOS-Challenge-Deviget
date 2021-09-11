//
//  RedditPostViewController.swift
//  iOS-Challenge
//
//  Created by Joseph Calla Moreyra on 9/09/21.
//

import UIKit

class RedditPostViewController: UIViewController {
    @IBOutlet weak var redditPostTableView: UITableView!
    @IBOutlet weak var loadSpineer: UIActivityIndicatorView!
    
    private var refreshControl = UIRefreshControl()
    private var selectedPostIndex = 0
    let viewModel = RedditViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        getPosts()
    }
    
    private func setupView() {
        self.redditPostTableView.dataSource = self
        self.redditPostTableView.delegate = self
        
        self.redditPostTableView.register(UINib(nibName: "RedditTableViewCell",
                                                bundle: nil), forCellReuseIdentifier: "cell")
    }
    
    private func getPosts() {
        viewModel.getAllPosts {
            DispatchQueue.main.async {
                self.redditPostTableView.reloadData()
            }
        }
    }
}

extension RedditPostViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.posts?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = redditPostTableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? RedditTableViewCell
        let post = viewModel.posts?[indexPath.row]
        cell?.post = post
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedPostIndex = indexPath.item
        if let posts = viewModel.posts?[indexPath.row] {
            DispatchQueue.main.async {
                self.performSegue(withIdentifier: "detail", sender: self)
                tableView.reloadRows(at: [indexPath], with: UITableView.RowAnimation.fade)
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detail" {
            if let indexPath = redditPostTableView.indexPathForSelectedRow {
                guard let post = viewModel.posts?[indexPath.row] else { return }
                let controller = (segue.destination) as! DetailPostViewController
                controller.postDetail = post
            }
        }
    }
}


extension RedditPostViewController: UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    }
}
