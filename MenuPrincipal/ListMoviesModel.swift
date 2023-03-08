//
//  ListMoviesModel.swift
//  Nativekit
//
//  Created by Joel Ramirez on 08/03/23.
//

import Foundation

struct PopularMoviesResponseEntity: Decodable {
    var results: [PopularMovieEntity]
    
   enum CodingKeys: String, CodingKey {
        case results
    }
}

struct PopularMovieEntity: Decodable {
    
    var id: Int
    var title: String?
    var overview: String
    var imageURL: String
    var votes: Double
    var name: String?
    var genres: [Genres]?
    var date: String?
    var dateTV: String?
    
    
    init()  {
        id = 0
        title = ""
        overview = ""
        imageURL = ""
        votes = 0.0
        name = ""
        genres = []
        date = ""
    }
    
    enum CodingKeys: String , CodingKey {
        case id, title, overview
        case imageURL =  "poster_path"
        case votes = "vote_average"
        case name, genres
        case date = "release_date"
        case dateTV = "first_air_date"
    }
    
}

struct TvShowsEntity: Decodable {
    
}

struct Genres: Decodable {
    var id : Int
    var name : String
}

