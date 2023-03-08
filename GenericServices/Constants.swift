//
//  Constants.swift
//  Nativekit
//
//  Created by Joel Ramirez on 07/03/23.
//

import Foundation


class Constants: NSObject {
                       
    static let APIKey = "a30597f70d90c21fb51f507c0df2ccf4"
    
    static let tokenBase = "https://api.themoviedb.org/3/authentication/token/new?api_key=\(APIKey)"
    
    static let login = "https://api.themoviedb.org/3/authentication/token/validate_with_login?api_key=\(APIKey)"
    
    static let basePathMovie = "https://api.themoviedb.org/3/movie/"

    static let basePathTv = "https://api.themoviedb.org/3/tv/"
    
    static let popularPath = "\(basePathMovie)popular?api_key=\(APIKey)"
    
    static let topRatedPath = "\(basePathMovie)top_rated?api_key=\(APIKey)"
    
    static let onTV = "\(basePathTv)airing_today?api_key=\(APIKey)"
    
    static let airingToday = "\(basePathTv)on_the_air?api_key=\(APIKey)"
    
    static let baseImages = "https://image.tmdb.org/t/p/w200"
    
    static func pathImage(path: String)-> String {
        return "\(baseImages)\(path)"
    }
    
    static let testDetail = "https://api.themoviedb.org/3/movie/550?api_key=a30597f70d90c21fb51f507c0df2ccf4=en-US"
                           //https://api.themoviedb.org/3/tv/130542?api_key=\(APIKey)=en-US
    
    static let textList = "https://api.themoviedb.org/3/genre/tv/list?api_key=\(APIKey)"
         
    
    static func detailMovie(tv_id: Int) -> String {
        return "\(basePathMovie)\(tv_id)?api_key=\(APIKey)"
    }
    
    static func detailTv(movie_id: Int) -> String {
        return "\(basePathMovie)\(movie_id)?api_key=\(APIKey)"
    }
    
}
