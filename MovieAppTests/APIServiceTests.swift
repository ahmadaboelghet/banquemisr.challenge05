//
//  file.swift
//  MovieAppTests
//
//  Created by Ahmad Aboelghet on 19/07/2024.
//

import XCTest
@testable import MovieApp

class APIServiceTests: XCTestCase {
    var apiService: APIService!
    
    override func setUp() {
        super.setUp()
        apiService = APIService(apiKey: "43e7d10e3e1b3ad5d04792c6e6fdf58d")
        clearCache()
    }
    
    override func tearDown() {
        apiService = nil
        clearCache()
        super.tearDown()
    }
    
    func testFetchMoviesSuccess() {
        let expectation = self.expectation(description: "Fetching movies succeeds")
        
        apiService.fetchMovies(category: .nowPlaying) { result in
            switch result {
            case .success(let movies):
                XCTAssertNotNil(movies)
                XCTAssertGreaterThan(movies.count, 0)
            case .failure(let error):
                XCTFail("Error fetching movies: \(error.localizedDescription)")
            }
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testFetchMoviesFailure() {
      
        let invalidAPIService = APIService(apiKey: "43e7d10e3e1b3ad5d04792c6e6fdfd")
        
        let expectation1 = self.expectation(description: "Fetching movies fails with invalid API key and no cache")
        
        invalidAPIService.fetchMovies(category: .nowPlaying) { result in
            switch result {
            case .success(_):
                XCTFail("Fetching movies should fail with an invalid API key")
            case .failure(let error):
                XCTAssertNotNil(error)
            }
            expectation1.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
        let validAPIService = APIService(apiKey: "43e7d10e3e1b3ad5d04792c6e6fdf58d")
        let expectation2 = self.expectation(description: "Fetching movies succeeds with valid API key")
        
        validAPIService.fetchMovies(category: .nowPlaying) { result in
            switch result {
            case .success(let movies):
                XCTAssertNotNil(movies)
                XCTAssertGreaterThan(movies.count, 0)
            case .failure(let error):
                XCTFail("Error fetching movies: \(error.localizedDescription)")
            }
            expectation2.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
    
        let expectation3 = self.expectation(description: "Fetching movies returns cached data with invalid API key")
        
        invalidAPIService.fetchMovies(category: .nowPlaying) { result in
            switch result {
            case .success(let movies):
                XCTAssertNotNil(movies)
                XCTAssertGreaterThan(movies.count, 0)
            case .failure(let error):
                XCTFail("Fetching movies should return cached data even with an invalid API key")
            }
            expectation3.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    private func clearCache() {
        let keys = UserDefaults.standard.dictionaryRepresentation().keys.filter { $0.hasPrefix("MovieCache_") }
        keys.forEach { UserDefaults.standard.removeObject(forKey: $0) }
    }
}
