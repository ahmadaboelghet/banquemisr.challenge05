//
//  File.swift
//  MovieApp
//
//  Created by Ahmad Aboelghet on 19/07/2024.
//

import Foundation

class FetchMoviesUseCase {
    private let repository: MovieRepository

    init(repository: MovieRepository) {
        self.repository = repository
    }

    func execute(category: MovieCategory, completion: @escaping (Result<[Movie], APIError>) -> Void) {
        repository.fetchMovies(category: category, completion: completion)
    }
}
