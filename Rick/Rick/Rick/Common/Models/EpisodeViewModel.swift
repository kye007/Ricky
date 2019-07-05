//
//  EpisodeViewModel.swift
//  Rick
//
//  Created by George Kye on 2019-07-04.
//  Copyright © 2019 georgekye. All rights reserved.
//

import Foundation
import Morty

struct EpisodeViewModel {
    let name: String
    let episodeMeta: String
    let airDate: String
    
    let object: RickMortyEpisodeType
    
    init(_ episode: RickMortyEpisodeType) {
        self.name = episode.name
        self.episodeMeta = episode.episode
        self.airDate = episode.airDate ?? ""
        
        self.object = episode
    }
}
