//
//  ContentView.swift
//  MovieApp
//
//  Created by Ahmad Aboelghet on 19/07/2024.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            MovieListView(category: .nowPlaying)
                .tabItem {
                    Label("Now Playing", systemImage: "film")
                }

            MovieListView(category: .popular)
                .tabItem {
                    Label("Popular", systemImage: "star")
                }

            MovieListView(category: .upcoming)
                .tabItem {
                    Label("Upcoming", systemImage: "calendar")
                }
        }
    }
}
