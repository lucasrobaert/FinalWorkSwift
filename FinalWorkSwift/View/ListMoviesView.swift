//
//  ListMoviesView.swift
//  FinalWorkSwift
//
//  Created by Lucas Robaert on 16/10/23.
//

import SwiftUI

struct ListMoviesView: View {
    @StateObject var viewModel = MovieViewModel()
    
    var body: some View {
        NavigationView {
            ZStack {
                if !viewModel.movies.isEmpty{
                    MoviesListView(movies: viewModel.movies, viewModel: viewModel)
                } else {
                    LoadingView()
                }
            }.navigationTitle("Popular Movies")
            
        }.onAppear{
            viewModel.fetchData()
        }
    }
}

#Preview {
    ListMoviesView()
}
