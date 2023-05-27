//
//  APIService.swift
//  CleanArchitecture-MVVM-C-SwiftUI
//
//  Created by Huy Trinh Duc on 27/05/2023.
//

import Foundation
import Alamofire
import ObjectMapper
import Combine

struct NetworkManager {
    
    static let kRequestTimeOut: TimeInterval = 30
    
    static let session: Session = {
        let configuration: URLSessionConfiguration = {
            let config = URLSessionConfiguration.default
            config.timeoutIntervalForRequest = kRequestTimeOut
            config.timeoutIntervalForResource = kRequestTimeOut
            config.httpMaximumConnectionsPerHost = 10
            return config
        }()
        let session = Session(configuration: configuration, serverTrustManager: nil)
        return session
    }()
    
}

class APIService {
    
    private let session = NetworkManager.session
    
    static let shared: APIService = {
        let instance = APIService()
        return instance
    }()
    
    func request<T: Mappable>(nonBaseResponse input: APIInputBase) -> Future<T, Error> {
        
        return Future { promise in
            self.session.request(
                input.url,
                method: input.method,
                parameters: input.parameters,
                encoding: input.encoding,
                headers: input.headers)
            .responseData(queue: .global(qos: .background)) { dataRequest in
                switch dataRequest.result {
                case .success(let value):
                    do {
                        let any = try JSONSerialization.jsonObject(with: value)
                        if let dict = any as? [String: Any], let json = T.init(JSON: dict) {
                            if dataRequest.response?.statusCode == 200 {
                                promise(.success(json))
                            }
                            else {
                                promise(.failure(APIError.error(code: dataRequest.response?.statusCode ?? 0, message: "Something wrong, try again!")))
                            }
                        }
                        else {
                            promise(.failure(APIError.invalidResponseData(data: value)))
                        }
                    }
                    catch {
                        promise(.failure(APIError.invalidResponseData(data: value)))
                    }
                case .failure(let error):
                    promise(.failure(error))
                }
            }
        }
    }
}
