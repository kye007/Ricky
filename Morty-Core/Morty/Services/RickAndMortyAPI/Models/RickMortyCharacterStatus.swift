//
//  RickMortyCharacterStatus.swift
//  Morty
//
//  Created by George Kye on 2019-07-04.
//  Copyright © 2019 georgekye. All rights reserved.
//

import Foundation

public enum RickMortyCharacterStatus: String, Decodable {
    case alive = "Alive"
    case dead = "Dead"
    case unknown
}
