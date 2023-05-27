//
//  CleanArchitecture_MVVM_C_SwiftUIApp.swift
//  CleanArchitecture-MVVM-C-SwiftUI
//
//  Created by Huy Trinh Duc on 27/05/2023.
//

import SwiftUI

@main
struct CleanArchitecture_MVVM_C_SwiftUIApp: App {
    var body: some Scene {
        WindowGroup {
            MainCoordinator().view()
        }
    }
}
