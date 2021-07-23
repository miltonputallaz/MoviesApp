//
//  MovieDetailPresenterDelegate.swift
//  MoviesApp
//
//  Created by Milton Putallaz on 17/07/2021.
//

import Foundation

protocol MovieDetailPresenterProtocol{
    func getMovieDetail(movieId: Int)
    func setDelegateView(_ view: MovieDetailViewDelegate)
}
