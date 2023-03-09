//
//  ProfileInfo.swift
//  Nativekit
//
//  Created by Joel Ramirez on 07/03/23.
//

import Foundation


class ProfileInfo {
    
    static var shared: ProfileInfo = {
           let instance = ProfileInfo()
           return instance
    }()
    
    var profileInfo: LoginRequets?
    
    

    var token: String?{
        get{
            let defaults = UserDefaults.standard
            return defaults.string(forKey: "token")
        }
        set{
            let defaults = UserDefaults.standard
            defaults.set(newValue, forKey: "token")
        }
    }
    
    var session: String? {
        get {
            let defaults = UserDefaults.standard
            return defaults.string(forKey: "session")
        }
        set {
            let defaults = UserDefaults.standard
            return defaults.set(newValue,forKey: "session")
        }
    }
    
}


struct LoginRequets: Codable {
    let username: String
    let password: String
    let request_token: String?
}

