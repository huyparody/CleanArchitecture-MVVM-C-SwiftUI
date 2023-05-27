//
//  SearchRepoCoordinator.swift
//  CleanArchitecture-MVVM-C-SwiftUI
//
//  Created by Huy Trinh Duc on 27/05/2023.
//

import Foundation
import Stinsen
import SwiftUI

final class SearchRepoCoordinator: NavigationCoordinatable {

    let stack = NavigationStack(initial: \SearchRepoCoordinator.start)
    
    @Root var start = makeStart
    @Route(.push) var pushToDetail = makeDetail
    
}

extension SearchRepoCoordinator {
    
    @ViewBuilder func makeStart() -> some View {
        SearchRepoView()
    }
    
    @ViewBuilder func makeDetail(repo: GithubRepoEntities) -> some View {
        DetailRepoView(repo: repo)
    }
    
}

