//
//  Repository.swift
//  Repo Search
//
//  Created by AKIN on 30.06.2019.
//  Copyright © 2019 AKIN. All rights reserved.
//

import Foundation

struct Repository{
    
    let repoName        : String
    let repoNameShort   : String
    let repoDecription  : String
    let language        : String
    let stars           : String
    let branchesURL     : String
    let contributorsURL : String

    init(name : String, nameShort : String, description : String, language : String, stars : Int, branches : String, contributors : String){
        self.repoName        = name
        self.repoNameShort   = nameShort
        self.repoDecription  = description
        self.language        = language
        self.stars           = String(stars)
        self.branchesURL     = branches
        self.contributorsURL = contributors
    }
    
    init?(json: [String : Any]) {
        guard let name         = json["full_name"] as? String else { return nil }
        guard let nameShort    = json["name"] as? String else { return nil }
        guard let description  = json["description"] as? String else { return nil }
        guard let language     = json["language"] as? String else { return nil }
        guard let stars        = json["stargazers_count"] as? Int else { return nil }
        guard let branches     = json["branches_url"] as? String else { return nil }
        guard let contributors = json["contributors_url"] as? String else { return nil }
        self.init(name : name, nameShort : nameShort, description : description, language : language, stars : stars, branches : branches, contributors : contributors)
    }
    
}
