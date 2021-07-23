//
//  MovieDetailViewDelegate.swift
//  MoviesApp
//
//  Created by Milton Putallaz on 17/07/2021.
//

import Foundation
import UIKit

protocol MovieDetailViewDelegate: NSObjectProtocol {
    func initializeView(_ movieId: Int)
    func setImageToView(_ image: UIImage)
    func setDetailAttributes(_ movie: Movie)
}
