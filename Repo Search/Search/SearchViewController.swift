//
//  SearchViewController.swift
//  Repo Search
//
//  Created by AKIN on 28.06.2019.
//  Copyright © 2019 AKIN. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController, UISearchBarDelegate, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet var tableView: UITableView!
    var viewModel = SearchViewModel()
    var throttle: Timer?

    var searchText: String = "" {
        didSet {
            self.viewModel.searchRepos(query: self.searchText) {
                self.tableView.reloadData()
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        throttle?.invalidate()
        throttle = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false, block: { (timer) in
            self.searchText = self.searchBar.text!
        })
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.repos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "RepositoryCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! RepositoryCell
        
        cell.RepoName.text = viewModel.repos[indexPath.row].repoName
        cell.RepoDescription.text = viewModel.repos[indexPath.row].repoDecription
        cell.RepoLanguage.text = viewModel.repos[indexPath.row].language
        cell.RepoStars.text = "⭐" + viewModel.repos[indexPath.row].stars
        
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        searchBar.resignFirstResponder()
        
        let arr = viewModel.repos[indexPath.row].branchesURL.components(separatedBy:"{")
        let detailViewModel = DetailViewModel(branches: arr[0], contributors: viewModel.repos[indexPath.row].contributorsURL)
        
        detailViewModel.getBranches {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let detailViewController = storyboard.instantiateViewController(withIdentifier: "detail") as! DetailViewController
            detailViewController.title = self.viewModel.repos[indexPath.row].repoNameShort
            detailViewController.viewModel = detailViewModel
            self.navigationController?.pushViewController(detailViewController, animated: true)
        }
    }

}

