//
//  MovieInteractor.swift
//  MovieCase
//
//  Created by Bilge Çakar on 18.05.2022.
//

import Foundation

class MovieInteractor : PresenterToInteractorMovieProtocol
{
    private let session = URLSession.shared
    
    //Use generic for reusable abd flexible request function
    func performRequest<T:Codable>(urlRequest : URLRequest, completion : @escaping (Result<T,ErrorMessage>) -> Void)
    {
        let task = session.dataTask(with: urlRequest) { data, response, error in
            DispatchQueue.main.async {
                if let data = data
                {
                    do {
                        let answer = try JSONDecoder().decode(T.self, from: data)
                        completion(.success(answer))
                    } catch {
                        completion(.failure(.decodingError))
                    }
                }else if error != nil
                {
                    completion(.failure(.networkError))
                }else{
                    completion(.failure(.unknownError))
                }
            }
        }
        task.resume()
    }
    
    //Get movies with using category id
    func getAllMovie(id : Int, completion: @escaping (Result<MovieResponse, ErrorMessage>) -> Void) {
        let urlRequest = URLRequest(url: URL(string: "https://api.themoviedb.org/3/discover/movie?api_key=3bb3e67969473d0cb4a48a0dd61af747&sort_by=popularity.desc&include_adult=false&include_video=false&page=1&with_genres=\(id)")!)
        performRequest(urlRequest: urlRequest, completion: completion)
    }
    
    //Get categories
    func getAllCategory(completion: @escaping (Result<CategoryResponse, ErrorMessage>) -> Void)
    {
        let urlRequest = URLRequest(url: URL(string: "https://api.themoviedb.org/3/genre/movie/list?api_key=3bb3e67969473d0cb4a48a0dd61af747&language=en-US")!)
        performRequest(urlRequest: urlRequest, completion: completion)
        
    }
    
}
enum ErrorMessage: Error
{
    case decodingError
    case networkError
    case unknownError
}
