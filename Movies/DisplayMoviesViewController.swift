//
//  DisplayMoviesViewController.swift
//  Movies
//
//  Created by Arthur Castro on 21/03/19.
//  Copyright © 2019 Arthur Castro. All rights reserved.
//

import UIKit





class DisplayMoviesViewController: UIViewController, Coordinable {
    
    //MARK: - Properties
    
    var coordinator: Coordinator?
    var movies = MoviesConcern.fetchMovies()
    
    //MARK: - IBO
    
    @IBOutlet weak var moviesCollectionView: UICollectionView!

    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupCollectionView()
        
        
    }
    
    
    func setupCollectionView(){
        self.moviesCollectionView.dataSource = self
//        self.moviesCollectionView.delegate = self
    }
    
 

    
}



//MARK: - UICollectionViewDataSource

extension DisplayMoviesViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let _cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MoviesCollectionViewCell", for: indexPath) as! MoviesCollectionViewCell
        
        let _movie = self.movies[indexPath.item]
        
        _cell.movie = _movie
        
        return _cell
        
    }
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1 
    }
    
    
    
    
}
