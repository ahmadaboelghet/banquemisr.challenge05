//
//  MovieRepositoryTests.swift
//  MovieAppTests
//
//  Created by Ahmad Aboelghet on 19/07/2024.
//

import XCTest
@testable import MovieApp

class MockAPIService: APIService {
    var shouldReturnError = false
    var mockMovies: [Movie] = []

    override func fetchMovies(category: MovieCategory, completion: @escaping (Result<[Movie], APIError>) -> Void) {
        if shouldReturnError {
            completion(.failure(.networkError(NSError(domain: "", code: 0, userInfo: nil))))
        } else {
            if mockMovies.isEmpty {
                let movie = Movie(id: 1, title: "Test Movie", releaseDate: "2024-01-01", posterPath: nil, overview: nil, genres: nil, runtime: nil)
                mockMovies = [movie]
            }
            completion(.success(mockMovies))
        }
    }
}

class MovieRepositoryTests: XCTestCase {
    var repository: MovieRepositoryImpl!
    var mockAPIService: MockAPIService!
    
    override func setUp() {
        super.setUp()
        mockAPIService = MockAPIService()
        repository = MovieRepositoryImpl(apiService: mockAPIService)
    }
    
    override func tearDown() {
        repository = nil
        mockAPIService = nil
        super.tearDown()
    }
    
    func testFetchMoviesSuccess() {
        mockAPIService.shouldReturnError = false
        
        let expectation = self.expectation(description: "Fetching movies from repository succeeds")
        
        repository.fetchMovies(category: .nowPlaying) { result in
            switch result {
            case .success(let movies):
                XCTAssertNotNil(movies)
                XCTAssertEqual(movies.first?.title, "Test Movie")
            case .failure(let error):
                XCTFail("Error fetching movies: \(error.localizedDescription)")
            }
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testFetchMoviesFailure() {
        mockAPIService.shouldReturnError = true
        
        let expectation = self.expectation(description: "Fetching movies from repository fails")
        
        repository.fetchMovies(category: .nowPlaying) { result in
            switch result {
            case .success(_):
                XCTFail("Fetching movies should fail when API service returns an error")
            case .failure(let error):
                XCTAssertNotNil(error)
            }
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
    }
}
