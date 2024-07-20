//
//  MovieViewModelTests.swift
//  MovieAppTests
//
//  Created by Ahmad Aboelghet on 19/07/2024.
//

import XCTest
@testable import MovieApp

class MovieViewModelTests: XCTestCase {
    var viewModel: MovieViewModel!
    var mockAPIService: MockAPIService!
    var repository: MovieRepositoryImpl!
    
    override func setUp() {
        super.setUp()
        mockAPIService = MockAPIService()
        repository = MovieRepositoryImpl(apiService: mockAPIService)
        viewModel = MovieViewModel(fetchMoviesUseCase: FetchMoviesUseCase(repository: repository))
    }
    
    override func tearDown() {
        viewModel = nil
        mockAPIService = nil
        repository = nil
        super.tearDown()
    }
    
    func testFetchMoviesSuccess() {
        mockAPIService.shouldReturnError = false
        let expectation = self.expectation(description: "Fetching movies succeeds")
        
        viewModel.fetchMovies(category: .nowPlaying)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            XCTAssertNotNil(self.viewModel.movies)
            XCTAssertEqual(self.viewModel.movies.first?.title, "Test Movie")
            XCTAssertNil(self.viewModel.errorMessage)
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 2, handler: nil)
    }
    
    func testFetchMoviesFailure() {
        mockAPIService.shouldReturnError = true
        let expectation = self.expectation(description: "Fetching movies fails")
        
        viewModel.fetchMovies(category: .nowPlaying)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            XCTAssertNotNil(self.viewModel.errorMessage)
            XCTAssertTrue(self.viewModel.movies.isEmpty)
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 2, handler: nil)
    }
}
