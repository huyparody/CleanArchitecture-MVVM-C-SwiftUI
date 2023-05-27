//
//  SearchRepoViewModel.swift
//  CleanArchitecture-MVVM-C-SwiftUI
//
//  Created by Huy Trinh Duc on 27/05/2023.
//

import Foundation
import SwiftUI
import Combine
import Factory
import Stinsen

class SearchRepoViewModel: ObservableObject {

    let activityIndicator = ActivityIndicator()
    let errorTracker = ErrorTracker()
    private var bag = Set<AnyCancellable>()
    @LazyInjected(\.githubUseCase) var useCase
    
    @Published var searchText = ""
    @Published var githubRepos = [GithubRepoEntities]()
    @RouterObject var router: SearchRepoCoordinator.Router?
    
    init() {
        
        $searchText
            .filter({!$0.isEmpty})
            .removeDuplicates()
            .debounce(for: .seconds(1.0), scheduler: DispatchQueue.main)
            .flatMap { [self] query in
                return useCase.searchRepo(query: query)
                    .receive(on: DispatchQueue.main)
                    .trackError(errorTracker)
                    .trackActivity(activityIndicator)
            }
            .assign(to: &$githubRepos)
        
    }
    
    func pushToDetail(repo: GithubRepoEntities) {
        router?.route(to: \.pushToDetail, repo)
    }
    
}
