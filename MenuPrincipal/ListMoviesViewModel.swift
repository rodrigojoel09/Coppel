//
//  ListMoviesViewModel.swift
//  Nativekit
//
//  Created by Joel Ramirez on 08/03/23.
//

import Foundation

class ListMoviesViewModel {
    
    var movies = Observable(PopularMoviesResponseEntity(results: []))
    
    static var url = Constants.popularPath
    
    //Obtener datos de API
    func getListofMovies(completion: @escaping((_ result: Result<PopularMoviesResponseEntity, Error>) -> Void )) {
        
        GenericService().request(headers: nil, httpMethod: .get, url: ListMoviesViewModel.url) { (result: Result<PopularMoviesResponseEntity, Error>) in
            
            switch result {
            case .success(let value):
                self.movies.value = value
                completion(.success(value))

            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
}
