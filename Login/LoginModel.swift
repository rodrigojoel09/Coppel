//
//  LoginModel.swift
//  Nativekit
//
//  Created by Joel Ramirez on 07/03/23.
//
import Foundation

struct DataResponse<T:Codable>: Codable {
    let message:String?
    var succes: Bool?
    var data: T?

}

struct LoginResponse: Codable {
    var expires_at: String?
    var request_token: String?
    var session_id: String?
}

