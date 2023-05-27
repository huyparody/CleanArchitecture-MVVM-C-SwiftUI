//
//  GithubRepoModel.swift
//  CleanArchitecture-MVVM-C-SwiftUI
//
//  Created by Huy Trinh Duc on 27/05/2023.
//

import UIKit
import ObjectMapper

struct GithubRepoModel: Mappable {
    
    var githubRepos: [GithubRepoEntities]?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        githubRepos <- map["items"]
    }
}

typealias Model = Mappable & Identifiable

struct GithubRepoEntities: Model {
    
    var id: Int?
    var name: String?
    var fullname: String?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
        fullname <- map["full_name"]
    }
    
    
}
