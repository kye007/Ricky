//
//  RickMortyAPIServiceType.swift
//  Morty
//
//  Created by George Kye on 2019-07-03.
//  Copyright © 2019 georgekye. All rights reserved.
//

import Foundation

public protocol RickMortyAPIServiceType {
    func fetchEpisodes(completion: @escaping (Result<RickMortyEpisodesType, DataError>) -> Void)
    func fetch(episode episodeID: Int, completion: @escaping (Result<RickMortyEpisodeType, DataError>) -> Void)
    func fetch(character request: RickMortyAPIServiceModels.CharacterRequest, completion: @escaping (Result<RickMortyCharacterType, DataError>) -> Void)

}

public struct RickMortyAPINetworkService {
    var httpService: HTTPServiceType
    
   public init(httpService: HTTPServiceType = HTTPService()) {
        self.httpService = httpService
    }
}

private extension RickMortyAPINetworkService {
    
    func get(_ endpoint: RickMortyAPINetworkService.EndPoint, completion: @escaping (Swift.Result<NetworkModels.DataResponse, NetworkError>) -> Void) {
        httpService.get(url: endpoint.url, parameters: endpoint.parameters, headers: [:]) {
            completion($0)
        }
    }
}


// MARK: - Episode
extension RickMortyAPINetworkService: RickMortyAPIServiceType {
    
    ///  Access the list of episodes
    public func fetchEpisodes(completion: @escaping (Result<RickMortyEpisodesType, DataError>) -> Void) {
        get(.episodes) {
            do {
                let response = try $0.get()
                DispatchQueue.transform.async {
                    do {
                        let response = try JSONDecoder().default.decode(
                            RickMortyEpisodes.self,
                            from: response.data
                        )
                        DispatchQueue.main.async {
                            completion(.success(response))
                        }
                    } catch {
                        print("An error occured while parsing a episodes: \(error).")
                        DispatchQueue.main.async {
                            completion(.failure(DataError.parseFailure(error)))
                        }
                    }
                }
            } catch {
                print(error.localizedDescription)
                completion(.failure(DataError.unknownError(error)))
            }
        }
    }
    
    public func fetch(episode episodeID: Int, completion: @escaping (Result<RickMortyEpisodeType, DataError>) -> Void) {
        get(.episode(episodeID)) {
            do {
                let response = try $0.get()
                DispatchQueue.transform.async {
                    do {
                        let response = try JSONDecoder().default.decode(
                            RickMortyEpisode.self,
                            from: response.data
                        )
                        DispatchQueue.main.async {
                            completion(.success(response))
                        }
                    } catch {
                        print("An error occured while parsing a episode with ID \(episodeID): \(error).")
                        DispatchQueue.main.async {
                            completion(.failure(DataError.parseFailure(error)))
                        }
                    }
                }
            } catch {
                print(error.localizedDescription)
                completion(.failure(DataError.unknownError(error)))
            }
        }
    }
}

// MARK: - Character
extension RickMortyAPINetworkService {
    public func fetch(character request: RickMortyAPIServiceModels.CharacterRequest, completion: @escaping (Result<RickMortyCharacterType, DataError>) -> Void) {
        get(.character(urlReference: request.characterURLReference)) {
            do {
                let response = try $0.get()
                DispatchQueue.transform.async {
                    do {
                        let response = try JSONDecoder().default.decode(
                            RickMortyCharacter.self,
                            from: response.data
                        )
                        
                        DispatchQueue.main.async {
                            completion(.success(response))
                        }
                    } catch {
                        print("An error occured while parsing a character with reference \(request.characterURLReference): \(error).")
                        DispatchQueue.main.async {
                            completion(.failure(DataError.parseFailure(error)))
                        }
                    }
                }
            } catch {
                print(error.localizedDescription)
                completion(.failure(DataError.unknownError(error)))
            }
        }
    }
}

// MARK: - API Endpoint

private extension RickMortyAPINetworkService {
    
    enum EndPoint {
        case episodes
        case episode(Int)
        case episodeUrlReference(String)
        case character(urlReference: String)
        
        private var path: String {
            switch self {
            case .episodes:
                return "episode"
            case .episode(let id):
                return "episode/\(id)"
            case .episodeUrlReference(_):
                return "episode"
            case .character(urlReference: _):
                return "character"
            }
        }
        
        private var baseURL: String {
            return "https://rickandmortyapi.com/api/"
        }
        
        var parameters: [String: String] {
            switch self {
            case .episodes: return [:]
            case .episode(_) : return [:]
            case .character(urlReference: _): return [:]
            default: return [:]
            }
        }
        
        var url: String {
            switch self {
            case .episodeUrlReference(let url):
                return url
            case .character(urlReference: let url):
                return url
            default:
                return URL(string: baseURL)?.appendingPathComponent(path).absoluteString
                    ?? (baseURL + "/" + path)
            }
        }
    }
}
