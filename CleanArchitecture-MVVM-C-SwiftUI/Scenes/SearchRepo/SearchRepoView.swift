//
//  SearchRepoView.swift
//  CleanArchitecture-MVVM-C-SwiftUI
//
//  Created by Huy Trinh Duc on 27/05/2023.
//

import SwiftUI
import Stinsen

struct SearchRepoView: View {
    
    @StateObject var viewModel = SearchRepoViewModel()
    
    var body: some View {
        List {
            ForEach(viewModel.githubRepos, id: \.id) { repo in
                RepoRow(repo: repo)
                    .onTapGesture {
                        viewModel.pushToDetail(repo: repo)
                    }
            }
        }
        .searchable(text: $viewModel.searchText)
        .onReceiveError(viewModel.errorTracker.errorPublisher)
        .onReceiveLoading(viewModel.activityIndicator.isLoadingPublisher)
        .navigationTitle("Github repo")
    }
}

struct SearchRepoView_Previews: PreviewProvider {
    static var previews: some View {
        SearchRepoView()
    }
}
