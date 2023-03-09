//
//  ProfileViewModel.swift
//  Nativekit
//
//  Created by Joel Ramirez on 08/03/23.
//

import Foundation

class ProfileViewModel {
    
   var statusCode = Observable(CodeResponse.success)
   var profile = Observable(PerfilResponse())
   var perfilSession = Observable(PerfilSessionResponse())
   var session = Observable("")
    
   // var url = Constants.accountPath(idSession: <#T##String#>)
    
    func getAccount(completion: @escaping((_ result: Result<PerfilResponse, Error>) -> Void)) {
        
        GenericService().request(headers: nil, url: Constants.accountPath) { (result: Result<PerfilResponse, Error>) in
            switch result {
            case .success(let value):
                self.profile.value = value
                completion(.success(value))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    
    func createSession() {
        let parameters = PerfilRequestSession(request_token: ProfileInfo.shared.token ?? "Token bad session")
        API.request(url: Constants.createSessionPath,
                    method: .POST,
                    parameters: parameters.dictionary) { [weak self] (response: PerfilSessionResponse?, statusCode) in
            
            self?.statusCode.value = statusCode
            
            if statusCode == .success{
                print("OK Session created...")
                ProfileInfo.shared.session = response?.session_id
                self?.session.value = ProfileInfo.shared.session ?? "Error decode id_session"
                print("Session_is: \(self?.session.value ?? "No hay valor de id_session")")
            }
        }
    }
    
    func deleteSession() -> Bool {
        var flag = false
        let parameter = PerfilDeleteRequest(session_id: ProfileInfo.shared.session ?? "No hay session activa")
        API.request(url: Constants.deleteSession,
                    method: .POST,
                    parameters: parameter.dictionary) { (response: PerfilSessionResponse?, statusCode) in
            
            self.statusCode.value = statusCode
            
            
            if statusCode == .success {
                print("Cerrar sesión con exito!")
                flag = true
            } else {
                flag = false
            }
        }
        return flag
    }
    
}
