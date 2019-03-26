//
//  DisplayMoviesViewController.swift
//  Movies
//
//  Created by Arthur Castro on 21/03/19.
//  Copyright © 2019 Arthur Castro. All rights reserved.
//

import UIKit




class MoviesViewController: UIViewController, Coordinable {
    
    @IBOutlet weak var tableView: UITableView!
    //MARK: - Properties
    
    
    
    var id = String()
    
    var coordinator: Coordinator?
    var movies = [Movie]()
    
    
    //MARK: - IBO
    
  
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupTableview()
        self.fetchMovies()
        
  
    }
    
    
    func setupTableview(){
        let width = K.LayoutCell.widthInRelationToTableView * tableView.frame.size.width
        let height = K.LayoutCell.heightInRelationToWidth * width
        self.tableView.rowHeight = height
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
    }
    
    
    func fetchMovies(){
        let fetcher = MoviesFetcherFactory.default
        fetcher.fetch { (result) in
            switch result {
            case .error(let error):
                self.present(error)
            case .success(let movies):
                self.movies = movies
                self.tableView.reloadData()
            }
        }
    }
}



//MARK: - UITableViewDataSource

extension MoviesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.movies.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        if let movieCell = cell as? MovieCell {
            let _movie = self.movies[indexPath.row]
            movieCell.movie = _movie
            movieCell.posterImage.hero.id = _movie.image.absoluteString
           
        }
        
        
        
        
        
        
        return cell
    }
    
    
    
    
    
    
}


extension MoviesViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.coordinator?.present(.movieDetails, beforePresenting: { controller in
            guard let movieDetailsController = controller as? MovieDetailsViewController else {
                assertionFailure("The next controller must be of type MovieDetailsViewController")
                return
            }
            movieDetailsController.movie = self.movies[indexPath.row]
        })
   
    }
}




