//
//  Favorite.swift
//  FinalWorkSwift
//
//  Created by Lucas Robaert on 27/11/23.
//

import Foundation
import SwiftData

@Model
class Favorite {
    var id: Int
    var title: String
    var overview: String?
    var poster_path: String
    var vote_average: Float
    
    init(id: Int, title: String, overview: String?, poster_path: String, vote_average: Float) {
        self.id = id
        self.title = title
        self.overview = overview
        self.poster_path = poster_path
        self.vote_average = vote_average
    }
}
