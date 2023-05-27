//
//  GithubRepoRepository.swift
//  CleanArchitecture-MVVM-C-SwiftUI
//
//  Created by Huy Trinh Duc on 27/05/2023.
//

import Foundation
import Combine

protocol GithubRepositoryType {
    func searchRepo(query: String) -> AnyPublisher<[GithubRepoEntities], Error>
}

class GithubRepoRepository: GithubRepositoryType {
    
    func searchRepo(query: String) -> AnyPublisher<[GithubRepoEntities], Error> {
        
        let param: [String: Any] = [
            "q": query,
            "per_page": 10,
            "page": 1
        ]
        
        return APIService
            .shared
            .request(nonBaseResponse: SearchRepoAPIRouter.searchRepo(param: param))
            .tryMap { (response: GithubRepoModel) in
                return response.githubRepos ?? []
            }
            .eraseToAnyPublisher()
        
    }
    
}
