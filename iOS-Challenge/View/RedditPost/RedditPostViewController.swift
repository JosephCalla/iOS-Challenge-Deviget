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
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var postImage: UIImageView!
    
    private var refreshControl = UIRefreshControl()
    private var selectedPostIndex = 0
    var viewModel = RedditViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        pullToRefresh()
        loadFirstPage()
    }
    
    private func setupView() {
        self.redditPostTableView.dataSource = self
        self.redditPostTableView.delegate = self
        self.redditPostTableView.register(UINib(nibName: "RedditTableViewCell",
                                                bundle: nil), forCellReuseIdentifier: "cell")
    }
    
    private func pullToRefresh() {
        refreshControl.tintColor = .lightGray
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh!", attributes: [.foregroundColor: UIColor.white])
        refreshControl.addTarget(self, action: #selector(refreshPosts), for: UIControl.Event.valueChanged)
        redditPostTableView.addSubview(refreshControl)
    }
    
    @objc func refreshPosts() {
        loadFirstPage()
    }
    
    private func loadFirstPage() {
        loadSpineer.startAnimating()
        viewModel.getAllPosts(true) { data, _ in
            DispatchQueue.main.async {
                self.redditPostTableView.isHidden = false
                self.loadSpineer.stopAnimating()
                self.redditPostTableView.reloadData()
                print("PRINT")
                self.refreshControl.endRefreshing()
            }
            if (data?.isEmpty == true) {
                self.getNextPage()
                return
            }
        }
    }
    
    
    private func dismissPost(cell: RedditTableViewCell) {
        guard let index = redditPostTableView.indexPath(for: cell) else { return }
        redditPostTableView.beginUpdates()
        redditPostTableView.deleteRows(at: [index], with: .fade)
        viewModel.posts?.remove(at: index.item)
        redditPostTableView.endUpdates()
    }
    
    private func dismissAllPost() {
        viewModel.posts?.removeAll()
        getNextPage()
    }
    
    private func getNextPage() {
        loadSpineer.startAnimating()
        viewModel.getAllPosts(false) { _,_ in
            DispatchQueue.main.async {
                self.redditPostTableView.reloadData()
                self.loadSpineer.stopAnimating()
                self.redditPostTableView.isHidden = false
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
    
    @IBAction func dismissAll(_ sender: UIButton) {
        viewModel.posts = []
        dismissAllPost()
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
        cell?.dismissCell = { [weak self] (cell) in
            self?.dismissPost(cell: cell)
        }
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedPostIndex = indexPath.item
        (tableView.cellForRow(at: indexPath) as? RedditTableViewCell)?.hideUnRead()
        if UIDevice.current.userInterfaceIdiom == .phone {
            if let posts = viewModel.posts?[indexPath.row] {
                DispatchQueue.main.async {
                    self.performSegue(withIdentifier: "detail", sender: self)
                    tableView.reloadRows(at: [indexPath], with: UITableView.RowAnimation.fade)
                    
                }} } else {
                    if let posts = viewModel.posts?[indexPath.row] {
                        DispatchQueue.main.async {
                            self.authorLabel.text = posts.author
                            self.titleLabel.text = posts.title
                            self.postImage.setImageFrom(link: posts.thumbnail)
                            tableView.reloadRows(at: [indexPath], with: UITableView.RowAnimation.fade)
                        }
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
