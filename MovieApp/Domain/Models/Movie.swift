//
//  Movie.swift
//  MovieApp
//
//  Created by Ahmad Aboelghet on 19/07/2024.
//

import Foundation

struct Movie: Codable, Identifiable {
    let id: Int
    let title: String
    let releaseDate: String
    let posterPath: String?
    let overview: String?
    let genres: [Genre]?
    let runtime: Int?

    enum CodingKeys: String, CodingKey {
        case id, title, overview, genres, runtime
        case releaseDate = "release_date"
        case posterPath = "poster_path"
    }
}

struct Genre: Codable {
    let id: Int
    let name: String
}
