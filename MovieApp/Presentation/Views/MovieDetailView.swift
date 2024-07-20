//
//  MovieDetailView.swift
//  MovieApp
//
//  Created by Ahmad Aboelghet on 19/07/2024.
//

import SwiftUI

struct MovieDetailView: View {
    let movie: Movie

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            // Display movie details
            Text(movie.title).font(.largeTitle)
            Text(movie.releaseDate).font(.subheadline)
            if let overview = movie.overview {
                Text(overview).padding(.top, 10)
            }
            Spacer()
        }
        .padding()
        .navigationTitle("Details")
        .navigationBarTitleDisplayMode(.inline)
    }
}
