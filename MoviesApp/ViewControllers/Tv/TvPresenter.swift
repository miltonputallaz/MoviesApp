//
//  TvPresenter.swift
//  MoviesApp
//
//  Created by Milton Putallaz on 04/08/2021.
//

import Foundation

class TvPresenter: TvPresenterProtocol {
    
    weak private var view: TvViewDelegate?
    private let movieRepo = MovieRepository.sharedInstance
    
    func setDelegateView(_ view: TvViewDelegate?){
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

