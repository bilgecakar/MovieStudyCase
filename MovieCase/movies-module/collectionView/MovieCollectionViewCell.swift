//
//  MovieCollectionViewCell.swift
//  MovieCase
//
//  Created by Bilge Çakar on 18.05.2022.
//

import UIKit
import Kingfisher //Library in order to get images from API

class MovieCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var movieName: UILabel!
    
    func configure(movie : Movies)
    {
        if let url = URL(string: "http://image.tmdb.org/t/p/w185\(movie.poster_path!)")
        {
            DispatchQueue.main.async {
                self.movieImage.kf.setImage(with : url)
            }
        }
        movieName.text = movie.title
    }
    
}
