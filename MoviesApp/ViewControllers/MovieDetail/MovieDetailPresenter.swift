//
//  DetailPresenter.swift
//  MoviesApp
//
//  Created by Milton Putallaz on 14/07/2021.
//

import Foundation
import UIKit

class MovieDetailPresenter: MovieDetailPresenterProtocol {
    private var view: MovieDetailViewDelegate?
    private let movieRepository = MovieRepository.sharedInstance
    private var movie: Movie?
    
    func setDelegateView(_ view: MovieDetailViewDelegate) {
        self.view = view
    }
    

    func getMovieDetail(movieId: Int) {
        movieRepository.getMovieDetail(movieId: movieId){(movieResponse:Movie?, error:BackendError?) in
            if let movie = movieResponse {
                self.movie = movie
                self.view?.setDetailAttributes(movie)
                self.getImageFromMovie()
            }
        }
    }
    
    private func getImageFromMovie(){
        if let path = self.movie?.posterPath {
            movieRepository.getMovieImageWith(imagePath: path){(image: UIImage?, error: BackendError?) in
                if let unwrappedImage = image {
                    self.view?.setImageToView(unwrappedImage)
                }
            }
        }
        
    }
    
    
}
