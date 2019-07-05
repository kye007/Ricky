//
//  MortyTests.swift
//  MortyTests
//
//  Created by George Kye on 2019-07-03.
//  Copyright © 2019 georgekye. All rights reserved.
//

import XCTest
@testable import Morty

class MortyTests: XCTestCase {
    let http: HTTPServiceType = HTTPService()
}

extension MortyTests {
    
    func testInvalidURL() {
        let expectation = XCTestExpectation(description: "Test request")

        http.get(url: "@@--@@", parameters: [:], headers: [:]) {
            defer {
                expectation.fulfill()
            }
            do {
                let value = try $0.get()
                XCTAssertNil(value.data)
            } catch {
                XCTAssertNotNil(error, error.localizedDescription)
            }
        }
        
        wait(for: [expectation], timeout: 10.0)
    }
}

extension MortyTests {
    
    func testHTTPRequest() {
        let expectation = XCTestExpectation(description: "Test request")
        http.get(url: "https://rickandmortyapi.com/api/", parameters: [:], headers: [:]) {
            defer {
                expectation.fulfill()
            }
            do {
                let value = try $0.get()
                XCTAssertNotNil(value.data)
            } catch {
                XCTFail(error.localizedDescription)
            }
        }
        
        wait(for: [expectation], timeout: 10.0)
    }
}
