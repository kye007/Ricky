//
//  HTTPService.swift
//  Morty
//
//  Created by George Kye on 2019-07-03.
//  Copyright © 2019 georgekye. All rights reserved.
//

import Foundation

public struct HTTPService: HTTPServiceType {
    
    enum HTTPMethod: String {
        case GET
        case POST
    }
    
    public init() {}
}

private extension HTTPService {

    func request(_ method: HTTPMethod, url: String, parameters: [String : Any], headers: [String : String]?, completion: @escaping (Result<NetworkModels.DataResponse, NetworkError>) -> Void) {

        guard let requestURL = URL(string: url) else {
            return DispatchQueue.main.async {
                print("Error: Invalid URL = \(url))")
                completion(.failure(NetworkError(statusCode: 0)))
            }
        }

        var request = URLRequest(url: requestURL)

        switch method {
        case .GET:
            request = URLRequest(
                url: requestURL.appendingQueryItems(parameters)
            )
        case .POST:
            request = URLRequest(url: requestURL)
            do {
                let body = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
                request.httpBody = body
            } catch {
                DispatchQueue.main.async {
                        completion(.failure(
                            NetworkError(
                                urlRequest: request,
                                statusCode: 0,
                                internalError: error
                            ))
                    )
                }
            }
        }
        
        request.httpMethod = method.rawValue
        
       let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            DispatchQueue.main.async {
                guard let data_ = data,
                    let response_ = response as? HTTPURLResponse else {
                        return DispatchQueue.main.async {
                            let err = NetworkError(
                                urlRequest: request,
                                statusCode: (response as? HTTPURLResponse)?.statusCode ?? 0,
                                headerValues: [:],
                                serverData: data,
                                internalError: error
                            )
                            completion(.failure(err))
                        }
                }
                
                completion(.success(
                        NetworkModels.DataResponse(
                        data: data_,
                        headers: [:], //TODO:
                        statusCode: response_.statusCode))
                )
            }
        }
        
        task.resume()
    }
}

public extension HTTPService {
    
    func get(url: String, parameters: [String : Any], headers: [String : String]?, completion: @escaping (Result<NetworkModels.DataResponse, NetworkError>) -> Void) {
        request(.GET, url: url, parameters: parameters, headers: headers) {
            completion($0)
        }
    }
    
    func post(url: String, parameters: [String : Any], headers: [String : String]?, completion: @escaping (Result<NetworkModels.DataResponse, NetworkError>) -> Void) {
        request(.POST, url: url, parameters: parameters, headers: headers) {
            completion($0)
        }
    }
}
