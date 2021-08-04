//
//  PresenterProtocol.swift
//  MoviesApp
//
//  Created by Milton Putallaz on 25/06/2021.
//

import Foundation

protocol MoviePresenterProtocol {
    func setDelegateView(_ view: MovieViewDelegate?)
    func getAvailableGenres()
}
