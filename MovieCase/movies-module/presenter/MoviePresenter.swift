//
//  MoviePresenter.swift
//  MovieCase
//
//  Created by Bilge Çakar on 18.05.2022.
//

import Foundation

class MoviePresenter : ViewToPresenterMovieProtocol
{
    
    var movieInteractor: PresenterToInteractorMovieProtocol?
    
    func performRequest<T>(urlRequest: URLRequest, completion: @escaping (Result<T, ErrorMessage>) -> Void) where T : Decodable, T : Encodable {
        movieInteractor?.performRequest(urlRequest: urlRequest, completion: completion)
    }
    
    func getAllMovie(id : Int, completion: @escaping (Result<MovieResponse, ErrorMessage>) -> Void) {
        movieInteractor?.getAllMovie(id : id, completion: completion)
    }
    
    func getAllCategory(completion: @escaping (Result<CategoryResponse, ErrorMessage>) -> Void) {
        movieInteractor?.getAllCategory(completion: completion)
    }
    
}

