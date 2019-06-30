//
//  MyService.swift
//  Repo Search
//
//  Created by AKIN on 28.06.2019.
//  Copyright © 2019 AKIN. All rights reserved.
//

import Foundation
import Moya

enum GitHub {
    case searchGitHub(query: String)
    case getBranches(url: String)
    case getContributors(url: String)
}

// MARK: - TargetType Protocol Implementation
extension GitHub: TargetType {
    var baseURL: URL {
        switch self {
        case .searchGitHub(let query):
        return URL(string: "https://api.github.com/search/repositories?q=\(query)")!
        case .getBranches(let url):
            return URL(string: "\(url)")!
        case .getContributors(let url):
            return URL(string: "\(url)")!
        }
    }
    var path: String {
        return ""
    }
    var method: Moya.Method {
        return .get
    }
    var task: Task {
        return .requestPlain
    }
    var sampleData: Data {
        return "[]".data(using: String.Encoding.utf8)!
    }
    var headers: [String: String]? {
        return nil
    }
}
// MARK: - Helpers
private extension String {
    var urlEscaped: String {
        return addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
    }
    
    var utf8Encoded: Data {
        return data(using: .utf8)!
    }
}
