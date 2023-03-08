//
//  LoginViewModel.swift
//  Nativekit
//
//  Created by Joel Ramirez on 07/03/23.
//

import Foundation


class LoginViewModel {
    
    var token  = Observable("")
    var statusCode = Observable(CodeResponse.success)
    var codeRestore = Observable(CodeResponse.success)
    var message = ""
   
    init() {
    }
    
    //Función que hace el request a la Api, para logear
    func makeLogin(userName: String, password: String){
        let parameters = LoginRequets(username: userName, password: password, request_token: ProfileInfo.shared.token)
        API.request(url: Constants.login,
                    method: .POST,
                    parameters:parameters.dictionary) {[weak self] (response:MovieDataResponse?, statusCode) in
            
            self?.statusCode.value = statusCode
            
            guard let res = response?.request_token else{
                return
            }
            
            if statusCode == .success{
                print("OK...")
                self?.token.value = ProfileInfo.shared.token ?? "Error  decode Token"
            }
        }
    }
    
    
    func getToken() {
        if let url = URL(string: Constants.tokenBase){
            
            URLSession.shared.dataTask(with: url) { data, response, error in
                if let data = data {
                    let decoder = JSONDecoder()
                    
                    if let datosDecodificados = try? decoder.decode(MovieDataResponse.self, from: data){
                        print(datosDecodificados.request_token ?? "ERROR al decodificar TOKEN" )
                        print(datosDecodificados.expires_at ?? "Error al decodificar los datos")
                   
                        ProfileInfo.shared.token = datosDecodificados.request_token
                    
                    }
                }
            }
        }
           
    }
    
    
}
//JSON decodable
extension Encodable {
  var dictionary: [String: Any]? {
    guard let data = try? JSONEncoder().encode(self) else { return nil }
    return (try? JSONSerialization.jsonObject(with: data, options: .allowFragments)).flatMap { $0 as? [String: Any] }
  }
}
