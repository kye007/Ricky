//
//  RickMortyEpisode.swift
//  Morty
//
//  Created by George Kye on 2019-07-03.
//  Copyright © 2019 georgekye. All rights reserved.
//

import Foundation

public protocol RickMortyEpisodeType {
    /// The id of the episode.
    var id: Int { get }
    /// The name of the episode.
    var name: String { get }
    /// The code of the episode.
    var episode: String { get }
    /// List of characters who have been seen in the episode
    var characters: [String] { get }
    /// Link to the episode's own endpoint.
    var url: String { get }
    /// The air date of the episode.
    var airDate: String? { get }
    /// Time at which the episode was created in the database.
    var created: Date { get }
}

struct RickMortyEpisode: RickMortyEpisodeType, Decodable {
    let id: Int
    let name: String
    let episode: String
    let characters: [String]
    let url: String
    let airDate: String?
    let created: Date
    
    enum CodingKeys: String, CodingKey {
        case id, name
        case airDate = "air_date"
        case episode, characters, url, created
    }
}
