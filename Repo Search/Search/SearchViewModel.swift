//
//  SearchViewModel.swift
//  Repo Search
//
//  Created by AKIN on 30.06.2019.
//  Copyright © 2019 AKIN. All rights reserved.
//

import UIKit
import Moya

class SearchViewModel {
    
    var repos = [Repository]()

    func searchRepos(query: String, completion: @escaping () -> Void) {
        let provider = MoyaProvider<GitHub>()
        provider.request(.searchGitHub(query: query)) { result in
            switch result {
            case let .success(moyaResponse):
                self.parseRepos(json: try! moyaResponse.mapJSON() as! [String : Any])
                completion()
            case let .failure(error):
                print(error)
            }
        }
    }
    
    func parseRepos(json: [String : Any]){
        repos.removeAll()
        if let data = json["items"] {
            for object in (data as? [Any])!{
                if let repo = Repository(json: object as! [String : Any]){
                    repos.append(repo)
                }
            }
        }
    }
}
