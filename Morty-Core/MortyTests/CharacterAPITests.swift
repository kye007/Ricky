//
//  CharacterAPITests.swift
//  MortyTests
//
//  Created by George Kye on 2019-07-04.
//  Copyright © 2019 georgekye. All rights reserved.
//

import XCTest
@testable import Morty

class CharacterAPITests: XCTestCase {
    
    let apiService: RickMortyAPIServiceType = RickMortyAPINetworkService()
    
}

extension CharacterAPITests {
    
    func testFetchCharacter() {
        let expectation = XCTestExpectation(description: "Test episodes request")

        // When
        apiService.fetchEpisodes {
            // Then
            do {
                let value = try $0.get()
                // Given
                guard let characterURL = value.episodes.randomElement()?.characters.randomElement() else {
                    return XCTFail("Failed to find character")
                }
                
                // When
                let request = RickMortyAPIServiceModels.CharacterRequest(
                    characterURLReference: characterURL
                )
                self.apiService.fetch(character: request) {
                    defer {
                        expectation.fulfill()
                    }
                    
                    do {
                        let character = try $0.get()
                        XCTAssertTrue(character.url == characterURL)
                        XCTAssertNotNil(character.image)
                        XCTAssertNotNil(character.episode)
                        XCTAssertNotNil(character.gender)
                        XCTAssertNotNil(character.status)
                        XCTAssertNotNil(character.gender)
                        XCTAssertNotNil(character.created)
                    } catch {
                        XCTFail(error.localizedDescription)
                    }
                }
            } catch {
                XCTFail(error.localizedDescription)
            }
        }
        
        wait(for: [expectation], timeout: 60.0)
    }
}
