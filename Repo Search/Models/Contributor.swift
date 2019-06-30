//
//  Contributor.swift
//  Repo Search
//
//  Created by AKIN on 30.06.2019.
//  Copyright © 2019 AKIN. All rights reserved.
//

import Foundation

struct Contributor {
    
    let name      : String
    let avatarURL : String
    
    init(name : String, avatarURL : String){
        self.name      = name
        self.avatarURL = avatarURL
    }
    
    init?(json: [String : Any]) {
        guard let name      = json["login"] as? String else { return nil }
        guard let avatarURL = json["avatar_url"] as? String else { return nil }
        self.init(name : name, avatarURL : avatarURL)
    }
    
}
