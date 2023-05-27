//
//  GithubRepoUseCase.swift
//  CleanArchitecture-MVVM-C-SwiftUI
//
//  Created by Huy Trinh Duc on 27/05/2023.
//

import Foundation
import Factory
import Combine

protocol GithubRepoUseCaseType {
    func searchRepo(query: String) -> AnyPublisher<[GithubRepoEntities], Error>
}

class GithubRepoUseCase: GithubRepoUseCaseType {
    
    @LazyInjected(\.githubRepository) var repository
    
    func searchRepo(query: String) -> AnyPublisher<[GithubRepoEntities], Error>  {
        repository.searchRepo(query: query)
    }
    
}
