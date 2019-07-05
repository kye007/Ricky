//
//  NetworkModels.swift
//  Morty
//
//  Created by George Kye on 2019-07-03.
//  Copyright © 2019 georgekye. All rights reserved.
//

import Foundation

public enum NetworkModels {
    
    public struct DataResponse {
        public let data: Data
        public let headers: [String: String]
        public let statusCode: Int
    }
}
