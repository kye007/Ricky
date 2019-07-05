//
//  ListEpisodesInterfaces.swift
//  Rick
//
//  Created by George Kye on 2019-07-04.
//  Copyright © 2019 georgekye. All rights reserved.
//

import Foundation
import Morty

protocol ListEpisodesController {
    var apiClient: RickMortyAPIServiceType { get }
    func loadEpisodes()
}

protocol ListEpisdeControllerDisplayable {
    func display(episodes model: RickMortyEpisodesType)
}

protocol ListEpisodesRouterAble {
    func showCharacters(episode: EpisodeViewModel)
}
