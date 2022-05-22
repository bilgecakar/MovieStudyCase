//
//  MovieProtocols.swift
//  MovieCase
//
//  Created by Bilge Çakar on 18.05.2022.
//

import Foundation

protocol ViewToPresenterMovieProtocol
{
    var movieInteractor : PresenterToInteractorMovieProtocol? {get set}

    func performRequest<T:Codable>(urlRequest : URLRequest, completion : @escaping (Result<T,ErrorMessage>) -> Void)
    func getAllMovie(id : Int, completion: @escaping (Result<MovieResponse, ErrorMessage>) -> Void)
    func getAllCategory(completion: @escaping (Result<CategoryResponse, ErrorMessage>) -> Void)
}

protocol PresenterToInteractorMovieProtocol
{
    func performRequest<T:Codable>(urlRequest : URLRequest, completion : @escaping (Result<T,ErrorMessage>) -> Void)
    func getAllMovie(id : Int, completion: @escaping (Result<MovieResponse, ErrorMessage>) -> Void)
    func getAllCategory(completion: @escaping (Result<CategoryResponse, ErrorMessage>) -> Void)
}

protocol PresenterToRouterMovieProtocol
{
    static func creatModule(ref : ViewController)
}
