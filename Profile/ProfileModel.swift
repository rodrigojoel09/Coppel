//
//  ProfileModel.swift
//  Nativekit
//
//  Created by Joel Ramirez on 08/03/23.
//

import Foundation

struct PerfilRequestSession: Codable {
    let request_token: String
}

struct PerfilDeleteRequest: Codable {
    var session_id: String
}

struct PerfilSessionResponse: Codable {
    var success: Bool?
    var session_id: String?
    
    init () {
        success = false
        session_id = ""
    }
}

struct PerfilResponse: Codable {
    
    var name: String
    var username: String
    
    
    init () {
        name = "The resource you requested could not be found"
        username = "The resource you requested could not be found"
    }
}

