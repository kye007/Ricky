//
//  NetworkError.swift
//  Morty
//
//  Created by George Kye on 2019-07-03.
//  Copyright © 2019 georgekye. All rights reserved.
//

import Foundation

/// The NetworkError type represents an error object returned from the API server.
public struct NetworkError: Error {
    let urlRequest: URLRequest?
    let headerValues: [String: String]
    let serverData: Data?
    public let statusCode: Int
    public let internalError: Error?
    
    /// The initializer for the network error type.
    ///
    /// - Parameters:
    ///   - urlRequest: The URL that was requested.
    ///   - statusCode: The HTTP status code response from the network server.
    ///   - headerValues: The HTTP headers response from the network server.
    ///   - serverData: The HTTP body response from the network server.
    ///   - internalError: The internal error from the network request.
    public init(
        urlRequest: URLRequest? = nil,
        statusCode: Int,
        headerValues: [String: String] = [String: String](),
        serverData: Data? = nil,
        internalError: Error? = nil)
    {
        self.urlRequest = urlRequest
        self.statusCode = statusCode
        self.headerValues = headerValues
        self.serverData = serverData
        self.internalError = internalError
    }
}
