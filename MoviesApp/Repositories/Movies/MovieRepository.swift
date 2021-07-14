//
//  MovieRepository.swift
//  MoviesApp
//
//  Created by Milton Putallaz on 30/06/2021.
//

import Foundation

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
    
    
}
