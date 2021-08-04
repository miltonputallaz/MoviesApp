//
//  TvView.swift
//  MoviesApp
//
//  Created by Milton Putallaz on 04/08/2021.
//

import Foundation
import UIKit

class TvView: UIViewController, UITableViewDataSource, ClickItemDelegate, TvViewDelegate {
    
    @IBOutlet weak var categoriesTableView: UITableView!
    
    
    private var presenter: TvPresenter = TvPresenter()
    private var genresList = [Genre]()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = NSLocalizedString("Discover", comment: "Discover title")
        self.categoriesTableView.delegate = self
        self.categoriesTableView.dataSource = self
        presenter.setDelegateView(self)
        initializeView()
    }
    
    func initializeView() {
        presenter.getAvailableGenres()
    }
    
    func setGenres(_ genres: [Genre]) {
        genresList = genres
        DispatchQueue.main.async { self.categoriesTableView.reloadData() }
    }


    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    
    func numberOfSections(in tableView: UITableView) -> Int {
        print("Sections count: \(genresList.count)")
        return genresList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tvCategoryCell", for: indexPath) as! TvCategoryRow
        cell.setGenre(genresList[indexPath.section])
        cell.setClickDelegate(delegate: self)
        print("Section: \(indexPath.section)")
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return genresList[section].name
    }
    
    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let notDisplayedCell = cell as! TvCategoryRow
        notDisplayedCell.setGenre(nil)
    }
    
    func onClickItem(itemId: Int) {
        goToMovieDetail(itemId)
    }
    
    private func goToMovieDetail(_ movieId: Int){
        self.performSegue(withIdentifier: "goToMovieDetail", sender: movieId)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToMovieDetail" {
            let viewController = segue.destination as! MovieDetailView
            viewController.movieId = sender as? Int
        }
    }
}

extension TvView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let itemsPerScreen:CGFloat = 2
        let hardCodedPadding:CGFloat = 5
        let itemHeight = (view.frame.height / itemsPerScreen) - hardCodedPadding
        return itemHeight
    }
}
