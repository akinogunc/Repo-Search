//
//  DetailViewController.swift
//  Repo Search
//
//  Created by AKIN on 30.06.2019.
//  Copyright © 2019 AKIN. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var viewModel : DetailViewModel!
    @IBOutlet var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "ContributorCell", bundle: nil), forCellReuseIdentifier: "contributor")
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0{
            return viewModel.branches.count
        }else{
            return viewModel.contributors.count
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String?
    {
        if section == 0{
            return "BRANCHES"
        }else{
            return "CONTRIBUTORS"
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0{
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            cell.textLabel?.text = viewModel.branches[indexPath.row]
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "contributor") as! ContributorCell
            cell.name.text = viewModel.contributors[indexPath.row].name
            cell.setImage(url: viewModel.contributors[indexPath.row].avatarURL)
            return cell
        }
    }
}
