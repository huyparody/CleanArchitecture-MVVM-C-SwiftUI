//
//  DetailRepoViewModel.swift
//  CleanArchitecture-MVVM-C-SwiftUI
//
//  Created by Huy Trinh Duc on 27/05/2023.
//

import Foundation
import SwiftUI
import Combine
import Factory

class DetailRepoViewModel: ObservableObject {

    let activityIndicator = ActivityIndicator()
    let errorTracker = ErrorTracker()
    private var bag = Set<AnyCancellable>()
    
}
