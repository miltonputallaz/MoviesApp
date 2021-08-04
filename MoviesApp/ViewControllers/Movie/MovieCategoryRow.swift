//
//  CategoryRow.swift
//  MoviesApp
//
//  Created by Milton Putallaz on 02/07/2021.
//

import Foundation
import UIKit
import Alamofire
import AlamofireImage

class MovieCategoryRow: UITableViewCell{
    
    @IBOutlet weak var moviesCollectionView: UICollectionView!
    private var movieRepository = MovieRepository.sharedInstance
    private var moviesCollection = [Movie]()
    private var onClickDelegate: ClickItemDelegate?
    
    func setGenre(_ genre: Genre?){
        if let genreUnwrapped = genre {
            getMoviesWithGenre(genreUnwrapped.id)
        } else {
            moviesCollection = [Movie]()
            self.updateCollectionView()
        }
    }
    
    func setClickDelegate(delegate: ClickItemDelegate){
        self.onClickDelegate = delegate
    }
    
    private func getMoviesWithGenre(_ genreId: Int){
        let completionHandler =  {(moviesListResponse:ListResponse<Movie>?, error:BackendError?) in
            if let moviesResponse = moviesListResponse, let movies = moviesResponse.results {
                self.moviesCollection = movies
                self.updateCollectionView()
            }
        }
        movieRepository.getDiscoverMovies(genreId: genreId, completionHandler: completionHandler)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let listener = self.onClickDelegate, let movieId = moviesCollection[indexPath.row
        ].id  {
            listener.onClickItem(itemId: movieId)
        }

    }
    
    
    private func updateCollectionView(){
        self.moviesCollectionView.reloadData()
    }
}

extension MovieCategoryRow: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return moviesCollection.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let movie = self.moviesCollection[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "videoCell", for: indexPath) as! MovieItem
        if let title = movie.title {
            cell.movieTitle.text = title
        }
        if let url = movie.backdropPath {
            RemoteMovieRepository.sharedInstance.getImageFromUrl(imagePath: url){ image, error in
                cell.movieImage.image = image
            }
        }
        cell.layer.cornerRadius = 10
        
        return cell
    }
    
}

extension MovieCategoryRow: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemsPerRow:CGFloat = 2
        let hardCodedPadding:CGFloat = 5
        let itemWidth = (collectionView.bounds.width / itemsPerRow) - hardCodedPadding
        let itemHeight = collectionView.bounds.height - (2 * hardCodedPadding)
        return CGSize(width: itemWidth, height: itemHeight)
    }
}


