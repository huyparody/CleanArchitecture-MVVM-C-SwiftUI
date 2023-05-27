//
//  SearchRepoAPIRouter.swift
//  CleanArchitecture-MVVM-C-SwiftUI
//
//  Created by Huy Trinh Duc on 27/05/2023.
//

import UIKit
import Alamofire

enum SearchRepoAPIRouter {
    case searchRepo(param: [String: Any])
}

extension SearchRepoAPIRouter: APIInputBase {
    
    var headers: HTTPHeaders {
        var header = HTTPHeaders()
//        if requireToken {
//            header.add(.authorization(bearerToken: AuthenticationService.shared.getToken() ?? ""))
//        }
        header.add(.accept("application/json"))
        return header
    }
    
    var url: URL {
//        return Config.baseURL.appendingPathComponent(path)
        let baseURL = URL.init(string: "https://api.github.com/search/repositories")!
        return baseURL
    }
    
    var method: HTTPMethod {
        switch self {
        case .searchRepo:
            return .get
        }
    }
    
    var encoding: ParameterEncoding {
        return method == .get ? URLEncoding.default : JSONEncoding.default
    }
    
    
    var parameters: [String : Any]? {
        switch self {
        case .searchRepo(let param):
            return param
        }
    }
    
    var path: String {
        switch self {
        case .searchRepo:
            return ""
        }
    }
    
    var requireToken: Bool {
        switch self {
        case .searchRepo:
            return false
        }
    }
}
