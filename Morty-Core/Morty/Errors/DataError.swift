//
//  DataError.swift
//  Morty
//
//  Created by George Kye on 2019-07-03.
//  Copyright © 2019 georgekye. All rights reserved.
//

import Foundation

public enum DataError: Error {
    case unknownError(Error?)
    case parseFailure(Error?)
    case networkError(NetworkError?)
}

extension DataError {
    var localizedDescription: String {
        switch self {
        case .unknownError:
            return "There was an error with your request. Please try again later."
        case .parseFailure:
            return "The response from the server could not be read."
        case .networkError:
           return "There was an error with your request."
        }
    }
}
