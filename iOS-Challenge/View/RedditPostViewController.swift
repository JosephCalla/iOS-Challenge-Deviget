//
//  RedditPostViewController.swift
//  iOS-Challenge
//
//  Created by Joseph Calla Moreyra on 9/09/21.
//

import UIKit

class RedditPostViewController: UIViewController {
    @IBOutlet weak var redditPostTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.redditPostTableView.dataSource = self
        self.redditPostTableView.delegate = self
        self.redditPostTableView.register(
            UINib(nibName: "RedditTableViewCell", bundle: nil),
            forCellReuseIdentifier: "cell")
    }
}

extension RedditPostViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        guard let cell = redditPostTableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? RedditTableViewCell else { return UITableViewCell()}
        let cell = redditPostTableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? RedditTableViewCell
        return cell!
    }
}
extension RedditPostViewController: UITableViewDelegate {
}
