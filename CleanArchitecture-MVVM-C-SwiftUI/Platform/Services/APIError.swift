//
//  APIError.swift
//  CleanArchitecture-MVVM-C-SwiftUI
//
//  Created by Huy Trinh Duc on 27/05/2023.
//

import Foundation

enum APIError: Error {
    case error(code: Int, message: String)
    case invalidResponseData(data: Any)
    case unknown
    
    public var displayText: String {
        switch self {
        case .invalidResponseData:
            return "Invalid response"
        case .error(_, let message):
            //switch errorResponseCode
            return message
        case .unknown:
            return "Unknown error"
        }
    }
    
    public var code: Int {
        switch self {
        case .error(let code, _):
            return code
        default :
            return 0
        }
    }
}

//enum StatusCode: String {
//    
//    case success = "HTTP_OK"
//    case emailUsed = "EMAIL_COMPANY_USED"
//    case unAuthorized = "HTTP_UNAUTHORIZED"
//    case invalidAccount = "INVALID_ACCOUNT"
//    case forbidden = "HTTP_FORBIDDEN"
//    case notFound = "HTTP_NOT_FOUND"
//    
//}
