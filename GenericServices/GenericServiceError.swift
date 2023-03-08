//
//  GenericServiceError.swift
//  Nativekit
//
//  Created by Joel Ramirez on 07/03/23.
//

import Foundation

enum GenericServiceError: Error {
    case badUrl
    case badResponse
    case badMimeType
    case badStatusCode
    case unauthorized
    case cannotCast
    case notFound
}

extension GenericServiceError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .notFound:
            return "GenericServiceError: Devuelve un 404 "
        case .badUrl:
            return "GenericServiceError: URL Invalida"
        case .badResponse:
            return "GenericServiceError: La respuesta es nula o es un tipo de dato invalido"
        case .badMimeType:
            return "GenericServiceError: El MimeType no es application/json"
        case .badStatusCode:
            return "GenericServiceError: La respuesta tiene un status code  diferente a 200 "
        case .unauthorized:
            return "GenericServiceError: La respuesta fue un 401"
        case .cannotCast:
            return "GenericServiceError: Por alguna razón no se pudo castear algún dato"
        }
    }
}
