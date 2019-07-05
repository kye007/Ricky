//
//  EpisodesAPITests.swift
//  MortyTests
//
//  Created by George Kye on 2019-07-03.
//  Copyright © 2019 georgekye. All rights reserved.
//

import XCTest
@testable import Morty

class EpisodesAPITests: XCTestCase {

    let apiService: RickMortyAPIServiceType = RickMortyAPINetworkService()
    
}

extension EpisodesAPITests {
    
    func testFetchEpisodes() {
        let expectation = XCTestExpectation(description: "Test episodes request")
        
        // When
        apiService.fetchEpisodes {

            // Then
            do {
                let value = try $0.get()
                XCTAssertNotNil(value.info)
                XCTAssertFalse(value.info.count == 0)
                XCTAssertFalse(value.episodes.isEmpty)
                XCTAssertTrue(value.info.pages >= 1)
                
                
                XCTAssertNotNil(value.episodes)
                XCTAssertNotNil(value.episodes.first?.name)
                XCTAssertNotNil(value.episodes.first?.airDate)
                XCTAssertNotNil(value.episodes.first?.characters)
                XCTAssertNotNil(value.episodes.first?.episode)
                XCTAssertNotNil(value.episodes.first?.id)
                XCTAssertNotNil(value.episodes.first?.created)

                // Given
                guard let foundEpisode = value.episodes.randomElement() else {
                    return XCTFail("Failed to find episode")
                }
                
                // When
                self.apiService.fetch(episode: foundEpisode.id) {
                    defer {
                        expectation.fulfill()
                    }
                    
                    do {
                        let episode = try $0.get()
                        
                        XCTAssertTrue(episode.id == foundEpisode.id)
                        XCTAssertTrue(episode.name == foundEpisode.name)
                        XCTAssertTrue(episode.airDate == foundEpisode.airDate)
                        XCTAssertTrue(episode.characters == foundEpisode.characters)
                    } catch {
                        XCTFail(error.localizedDescription)
                    }
                }
            } catch {
                XCTFail(error.localizedDescription)
            }
        }
        
        wait(for: [expectation], timeout: 10.0)
    }
}
