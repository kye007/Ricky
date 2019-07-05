//
//  URL.swift
//  Morty
//
//  Created by George Kye on 2019-07-03.
//  Copyright © 2019 georgekye. All rights reserved.
//

import Foundation

public extension URL {
    
    /// Returns a URL constructed by appending the given query string parameters to self.
    ///
    /// - Parameter contentsOf: a dictionary of query string parameters to modify
    /// - Returns: the URL with the appended query string
    func appendingQueryItems(_ contentsOf: [String: Any?]) -> URL {
        guard var urlComponents = URLComponents(string: absoluteString), !contentsOf.isEmpty else {
            return self
        }
        
        let keys = contentsOf.keys.map { $0.lowercased() }
        
        urlComponents.queryItems = urlComponents.queryItems?
            .filter { !keys.contains($0.name.lowercased()) } ?? []
        
        urlComponents.queryItems?.append(contentsOf: contentsOf.compactMap {
            guard let value = $0.value else { return nil } //Skip if nil
            return URLQueryItem(name: $0.key, value: "\(value)")
        })
        
        return urlComponents.url ?? self
    }
}
