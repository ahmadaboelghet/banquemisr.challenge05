//
//  MovieRow.swift
//  MovieApp
//
//  Created by Ahmad Aboelghet on 19/07/2024.
//

import SwiftUI

struct MovieRow: View {
    let movie: Movie

    var body: some View {
        HStack {
            // Display movie poster
            if let posterPath = movie.posterPath, let url = URL(string: "https://image.tmdb.org/t/p/w500\(posterPath)") {
                AsyncImage(url: url) { image in
                    image.resizable()
                } placeholder: {
                    Color.gray
                }
                .frame(width: 50, height: 75)
                .cornerRadius(8)
            } else {
                Color.gray.frame(width: 50, height: 75).cornerRadius(8)
            }

            VStack(alignment: .leading, spacing: 5) {
                Text(movie.title).font(.headline)
                Text(movie.releaseDate).font(.subheadline)
            }
        }
    }
}
