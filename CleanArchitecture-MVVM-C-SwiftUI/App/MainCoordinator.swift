//
//  MainCoordinator.swift
//  CleanArchitecture-MVVM-C-SwiftUI
//
//  Created by Huy Trinh Duc on 27/05/2023.
//

import Foundation
import Stinsen
import SwiftUI

final class MainCoordinator: NavigationCoordinatable {
    
    var stack: Stinsen.NavigationStack<MainCoordinator>
    
    @Root var searchRepo = makeSearchRepo
    
    init() {
        stack = NavigationStack(initial: \MainCoordinator.searchRepo)
    }
    
    @ViewBuilder func sharedView(_ view: AnyView) -> some View {
        view
            .onAppear {
                self.root(\.searchRepo)
            }
    }
    
    func customize(_ view: AnyView) -> some View {
        sharedView(view)
    }

}

extension MainCoordinator {
    
    func makeSearchRepo() -> NavigationViewCoordinator<SearchRepoCoordinator> {
        NavigationViewCoordinator(SearchRepoCoordinator())
    }
    
}
