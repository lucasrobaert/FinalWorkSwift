//
//  ContentView.swift
//  FinalWorkSwift
//
//  Created by Lucas Robaert on 15/10/23.
//

import SwiftUI
import SDWebImageSwiftUI

struct ContentView: View {
    @State private var currentTab: String = "ListMovies"
    
    var body: some View {
        TabView(selection: $currentTab){
            ListMoviesView()
                .tag("ListMovies")
                .tabItem {
                    Image(systemName: "movieclapper.fill")
                    Text("Movies")
                }
            
            FavoritePageView()
                .tag("Watch")
                .tabItem {
                    Image(systemName: "heart.fill")
                    Text("Attend")
                }
        }
    }
}

struct MovieView: View {
    var movie: Movie
    
    var body: some View {
        HStack(spacing: 15) {
            WebImage(url: URL(string: "https://image.tmdb.org/t/p/w500/\(movie.poster_path)"))
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 120)
                .cornerRadius(8)
            VStack(alignment: .leading, spacing: 8) {
                Text(movie.title)
                    .font(.title2)
                    .fontWeight(.semibold)
                
                Text(movie.overview ?? "")
                    .lineLimit(4)
                    .foregroundColor(.gray)
                Spacer()
                
                RatingView(rating: movie.vote_average)
                
            }
            
        }
    }
}

struct RatingView: View {
    var rating: Float
    
    var body: some View {
        HStack(spacing: 4) {
            Image(systemName: "star.fill")
                .resizable()
                .frame(width: 12, height: 12)
                .foregroundColor(.orange)
            
            Text(String(format: "%.1f", rating))
                .fontWeight(.medium)
        }
    }
}

struct MoviesListView: View{
    var movies: [Movie]
    @ObservedObject var viewModel: MovieViewModel
    
    var body: some View{
        List{
            ForEach(movies) {movie in
                NavigationLink(destination: DetailsView(movie: movie, isFavorite: false, viewModel: viewModel), label: {
                    MovieView(movie: movie)
                        .padding(.vertical)
                        .onAppear{
                            viewModel.fetchDataIfNeeded(movie: movie)
                        }
                })
                
            }
        }
        .listStyle(PlainListStyle())
    }
}

struct LoadingView: View {
    var body: some View {
        Text("Fetching data...")
            .foregroundColor(.gray)
    }
}

#Preview {
    ContentView()
}

