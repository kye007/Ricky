//
//  HTTPServiceType.swift
//  Morty
//
//  Created by George Kye on 2019-07-03.
//  Copyright © 2019 georgekye. All rights reserved.
//

import Foundation

public protocol HTTPServiceType {
    func get(url: String, parameters: [String: Any], headers: [String: String]?, completion: @escaping (Swift.Result<NetworkModels.DataResponse, NetworkError>) -> Void)
    func post(url: String, parameters: [String: Any], headers: [String: String]?, completion: @escaping (Swift.Result<NetworkModels.DataResponse, NetworkError>) -> Void)
}
