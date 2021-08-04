//
//  TvCategoryRow.swift
//  MoviesApp
//
//  Created by Milton Putallaz on 04/08/2021.
//

import Foundation
import UIKit

class TvCategoryRow: UITableViewCell {
    
    @IBOutlet weak var tvCollectionView: UICollectionView!
    
    private var movieRepository = MovieRepository.sharedInstance
    private var tvCollection = [Movie]()
    private var onClickDelegate: ClickItemDelegate?
    
    func setGenre(_ genre: Genre?){
        if let genreUnwrapped = genre {
            getTvWithGenre(genreUnwrapped.id)
        } else {
            tvCollection = [Movie]()
            self.updateCollectionView()
        }
    }
    
    func setClickDelegate(delegate: ClickItemDelegate){
        self.onClickDelegate = delegate
    }
    
    private func getTvWithGenre(_ genreId: Int){
        let completionHandler =  {(moviesListResponse:ListResponse<Movie>?, error:BackendError?) in
            if let moviesResponse = moviesListResponse, let movies = moviesResponse.results {
                self.tvCollection = movies
                self.updateCollectionView()
            }
        }
        movieRepository.getDiscoverMovies(genreId: genreId, completionHandler: completionHandler)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let listener = self.onClickDelegate, let movieId = tvCollection[indexPath.row
        ].id  {
            listener.onClickItem(itemId: movieId)
        }

    }
    
    
    private func updateCollectionView(){
        self.tvCollectionView.reloadData()
    }
}

extension TvCategoryRow: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tvCollection.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let movie = self.tvCollection[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "tvCellId", for: indexPath) as! TvItem
        if let title = movie.title {
            cell.tvTitle.text = title
        }
        if let url = movie.backdropPath {
            RemoteMovieRepository.sharedInstance.getImageFromUrl(imagePath: url){ image, error in
                cell.tvImage.image = image
            }
        }
        cell.layer.cornerRadius = 10
        
        return cell
    }
    
}

extension TvCategoryRow: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemsPerRow:CGFloat = 2
        let hardCodedPadding:CGFloat = 5
        let itemWidth = (collectionView.bounds.width / itemsPerRow) - hardCodedPadding
        let itemHeight = collectionView.bounds.height - (2 * hardCodedPadding)
        return CGSize(width: itemWidth, height: itemHeight)
    }

}
