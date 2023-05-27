//
//  APIInputBase.swift
//  CleanArchitecture-MVVM-C-SwiftUI
//
//  Created by Huy Trinh Duc on 27/05/2023.
//

import Foundation
import Alamofire

protocol APIInputBase {
    var headers: HTTPHeaders { get }
    var url: URL { get }
    var method: HTTPMethod { get }
    var encoding: ParameterEncoding { get }
    var parameters: [String: Any]? { get }
    var requireToken: Bool { get }
}
