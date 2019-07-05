//
//  RickMortyEpisodes.swift
//  Morty
//
//  Created by George Kye on 2019-07-03.
//  Copyright © 2019 georgekye. All rights reserved.
//

import Foundation

public protocol RickMortyEpisodesType {
    var info: RickMortyAPIServiceModels.ResponseInfo { get }
    var episodes: [RickMortyEpisodeType] { get }
}

struct RickMortyEpisodes: RickMortyEpisodesType, Decodable {
    let info: RickMortyAPIServiceModels.ResponseInfo
    let episodes: [RickMortyEpisodeType]
    
    enum CodingKeys: String, CodingKey {
        case info
        case results
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.info = try container.decode(RickMortyAPIServiceModels.ResponseInfo.self, forKey: .info)
        self.episodes = try container.decode([RickMortyEpisode].self, forKey: .results)
    }
}
