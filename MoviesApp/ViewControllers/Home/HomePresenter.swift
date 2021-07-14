//
//  HomePresenter.swift
//  MoviesApp
//
//  Created by Milton Putallaz on 25/06/2021.
//

import Foundation

class HomePresenter: HomePresenterProtocol {
    
    weak private var view: HomeViewDelegate?
    private let movieRepo = MovieRepository.sharedInstance
    
    func setDelegateView(_ view: HomeViewDelegate?){
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
