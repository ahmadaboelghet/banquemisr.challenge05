//
//  File.swift
//  MovieApp
//
//  Created by Ahmad Aboelghet on 19/07/2024.
//

import Foundation

enum MovieCategory: String {
    case nowPlaying = "now_playing"
    case popular
    case upcoming

    var title: String {
        switch self {
        case .nowPlaying:
            return "Now Playing"
        case .popular:
            return "Popular"
        case .upcoming:
            return "Upcoming"
        }
    }
}

enum APIError: Error, LocalizedError {
    case invalidResponse
    case invalidData
    case networkError(Error)

    var errorDescription: String? {
        switch self {
        case .invalidResponse:
            return "Invalid response from the server."
        case .invalidData:
            return "Invalid data received from the server."
        case .networkError(let error):
            return error.localizedDescription
        }
    }
}

class APIService {
    private let apiKey: String
    private let baseURL = "https://api.themoviedb.org/3/movie"
    private let cacheKeyPrefix = "MovieCache_"

    init(apiKey: String = "43e7d10e3e1b3ad5d04792c6e6fdf58d") {
        self.apiKey = apiKey
    }

    func fetchMovies(category: MovieCategory, completion: @escaping (Result<[Movie], APIError>) -> Void) {
        let cacheKey = cacheKeyPrefix + category.rawValue

        // Check cache first
        if let cachedMovies = getCachedMovies(for: cacheKey) {
            completion(.success(cachedMovies))
            return
        }

        let urlString = "\(baseURL)/\(category.rawValue)?api_key=\(apiKey)&language=en-US&page=1"
        guard let url = URL(string: urlString) else {
            completion(.failure(.invalidData))
            return
        }

        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(.networkError(error)))
                return
            }

            guard let data = data, let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completion(.failure(.invalidResponse))
                return
            }

            do {
                let movieResponse = try JSONDecoder().decode(MovieResponse.self, from: data)
                self.cacheMovies(movieResponse.results, for: cacheKey)
                completion(.success(movieResponse.results))
            } catch {
                completion(.failure(.invalidData))
            }
        }.resume()
    }

    private func getCachedMovies(for key: String) -> [Movie]? {
        if let data = UserDefaults.standard.data(forKey: key) {
            do {
                let movies = try JSONDecoder().decode([Movie].self, from: data)
                return movies
            } catch {
                return nil
            }
        }
        return nil
    }

    private func cacheMovies(_ movies: [Movie], for key: String) {
        do {
            let data = try JSONEncoder().encode(movies)
            UserDefaults.standard.set(data, forKey: key)
        } catch {
            print("Failed to cache movies: \(error.localizedDescription)")
        }
    }
}

struct MovieResponse: Codable {
    let results: [Movie]
}
