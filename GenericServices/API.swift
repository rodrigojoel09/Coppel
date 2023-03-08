//
//  API.swift
//  Nativekit
//
//  Created by Joel Ramirez on 07/03/23.
//

import Foundation
import MobileCoreServices
import UIKit

class API {
    
    static let boundary = UUID().uuidString
    
    static let session: URLSession = URLSession.shared
    
    static let apiKey = Constants.APIKey
    
    static let timeout: TimeInterval = 30
    
    
    ///Función generica para hacer el request, de acuerdo a los parametros de cada petición
    static func request<T:Decodable>(url: String,
                                   method: Method = .GET,
                                   authorization : Bool = false,
                                   parameters: [String:Any]? = nil,
                                   contentType:ContentType = .json,
                                   completion: @escaping (T?,CodeResponse) -> ()){
       
        //Convert String to url
        guard let urlString = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
              let urlForRequest = URL(string: urlString) else {
            print("API: WRONG URL \(url)")
            completion(nil,CodeResponse.bad_url)
            return
        }
        //print("Peticion en \(urlString)")
        let request = makeURLRequest(url: urlForRequest, method: method, authorization: authorization, parameters: parameters,contentType: contentType)
        session.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                guard let data = data,
                      error == nil,
                      let httpURLResponse = response as? HTTPURLResponse,
                      let code = CodeResponse(rawValue: httpURLResponse.statusCode) else{
                    
                    completion(nil,.timeout)
                    print("API: \(error?.localizedDescription ?? "")")
                    return
                }
                if code == .noContent || code == .error_server{
                    completion(nil,code)
                    return
                }
                
                let convert:(object: T?,error: Error?) = data.decodeData()
                if convert.error == nil{
                    completion(convert.object,code)
                }else{
                    completion(nil,code)
                }
            }
        }.resume()
    }
    
    ///Hace los request para las URL, de cuerdo al tipo de contenido, si necesita autorización y el tiempo establecido.
    static func makeURLRequest(url: URL,method: Method, authorization: Bool,parameters: [String:Any]?,contentType:ContentType = .json) -> URLRequest{
        var urlRequest:URLRequest = URLRequest(url: url)
        urlRequest.httpMethod = method.rawValue
        //Content-Type
        var content = contentType.rawValue
        if contentType == .multipart{
            content = "\(content); boundary=\(boundary)"
        }
        urlRequest.setValue(content, forHTTPHeaderField: "Content-Type")
        if authorization, let token = ProfileInfo.shared.token{
            urlRequest.setValue("Bearer \(token)",forHTTPHeaderField: "Authorization")
        }
        urlRequest.timeoutInterval = timeout
        if let params = parameters{
            urlRequest.httpBody = parametersToData(parameters: params, contentType: contentType)
        }
        return urlRequest
    }
    
    ///Función que evalua el tipo de contenido y retorna los datos de parametros necesarios para hacer el makeURLRequest
    static func parametersToData(parameters: [String:Any],contentType:ContentType = .json) -> Data{
        switch contentType {
        case .json:
            return try! JSONSerialization.data(withJSONObject: parameters, options: [])
        case .form:
            let jsonString = parameters.reduce("") { "\($0)\($1.0)=\($1.1)&" }.dropLast()
            return jsonString.data(using: .utf8, allowLossyConversion: false)!
        case .multipart:
            var data = Data()
            data.append("\r\n--\(boundary)\r\n".data(using: .utf8)!)
            for param in parameters {
                guard let url = param.value as? URL else{
                    continue
                }
                data.append("Content-Disposition: form-data; name=\"\(param.key)\"; filename=\"\(url.lastPathComponent)\"\r\n".data(using: .utf8)!)
                data.append("Content-Type: \(url.mimeType())\r\n\r\n".data(using: .utf8)!)
                let fileData = try? Data(contentsOf: url)
                if url.containsImage{
                    data.append(UIImage(data: fileData!)!.jpegData(compressionQuality: 0.5)!)
                }else{
                    data.append(fileData!)
                }
            }
            data.append("\r\n--\(boundary)--\r\n".data(using: .utf8)!)
            return data
        }
    }
    

    //Enumeración de los metodos Request
    enum Method: String{
        case GET
        case POST
        case DELETE
    }
        
}

//Enumeración de los códigos de respuesta desde el WS
enum CodeResponse: Int{
    case success = 200
    case noContent = 204
    case bad_request = 400
    case authorization = 401
    case forbiden = 403
    case suspendido = 405
    case eliminado = 406
    case no_revisada = 426
    case precodition_failed = 412
    case error_server = 500
    case not_conection = -1001
    case timeout = -1002
    case bad_url = -1003
    case bad_decodable = -1004
    case copy_file_error = -1005
    
    //Mensajes genericos, para el tipo de respuesta que se trae del request, en base a CodeResponse
    var message: String{
        switch self {
        case .success:
           return "Exitoso"
        case .bad_request,.error_server:
            return "El servicio no se encuentra disponible intentalo mas tarde"
        case .forbiden,.authorization:
            return "Tu cuenta a caducado"
        case .suspendido:
        return "Tu cuenta a sido suspendida"
        case .not_conection,.timeout:
            return "Error de conexión, intente más tarde."
        case .bad_decodable:
            return "Error. Verifica tu conexión"
        default:
            return "Error interno"
        }
    }
    
}

extension Data{
    func decodeData<T:Decodable>() -> ( T?,Error?){
        do{
            let response = try JSONDecoder().decode(T.self, from: self)
            return (response,nil)
        }catch let jsonError{
            print("Falied to decode Json: ",jsonError)
            return (nil,jsonError)
        }
    }
}

///Extensión
extension URL {
    
    func mimeType() -> String {
        //Devuelve el tipo de contenido a desplegar
        let pathExtension = self.pathExtension
        if let uti = UTTypeCreatePreferredIdentifierForTag(kUTTagClassFilenameExtension, pathExtension as NSString, nil)?.takeRetainedValue() {
            if let mimetype = UTTypeCopyPreferredTagWithClass(uti, kUTTagClassMIMEType)?.takeRetainedValue() {
                return mimetype as String
            }
        }
        return "application/octet-stream"
    }
    var containsImage: Bool {
            let mimeType = self.mimeType()
            guard let uti = UTTypeCreatePreferredIdentifierForTag(kUTTagClassMIMEType, mimeType as CFString, nil)?.takeRetainedValue() else {
                return false
            }
            return UTTypeConformsTo(uti, kUTTypeImage)
    }
}

enum ContentType: String{
    case json = "application/json"
    case form = "application/x-www-form-urlencoded"
    case multipart = "multipart/form-data"
}

