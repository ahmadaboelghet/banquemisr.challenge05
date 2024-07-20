//
//  MovieListView.swift
//  MovieApp
//
//  Created by Ahmad Aboelghet on 19/07/2024.
//

import SwiftUI

struct MovieListView: View {
    let category: MovieCategory
    @StateObject private var viewModel = MovieViewModel(
        fetchMoviesUseCase: FetchMoviesUseCase(repository: MovieRepositoryImpl(apiService: APIService()))
    )

    var body: some View {
        NavigationView {
            List(viewModel.movies) { movie in
                NavigationLink(destination: MovieDetailView(movie: movie)) {
                    MovieRow(movie: movie)
                }
            }
            .onAppear {
                viewModel.fetchMovies(category: category)
            }
            .navigationTitle(category.title)
        }
    }
}
