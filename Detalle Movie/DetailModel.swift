//
//  DetailModel.swift
//  Nativekit
//
//  Created by Joel Ramirez on 08/03/23.
//

import Foundation

struct DetailResponse: Codable {
    var adult: Bool?
    var production_companies: [Companies]?
    var overview: String?
    var vote_average: Double?
    var poster_path: String?
    var title: String?
    var release_date: String?
    var id: Int
    var logo_path: String?
    
    init() {
    adult = false
    production_companies = []
    overview = ""
    vote_average = 0.0
    poster_path = ""
    title = ""
    release_date = ""
    id = 0
    logo_path = ""
    }
     
    
}

struct Companies: Codable {
    var  id: Int
    var logo_path: String
    var name: String
    var origin_country: String
}
