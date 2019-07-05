//
//  JSONDecoder.swift
//  Morty
//
//  Created by George Kye on 2019-07-04.
//  Copyright © 2019 georgekye. All rights reserved.
//

import Foundation

public extension JSONDecoder {
    
    var `default`: JSONDecoder {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .formatted(Formatter.iso8601)
        return decoder
    }
}

extension Formatter {
    
    static let iso8601: DateFormatter = {
        //https://stackoverflow.com/a/47601082
        let formatter = DateFormatter()
        formatter.calendar = Calendar(identifier: .iso8601)
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSXXXXX"
        return formatter
    }()
}
