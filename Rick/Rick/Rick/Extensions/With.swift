//
//  With.swift
//  Rick
//
//  Created by George Kye on 2019-07-04.
//  Copyright © 2019 georgekye. All rights reserved.
//

import Foundation

public protocol With {}

public extension With where Self: Any {
    
    /// Makes it available to set properties with closures just after initializing.
    ///
    ///     let label = UILabel().with {
    ///       $0.textAlignment = .center
    ///       $0.textColor = UIColor.black
    ///       $0.text = "Hello, World!"
    ///     }
    @discardableResult
    func with(_ block: (Self) -> Void) -> Self {
        // https://github.com/devxoul/Then
        block(self)
        return self
    }
}

extension NSObject: With {}
