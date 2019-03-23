//
//  DisplayMoviesViewController.swift
//  Movies
//
//  Created by Arthur Castro on 21/03/19.
//  Copyright © 2019 Arthur Castro. All rights reserved.
//

import UIKit


fileprivate let kScale: CGFloat = 0.6

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
        let _screenSize = UIScreen.main.bounds.size
        let _cellWidth = floor(_screenSize.width * kScale)
        let _cellHeight = floor(_screenSize.height * kScale)
        let _insetX = (self.view.bounds.width - _cellWidth) / 2
        let _insetY = (self.view.bounds.height - _cellHeight) / 2
        
        let _layout = self.moviesCollectionView.collectionViewLayout as! UICollectionViewFlowLayout
        
        _layout.itemSize = CGSize(width: _cellWidth, height: _cellHeight)
        
        self.moviesCollectionView.contentInset = UIEdgeInsets(top: _insetY, left: _insetX, bottom: _insetY, right: _insetX)
        
        self.moviesCollectionView.dataSource = self
        self.moviesCollectionView.delegate = self
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


extension DisplayMoviesViewController: UIScrollViewDelegate {
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let _layout = self.moviesCollectionView.collectionViewLayout as! UICollectionViewFlowLayout
        
        let _cellWidthSpacing = _layout.itemSize.width + _layout.minimumLineSpacing
        
        var _offset = targetContentOffset.pointee
        
        let _index = (_offset.x + scrollView.contentInset.left) / _cellWidthSpacing
        
        let _roundedIndex = round(_index)
        
        _offset = CGPoint(x: _roundedIndex * _cellWidthSpacing - scrollView.contentInset.left, y: scrollView.contentInset.top)
        
        targetContentOffset.pointee = _offset
    }
    
    
}


extension DisplayMoviesViewController: UICollectionViewDelegate {
    
    
    
    
}
