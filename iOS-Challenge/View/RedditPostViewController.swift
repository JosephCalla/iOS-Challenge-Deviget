//
//  RedditPostViewController.swift
//  iOS-Challenge
//
//  Created by Joseph Calla Moreyra on 9/09/21.
//

import UIKit

class RedditPostViewController: UIViewController {
    @IBOutlet weak var redditPostTableView: UITableView!
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
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = redditPostTableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? RedditTableViewCell
        return cell!
    }
}

extension RedditPostViewController: UITableViewDelegate {
}
