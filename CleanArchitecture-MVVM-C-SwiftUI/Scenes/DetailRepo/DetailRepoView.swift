//
//  DetailRepoView.swift
//  CleanArchitecture-MVVM-C-SwiftUI
//
//  Created by Huy Trinh Duc on 27/05/2023.
//

import SwiftUI

struct DetailRepoView: View {
    
    @EnvironmentObject var router: SearchRepoCoordinator.Router
    @StateObject var viewModel = DetailRepoViewModel()
    
    var repo: GithubRepoEntities
    
    var body: some View {
        Text(repo.fullname ?? "")
            .navigationTitle(repo.name ?? "")
    }
}

struct DetailRepoView_Previews: PreviewProvider {
    static var previews: some View {
        DetailRepoView(repo: .init(JSON: [:])!)
    }
}
