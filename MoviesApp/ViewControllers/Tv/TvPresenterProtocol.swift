//
//  TvPresenterProtocol.swift
//  MoviesApp
//
//  Created by Milton Putallaz on 04/08/2021.
//

import Foundation

protocol TvPresenterProtocol {
    func setDelegateView(_ view: TvViewDelegate?)
    func getAvailableGenres()
}
