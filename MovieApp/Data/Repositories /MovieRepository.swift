//
//  File.swift
//  MovieApp
//
//  Created by Ahmad Aboelghet on 19/07/2024.
//

import Foundation

protocol MovieRepository {
    func fetchMovies(category: MovieCategory, completion: @escaping (Result<[Movie], APIError>) -> Void)
}

class MovieRepositoryImpl: MovieRepository {
    private let apiService: APIService

    init(apiService: APIService) {
        self.apiService = apiService
    }

    func fetchMovies(category: MovieCategory, completion: @escaping (Result<[Movie], APIError>) -> Void) {
        apiService.fetchMovies(category: category, completion: completion)
    }
}
