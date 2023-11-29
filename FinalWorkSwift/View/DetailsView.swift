//
//  DetailsView.swift
//  FinalWorkSwift
//
//  Created by Lucas Robaert on 16/10/23.
//

import SwiftUI
import SDWebImageSwiftUI

struct DetailsView: View {
    var movie: Movie
    var isFavorite: Bool
    @ObservedObject var viewModel: MovieViewModel
    @Environment(\.presentationMode) var presentation
    @State var yOffset: CGFloat = 30
    @State var opacity: Double = 0
    @Environment(\.modelContext) private var context
    
    var body: some View {
        ZStack(alignment: .bottom) {
            ZStack(alignment: .top) {
                
                VStack{
                    WebImage(url: URL(string: "https://image.tmdb.org/t/p/w500/\(movie.poster_path)"))
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                    
                    Spacer()
                }
                
                HStack{
                    Button(action: {
                        self.presentation.wrappedValue.dismiss()
                    }, label: {
                        Image(systemName: "chevron.left")
                            .padding()
                            .background(Color.white.opacity(0.7))
                            .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                    })
                    
                    Spacer()
                }.padding()
                    .padding(.top, UIApplication.shared.windows.first?.safeAreaInsets.top)
            }
            VStack(spacing: 8) {
                HStack(alignment: .center, spacing: 8) {
                    Text(movie.title)
                        .font(.largeTitle)
                    RatingView(rating: movie.vote_average)
                    FavoriteView(favorite: isFavorite, movie: movie)
                    Spacer()
                }
                
                HStack(spacing: 8) {
                    ForEach(viewModel.movie?.genres ?? Array.init(repeating: Genre(id: 0, name: "Loading..."), count: 2)) {genre in
                        Text(genre.name)
                            .redacted(reason: viewModel.movie == nil ? .placeholder : .init())
                        
                        if viewModel.movie?.genres?.last != genre {
                            Circle()
                                .frame(width: 6, height: 5)
                        }
                    }
                    Spacer()
                }
                
                Text(movie.overview ?? "")
                
                Button(action: {}, label: {
                    HStack {
                        Image(systemName: "play.fill")
                        Text("Play Trailer")
                    }
                    .foregroundColor(Color.primary)
                    .frame(maxWidth: .infinity)
                        .frame(height: 60)
                        .background(RoundedRectangle(cornerRadius: 8).stroke(Color.primary, lineWidth: 1))
                        .padding(.top)
                }).padding(.bottom, UIApplication.shared.windows.first?.safeAreaInsets.bottom)
                
                
            }.padding()
                .background(RoudedCorners(corners: [.topLeft, .topRight], radius: 30).fill(Color.white).shadow(radius: 5))
                .offset(y: yOffset)
                .opacity(opacity)
                .animation(.spring())
                .onAppear{
                    DispatchQueue.main.async {
                        withAnimation{
                            yOffset = 0
                            opacity = 1
                        }
                        
                    }
                }
        }
        .navigationBarHidden(true)
        .ignoresSafeArea(.all, edges: .all)
            .onAppear{
                viewModel.fetchMovie(movie: movie)
        }
    }
}


struct FavoriteView: View {
    var favorite: Bool
    var movie: Movie
    @Environment(\.modelContext) private var context
    
    var body: some View {
        HStack(spacing: 4) {
            
            
            Button(action: {
                            self.addOrDelete()
                        }) {
                            if favorite{
                                Image(systemName: "heart.fill")
                                    .resizable()
                                    .frame(width: 24, height: 24)
                                    .foregroundColor(.red)
                            } else {
                                Image(systemName: "heart")
                                    .resizable()
                                    .frame(width: 24, height: 24)
                                    .foregroundColor(.red)
                            }
                        }
            
        }
    }
    
    func addOrDelete() {
        
        let data = Favorite(id: movie.id, title: movie.title, overview: movie.overview, poster_path: movie.poster_path, vote_average: movie.vote_average)
        
        if favorite {
            context.delete(data)
            
        } else {
            context.insert(data)
        }
        }
        
}


#Preview {
    DetailsView(movie: Movie(id: 575264, title: "Mission: Impossible - Dead Reckoning Part One", overview: "Ethan Hunt and his IMF team embark on their most dangerous mission yet: To track down a terrifying new weapon that threatens all of humanity before it falls into the wrong hands. With control of the future and the world's fate at stake and dark forces from Ethan's past closing in, a deadly race around the globe begins. Confronted by a mysterious, all-powerful enemy, Ethan must consider that nothing can matter more than his mission not even the lives of those he cares about most.", poster_path:"/NNxYkU70HPurnNCSiCjYAmacwm.jpg", vote_average: 0.3, genres: nil), isFavorite: false, viewModel: MovieViewModel())
}

