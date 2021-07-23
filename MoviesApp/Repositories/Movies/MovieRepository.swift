//
//  MovieRepository.swift
//  MoviesApp
//
//  Created by Milton Putallaz on 30/06/2021.
//

import Foundation
import UIKit

struct MovieRepository {
    
    static let sharedInstance = MovieRepository()
    
    private let remoteRepository = RemoteMovieRepository.sharedInstance
    
    private init(){
        
    }
    
    func getDiscoverMovies(genreId genre:Int?, completionHandler: @escaping (ListResponse<Movie>?, BackendError?) -> ()) {
        remoteRepository.getListOfMovies(genreId: genre,completion: completionHandler)
    }
    
    func getAvailableGenres(completionHandler: @escaping (ArrayResponse<Genre>?, BackendError?) -> ()) {
        remoteRepository.getArrayOf(completion: completionHandler)
    }
    
    func getMovieDetail(movieId: Int, completionHandler: @escaping (Movie?, BackendError?) -> ()){
        remoteRepository.getMovieDetail(movieId: movieId, completion: completionHandler)
    }
    
    func getMovieImageWith(imagePath path: String, completion: @escaping (UIImage?, BackendError?) -> ()){
        remoteRepository.getImageFromUrl(imagePath: path, completion: completion)
    }
    
}
