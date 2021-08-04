//
//  HomeController.swift
//  MoviesApp
//
//  Created by Milton Putallaz on 25/06/2021.
//

import Foundation

protocol MovieViewDelegate: NSObjectProtocol {
    func initializeView()
    func setGenres(_ genres: [Genre])
}
