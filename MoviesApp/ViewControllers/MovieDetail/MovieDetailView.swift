//
//  DetailView.swift
//  MoviesApp
//
//  Created by Milton Putallaz on 14/07/2021.
//

import Foundation
import UIKit

class MovieDetailView: UIViewController {
    var movieId: Int?
    
    override func viewDidLoad() {
        if let id = self.movieId {
            print(id)
        }
    }
}
