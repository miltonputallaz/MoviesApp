//
//  PresenterProtocol.swift
//  MoviesApp
//
//  Created by Milton Putallaz on 25/06/2021.
//

import Foundation

protocol HomePresenterProtocol {
    func setDelegateView(_ view: HomeViewDelegate?)
    func getAvailableGenres()
}
