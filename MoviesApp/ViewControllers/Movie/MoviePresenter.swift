//
//  HomePresenter.swift
//  MoviesApp
//
//  Created by Milton Putallaz on 25/06/2021.
//

import Foundation

class MoviePresenter: MoviePresenterProtocol {
    
    weak private var view: MovieViewDelegate?
    private let movieRepo = MovieRepository.sharedInstance
    
    func setDelegateView(_ view: MovieViewDelegate?){
        self.view = view
    }
    
    func getAvailableGenres() {
        let completionHandler =  {(genresListResponse:ArrayResponse<Genre>?, error:BackendError?) in
            if let genresResponse = genresListResponse {
                self.view?.setGenres(genresResponse.genres)
                print("List: \(genresResponse)")

            }
        }
        movieRepo.getAvailableGenres(completionHandler: completionHandler)
    }
    
}
