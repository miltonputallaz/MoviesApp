//
//  DetailView.swift
//  MoviesApp
//
//  Created by Milton Putallaz on 14/07/2021.
//

import Foundation
import UIKit

class MovieDetailView: UIViewController, MovieDetailViewDelegate {

    private let presenter = MovieDetailPresenter()
    var movieId: Int?
    
    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var movieSinopsis: UILabel!
    
    func initializeView(_ movieId: Int) {
        presenter.setDelegateView(self)
        presenter.getMovieDetail(movieId: movieId)
    }

    
    
    override func viewDidLoad() {
        self.title = NSLocalizedString("Detail", comment: "Detail of movie")
        if let id = self.movieId {
            initializeView(id)
        }
    }
    
    func setImageToView(_ image: UIImage) {
        movieImage.image = image
    }
    
    func setDetailAttributes(_ movie: Movie) {
        movieTitle.text = movie.title
        movieSinopsis.text = movie.overview
    }
    
}
