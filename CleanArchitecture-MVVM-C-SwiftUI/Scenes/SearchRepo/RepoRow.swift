//
//  RepoRow.swift
//  CleanArchitecture-MVVM-C-SwiftUI
//
//  Created by Huy Trinh Duc on 27/05/2023.
//

import SwiftUI

struct RepoRow: View {
    
    var repo: GithubRepoEntities
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(repo.fullname ?? "")
                    .font(.headline)
                
                Text(repo.name ?? "")
                    .font(.subheadline)
            }
            Spacer()
        }
        .contentShape(Rectangle())
    }
}

