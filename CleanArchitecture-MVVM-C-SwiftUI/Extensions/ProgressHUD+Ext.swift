//
//  ProgressHUD+Ext.swift
//  CleanArchitecture-MVVM-C-SwiftUI
//
//  Created by Huy Trinh Duc on 27/05/2023.
//

import Foundation
import ProgressHUD

extension ProgressHUD {
    
    static func commonLoading(_ willLoading: Bool) {
        if willLoading {
            self.colorBackground = .black.withAlphaComponent(0.25)
            self.show(interaction: false)
        }
        else {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self.dismiss()
            }
        }
        
    }
    
}
