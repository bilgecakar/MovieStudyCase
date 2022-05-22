//
//  MovieRouter.swift
//  MovieCase
//
//  Created by Bilge Çakar on 20.05.2022.
//

import Foundation

class MovieRouter : PresenterToRouterMovieProtocol
{
    static func creatModule(ref: ViewController) {
        
        ref.moviePresenterObject = MoviePresenter()
        ref.moviePresenterObject?.movieInteractor = MovieInteractor()
        
    }
}
