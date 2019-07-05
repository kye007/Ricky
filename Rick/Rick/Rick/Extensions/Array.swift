//
//  Array.swift
//  Rick
//
//  Created by George Kye on 2019-07-04.
//  Copyright © 2019 georgekye. All rights reserved.
//

import Foundation

public extension Array {
    
    /// Element at the given index if it exists.
    ///
    /// - Parameter index: index of element.
    /// - Returns: optional element (if exists).
    func get(_ index: Int) -> Element? {
        guard startIndex..<endIndex ~= index else { return nil }
        return self[index]
    }
}
