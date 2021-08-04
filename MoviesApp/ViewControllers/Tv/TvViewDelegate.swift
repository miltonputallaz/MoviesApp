//
//  TvViewDelegate.swift
//  MoviesApp
//
//  Created by Milton Putallaz on 04/08/2021.
//

import Foundation

protocol TvViewDelegate: NSObjectProtocol {
    func initializeView()
    func setGenres(_ genres: [Genre])
}
