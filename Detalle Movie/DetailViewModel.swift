//
//  DetailViewModel.swift
//  Nativekit
//
//  Created by Joel Ramirez on 08/03/23.
//

import Foundation


class DetailViewModel {
    var message = Observable("")
    var statusCode = Observable(CodeResponse.success)
    var movie = Observable(DetailResponse())

    
    init() {
    }
    
    static var urlDetail = Constants.popularPath
        
    func getMovieDetail(url: String, completion: @escaping((_ result: Result<DataResponse<DetailResponse>, Error>) -> Void )){
        let url = url
        GenericService().request(headers: nil, url: url) { (result: Result<DataResponse<DetailResponse>, Error>) in
            
           
            switch result {
            case .success(let movie):
                self.message.value = movie.message ?? "message optional"
                self.statusCode.value = .success
                self.movie.value = movie.data ?? DetailResponse()
                print("DATA OF MOVIE FROM VM")
                print(movie)
                completion(.success(movie))
            case .failure(let error):
                print("error al detalle de la pelicula")
                self.message.value = error.localizedDescription.description
                self.statusCode.value = .error_server
                completion(.failure(GenericServiceError.notFound))
            }
        }
    }
}
