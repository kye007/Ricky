//
//  CharacterViewModel.swift
//  Rick
//
//  Created by George Kye on 2019-07-04.
//  Copyright © 2019 georgekye. All rights reserved.
//

import Morty

struct CharacterViewModel {
    let name: String
    let species: String
    let origin: String
    let profileIconURL: String
    
    let object: RickMortyCharacterType
    
    init(_ character: RickMortyCharacterType) {
        self.name = character.name
        self.species = character.species
        self.origin = character.origin.name
        self.profileIconURL = character.image
        
        self.object = character
    }
}
