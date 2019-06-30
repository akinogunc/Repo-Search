//
//  DetailViewModel.swift
//  Repo Search
//
//  Created by AKIN on 30.06.2019.
//  Copyright © 2019 AKIN. All rights reserved.
//

import UIKit
import Moya

class DetailViewModel {
    
    var branchesURL = ""
    var contributorsURL = ""
    var branches = [String]()
    var contributors = [Contributor]()

    init(branches : String, contributors : String) {
        self.branchesURL = branches
        self.contributorsURL = contributors
    }
    
    func getBranches(completion: @escaping () -> Void) {
        let provider = MoyaProvider<GitHub>()
        provider.request(.getBranches(url: branchesURL)) { result in
            switch result {
            case let .success(moyaResponse):
                self.parseBranches(array: try! moyaResponse.mapJSON() as! NSArray)
                self.getContributors {
                    completion()
                }
            case let .failure(error):
                print(error)
            }
        }
    }
    
    func getContributors(completion: @escaping () -> Void) {
        let provider = MoyaProvider<GitHub>()
        provider.request(.getContributors(url: contributorsURL)) { result in
            switch result {
            case let .success(moyaResponse):
                self.parseContributors(array: try! moyaResponse.mapJSON() as! NSArray)
                completion()
            case let .failure(error):
                print(error)
            }
        }
    }

    func parseBranches(array: NSArray){
        for i in 0..<array.count{
            let branch = array[i] as! [String : Any]
            branches.append(branch["name"] as! String)
        }
    }
    
    func parseContributors(array: NSArray){
        for i in 0..<array.count{
            if let contributor = Contributor(json: array[i] as! [String : Any]){
                contributors.append(contributor)
            }
        }
    }

}
