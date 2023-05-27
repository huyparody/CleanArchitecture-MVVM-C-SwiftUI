//
//  AppDelegate+Injected.swift
//  CleanArchitecture-MVVM-C-SwiftUI
//
//  Created by Huy Trinh Duc on 27/05/2023.
//

import Foundation
import Factory

extension Container {
    
    var githubRepository: Factory<GithubRepositoryType> {
        self {
            GithubRepoRepository()
        }
    }
    
    var githubUseCase: Factory<GithubRepoUseCaseType> {
        self {
            GithubRepoUseCase()
        }
    }
    
}
