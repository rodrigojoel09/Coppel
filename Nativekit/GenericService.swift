//
//  GenericService.swift
//  Nativekit
//
//  Created by Joel Ramirez on 07/03/23.
//

import Foundation

// Se usa final para que no se pueda heredar de la clase y no se puedan modificar los metodos
final class GenericService {
    
    static  var notFound = ""
    
    //MARK: - Methods
    func request<T>(headers: [String: String]?, httpMethod: HttpMethods = .post, timeout: Double = 15, url: String, completion: @escaping(_ result: Result<T, Error>) -> Void) where T: Decodable {
        print("URL REQUEST: \(url)")
        
        makeRequest(headers: headers, httpMethod: httpMethod, timeout: timeout, url: url, completion: completion)
    }
    
    func request<T, U>(headers: [String: String]?, httpMethod: HttpMethods = .post, timeout: Double = 15, url: String, body: T, completion: @escaping(_ result: Result<U, Error>) -> Void) where T: Encodable, U: Decodable {
        
        do {
            let data = try JSONEncoder().encode(body)
            print("API: request: \(String(data: data, encoding: .utf8) ?? "")")
            print("API: url\(url)")
            
            makeRequest(headers: headers, httpMethod: httpMethod, timeout: timeout, url: url, data: data, completion: completion)
        } catch {
            completion(.failure(error))
        }
    }
    
   // @inlinable
    func prepareRequest(request: inout URLRequest, method: String?, timeout: Double, body: Data?) {
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json;json;charset=UTF-8", forHTTPHeaderField: "X-Custom-Header")
        request.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        
        // let requestHeaders: [String: String] = ["Content-Type": "application/x-www-form-urlencoded"]
      //  request.allHTTPHeaderFields = requestHeaders
        
        request.httpMethod = method
        request.timeoutInterval = timeout
        request.httpBody = body
    }
}

//MARK: -Private Fuctions
extension GenericService {
    private func makeRequest<U>(headers: [String: String]?, httpMethod: HttpMethods, timeout: Double, url: String, data: Data? = nil, completion: @escaping(_ result: Result<U, Error>) -> Void) where U: Decodable {
        
        guard let url = URL(string: url) else {
            completion(.failure(GenericServiceError.badUrl))
            return
        }
        
        var request = URLRequest(url: url)
        
        prepareRequest(request: &request, method: httpMethod.rawValue, timeout: timeout, body: data)
        
        if let headers = headers {
            for key in headers.keys {
                request.addValue(headers[key] ?? "", forHTTPHeaderField: key)
            }
        }
        
        print("API Headers: \(headers ?? [:])")
        
        URLSession.shared.dataTask(with: request) { data, respoonse, error in
            do {
                // Error
                if let error = error {
                    throw error
                }
                
                // Data
                guard let jsonData = data else {
                    throw GenericServiceError.badResponse
                }
                let valueOfDataStr = String(data: jsonData, encoding: .utf8)
                print("API: response \(String(describing: valueOfDataStr))")
                
                // Response
                guard let httpResponse = respoonse as? HTTPURLResponse else {
                    throw GenericServiceError.badResponse
                }
                
                /*
                guard let mimeType = httpResponse.mimeType, mimeType == "application/json" else {
                    throw GenericServiceError.badMimeType
                }*/
                
                if httpResponse.statusCode == 401 {
                    throw GenericServiceError.unauthorized
                }
                
                if httpResponse.statusCode == 404 {
                    throw GenericServiceError.notFound
                }
                
                // El status code es diferente de 200 ?
                /* if httpResponse.statusCode == 200 { Hacer algo en caso positivo}  ALTERNATIVA */
                guard String(httpResponse.statusCode).starts(with: "2") else {
                    throw GenericServiceError.badStatusCode
                }
                
                let response = try JSONDecoder().decode(U.self, from: jsonData)
                completion(.success(response))
                
            } catch {
                completion(.failure(error))
            }
        }.resume()
        
    }
}
