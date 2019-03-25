//
//  ScreenViewController.swift
//  Movies
//
//  Created by Arthur Castro on 21/03/19.
//  Copyright © 2019 Arthur Castro. All rights reserved.
//

import Foundation
import UIKit


class MovieDetailsViewController: UIViewController, Coordinable  {
    
    //MARK: - IBO
    @IBOutlet weak var posterImage: UIImageView!
    
    @IBOutlet weak var synopsysLabel: UILabel!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var genresCollection: UICollectionView!
    
    //MARK: - Properties
    
    var movie: Movie?
    
    var coordinator: Coordinator?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupCollectionView()
        self.loadMovie()
        
    }
    
    
    
    func setupCollectionView(){
        self.genresCollection.dataSource = self
    }
    
    func loadMovie(){
        self.synopsysLabel.text = self.movie?.synopsys
        self.titleLabel.text = self.movie?.title
        self.movie?.image(completion: { (result) in
            switch result {
            case .error(let error):
                self.present(error)
            case .success(let image):
                 self.posterImage.image = image
            }
        })
    }
    
    
    
    @IBAction func handleBack(_ sender: Any) {
        self.coordinator?.present(.displayMovies)
    }
}


extension MovieDetailsViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.movie?.genres.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "genreCell", for: indexPath)
        
        if let genreCell = cell as? GenreCell {
            genreCell.genreLabel.text = self.movie?.genres[indexPath.row]
        }
        
        return cell
    }
    
    
    
    
    
}
