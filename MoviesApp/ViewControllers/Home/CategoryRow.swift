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

class CategoryRow: UITableViewCell{
    
    @IBOutlet weak var moviesCollectionView: UICollectionView!
    private var movieRepository = MovieRepository.sharedInstance
    private var moviesCollection = [Movie]()
    private var onClickItemListener: ((_ movieId: Int) -> Void)?
    
    func setGenre(_ genre: Genre?){
        if let genreUnwrapped = genre {
            getMoviesWithGenre(genreUnwrapped.id)
        } else {
            moviesCollection = [Movie]()
            self.updateCollectionView()
        }
    }
    
    func setOnClickListener(onClickListener: @escaping (_ movieId: Int) -> Void){
        self.onClickItemListener = onClickListener
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
    
    private func updateCollectionView(){
        self.moviesCollectionView.reloadData()
    }
}

extension CategoryRow: UICollectionViewDataSource {
    
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
            RemoteMovieRepository.sharedInstance.getImageFromUrl(url: url){ image, error in
                cell.movieImage.image = image
            }
        }
        cell.layer.cornerRadius = 10
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let listener = self.onClickItemListener, let movieId = moviesCollection[indexPath.row].id {
            listener(movieId)
        }
    }
    
}

extension CategoryRow: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemsPerRow:CGFloat = 2
        let hardCodedPadding:CGFloat = 5
        let itemWidth = (collectionView.bounds.width / itemsPerRow) - hardCodedPadding
        let itemHeight = collectionView.bounds.height - (2 * hardCodedPadding)
        return CGSize(width: itemWidth, height: itemHeight)
    }
}

