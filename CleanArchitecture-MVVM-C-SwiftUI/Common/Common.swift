//
//  Common.swift
//  CleanArchitecture-MVVM-C-SwiftUI
//
//  Created by Huy Trinh Duc on 27/05/2023.
//

import Foundation
import SwiftMessages

class Common {
    
    static func showError(_ error: Error?) {
        if error != nil {
            if let error = error as? APIError {
                showSMErrorAlert(error.displayText)
            }
            else {
                let errorCode = (error as? NSError)?.code
                ///Error code = 13: NO interet connection
                
                if errorCode == 13 {
                    showSMErrorAlert("There is no internet connection", type: .warning)
                }
                else {
                    showSMErrorAlert(error?.localizedDescription ?? "")
                }
            }
        }
    }
    
    static func showSMErrorAlert(_ message: String, type: Theme = .error) {
        SwiftMessages.show {
            let view = MessageView.viewFromNib(layout: .tabView)
            view.configureTheme(type)
            view.configureContent(title: "", body: message)
            view.configureDropShadow()
            view.button?.isHidden = true
            return view
        }
    }
    
}
