//
//  RickMortyCharacterType.swift
//  Morty
//
//  Created by George Kye on 2019-07-04.
//  Copyright © 2019 georgekye. All rights reserved.
//

import Foundation

public protocol RickMortyCharacterType {
    /// The id of the character.
    var id: Int { get }
    /// The name of the character.
    var name: String { get }
    /// The status of the character ('Alive', 'Dead' or 'unknown').
    var status: RickMortyCharacterStatus { get }
    /// The species of the character.
    var species: String { get }
    /// Name and link to the character's origin location.
    var type: String { get }
    /// Name and link to the character's last known location endpoint.
    var gender: String { get }
    /// Name and link to the character's origin location.
    var origin: RickMortyLocation { get }
    /// Name and link to the character's last known location endpoint.
    var location: RickMortyLocation { get }
    /// Link to the character's image. All images are 300x300px and most are medium shots or portraits since they are intended to be used as avatars.
    var image: String { get }
    /// List of episodes in which this character appeared.
    var episode: [String] { get }
    /// Link to the character's own URL endpoint.
    var url: String { get }
    /// Time at which the characters was created in the database.
    var created: Date { get }
}

struct RickMortyCharacter: RickMortyCharacterType, Decodable {
    public let id: Int
    public let name: String
    public let status: RickMortyCharacterStatus
    public let species: String
    public let type: String
    public let gender: String
    public let origin: RickMortyLocation
    public let location: RickMortyLocation
    public let image: String
    public let episode: [String]
    public let url: String
    public let created: Date
}
