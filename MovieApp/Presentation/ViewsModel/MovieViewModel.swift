//
//  File.swift
//  MovieApp
//
//  Created by Ahmad Aboelghet on 19/07/2024.
//

import Foundation

class MovieViewModel: ObservableObject {
    @Published var movies: [Movie] = []
    @Published var errorMessage: String?
    private let fetchMoviesUseCase: FetchMoviesUseCase

    init(fetchMoviesUseCase: FetchMoviesUseCase) {
        self.fetchMoviesUseCase = fetchMoviesUseCase
    }

    func fetchMovies(category: MovieCategory) {
        fetchMoviesUseCase.execute(category: category) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let movies):
                    self?.movies = movies
                    self?.errorMessage = nil
                case .failure(let error):
                    self?.handleError(error)
                }
            }
        }
    }

    private func handleError(_ error: APIError) {
        switch error {
        case .networkError(let networkError):
            errorMessage = "Network error: \(networkError.localizedDescription)"
        case .invalidResponse:
            errorMessage = "Invalid response from server"
        case .invalidData:
            errorMessage = "Invalid data received"
        }
    }
}
