//
//  ViewController.swift
//  MoviesApp
//
//  Created by Milton Putallaz on 25/06/2021.
//

import UIKit

class HomeView: UIViewController, UITableViewDataSource, HomeViewDelegate {
  
 
    @IBOutlet weak var moviesTableView: UITableView!
    
    private var presenter: HomePresenter = HomePresenter()
    private var genresList = [Genre]()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        self.moviesTableView.delegate = self
        self.moviesTableView.dataSource = self
        presenter.setDelegateView(self)
        initializeView()
    }
    
    func initializeView() {
        presenter.getAvailableGenres()
    }
    
    func setGenres(_ genres: [Genre]) {
        genresList = genres
        DispatchQueue.main.async { self.moviesTableView.reloadData() }
    }


    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    
    func numberOfSections(in tableView: UITableView) -> Int {
        print("Sections count: \(genresList.count)")
        return genresList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath) as! CategoryRow
        cell.setGenre(genresList[indexPath.section])
        cell.setOnClickListener(onClickListener: {(movieId:Int) in
            self.goToMovieDetail(movieId)
        })
        print("Section: \(indexPath.section)")
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return genresList[section].name
    }
    
    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let notDisplayedCell = cell as! CategoryRow
        notDisplayedCell.setGenre(nil)
    }
    
    private func goToMovieDetail(_ movieId: Int){
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let detailViewController = storyBoard.instantiateViewController(withIdentifier: "movieViewController") as! MovieDetailView
        self.navigationController?.pushViewController(detailViewController, animated: true)
    }
}

extension HomeView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let itemsPerScreen:CGFloat = 2
        let hardCodedPadding:CGFloat = 5
        let itemHeight = (view.frame.height / itemsPerScreen) - hardCodedPadding
        return itemHeight
    }
}
