//
//  DispatchQueue.swift
//  Morty
//
//  Created by George Kye on 2019-07-03.
//  Copyright © 2019 georgekye. All rights reserved.
//

import Foundation

extension DispatchQueue {
    static let labelPrefix = "com.morty"
}

extension DispatchQueue {
    /// A configure queue for executing parsing or decoding related work items.
    static let transform = DispatchQueue(label: "\(DispatchQueue.labelPrefix).transform", qos: .userInitiated)
}
