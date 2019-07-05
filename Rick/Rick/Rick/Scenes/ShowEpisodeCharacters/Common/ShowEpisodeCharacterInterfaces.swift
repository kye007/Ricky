//
//  ShowEpisodeCharactersInterfaces.swift
//  Rick
//
//  Created by George Kye on 2019-07-04.
//  Copyright © 2019 georgekye. All rights reserved.
//

import Morty

protocol ShowEpisodeCharactersController {
    var apiClient: RickMortyAPIServiceType { get }
    func loadCharacters()
}

protocol ShowEpisodeCharactersDisplayable {
    func display(episode: EpisodeViewModel)
    func display(characters models: [RickMortyCharacterType])
}

protocol ShowEpisodeCharactersRouterAble {
    func show(character: CharacterViewModel)
}
