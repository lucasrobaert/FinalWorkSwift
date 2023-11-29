//
//  MovieViewModel.swift
//  FinalWorkSwift
//
//  Created by Lucas Robaert on 16/10/23.
//

import SwiftUI

class MovieViewModel: ObservableObject {
    @Published var movies = [Movie]()
    var page: Int = 1
    var totalpages: Int = 1
    var isFetchingData = false
    @Published var movie: Movie?
    
    func fetchDataIfNeeded(movie: Movie) {
        if movies.last == movie && page < totalpages && !isFetchingData {
            page += 1
            fetchData()
        }
    }
    
    func fetchData() {
        let url = URL(string: "https://api.themoviedb.org/3/discover/movie?sort_by=popularity.desc&api_key=aff15f781a9e5435cf7b0660d592e998&page=\(page)")
        
        isFetchingData = true
        URLSession.shared.dataTask(with: url!){data, response, error in
            
            self.isFetchingData = false
            
            if let error = error {
                print(error)
                return
            }
            
            if let data = data {
                do {
                    let discover = try JSONDecoder().decode(Discover.self, from: data)
                    self.totalpages = discover.total_pages
                    DispatchQueue.main.async{
                        
                        self.movies += discover.results
                    }
                    
                } catch (let error){
                    print(error)
                    return
                }
            } else {
                print("error")
                return
            }
            
        }.resume()
    }
    
    func fetchMovie(movie: Movie) {
        let url = URL(string: "https://api.themoviedb.org/3/movie/\(movie.id)?api_key=aff15f781a9e5435cf7b0660d592e998")
        
        isFetchingData = true
        URLSession.shared.dataTask(with: url!){data, response, error in
            
            self.isFetchingData = false
            
            if let error = error {
                print(error)
                return
            }
            
            if let data = data {
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
                    print(json)
                    let movie = try JSONDecoder().decode(Movie.self, from: data)
                    
                    DispatchQueue.main.async{
                        
                        self.movie = movie
                    }
                    
                } catch (let error){
                    print(error)
                    return
                }
            } else {
                print("error")
                return
            }
            
        }.resume()
    }
}

