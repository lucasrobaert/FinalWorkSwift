//
//  FavoriteView.swift
//  FinalWorkSwift
//
//  Created by Lucas Robaert on 28/11/23.
//

import SwiftUI
import SwiftData
import SDWebImageSwiftUI

struct FavoritePageView: View {
    @Query( animation: .snappy) private var allFavorites: [Favorite]
    @Environment(\.modelContext) private var context
    @StateObject var viewModel = MovieViewModel()
    
    var body: some View{
        NavigationStack{
            List{
                ForEach(allFavorites){ favorite in
                    
                    NavigationLink(destination: DetailsView(movie: Movie(id: favorite.id, title: favorite.title, overview: favorite.overview, poster_path: favorite.poster_path, vote_average: favorite.vote_average, genres: nil),
                                                            isFavorite: true ,viewModel: viewModel), label: {
                        MovieFavoriteView(favorite: favorite)
                            .padding(.vertical)
                    })
                }
            }
        }
    }

}

struct MovieFavoriteView: View {
    var favorite: Favorite
    
    var body: some View {
        HStack(spacing: 15) {
            WebImage(url: URL(string: "https://image.tmdb.org/t/p/w500/\(favorite.poster_path)"))
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 120)
                .cornerRadius(8)
            VStack(alignment: .leading, spacing: 8) {
                Text(favorite.title)
                    .font(.title2)
                    .fontWeight(.semibold)
                
                Text(favorite.overview ?? "")
                    .lineLimit(4)
                    .foregroundColor(.gray)
                Spacer()
                
                RatingView(rating: favorite.vote_average)
                
            }
            
        }
    }
}
