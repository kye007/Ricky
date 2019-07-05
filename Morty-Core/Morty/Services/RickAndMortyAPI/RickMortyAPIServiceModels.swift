//
//  RickMortyAPIServiceModels.swift
//  Morty
//
//  Created by George Kye on 2019-07-03.
//  Copyright © 2019 georgekye. All rights reserved.
//

import Foundation

public struct RickMortyAPIServiceModels {
    
    public struct ResponseInfo: Decodable {
        public let count: Int
        public let pages: Int
        public let next: String?
        public let prev: String?
    }
    
    public struct CharacterRequest {
        let characterURLReference: String
        
        public init(characterURLReference: String) {
            self.characterURLReference = characterURLReference
        }
    }
}
