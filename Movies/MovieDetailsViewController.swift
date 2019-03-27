//
//  ScreenViewController.swift
//  Movies
//
//  Created by Arthur Castro on 21/03/19.
//  Copyright © 2019 Arthur Castro. All rights reserved.
//

import Foundation
import UIKit
import Hero


/**
 class responsible for managing the elements and behaviors of the details screen of the movies.
*/
class MovieDetailsViewController: UIViewController, Coordinable  {
    
    //MARK: - IBO
    @IBOutlet weak var posterImage: UIImageView!
    @IBOutlet weak var synopsysLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var genresCollection: UICollectionView!
    
    //MARK: - Properties
    
    ///Movie in the details screen
    var movie: Movie?
    ///Responsible for coordinating the output or input of screens
    var coordinator: Coordinator?
    ///Variable used to assign new styles in text design
    var attributedString = NSMutableAttributedString()
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hero.isEnabled = true
        self.posterImage.hero.id = self.movie?.image.absoluteString
        self.setupCollectionView()
        self.performTaskMainQueue {
            self.loadMovie()
        }
    }
    
    
    //Dispatch in principal thread
    func performTaskMainQueue(task: @escaping ()-> ()) {
        DispatchQueue.main.async {
            task()
        }
    }

    ///Setup in collection tags genres
    func setupCollectionView(){
        self.genresCollection.dataSource = self
    }
    
    ///Configuration of the movie description equivalent to the proposed design
    func setupInTextSynopsys(){
        self.attributedString = NSMutableAttributedString(string: self.movie?.synopsys ?? "")
        let _paragraphStyle = NSMutableParagraphStyle()
        _paragraphStyle.lineSpacing = 6
        self.attributedString.addAttribute(NSAttributedString.Key.paragraphStyle, value: _paragraphStyle, range: NSMakeRange(0, self.attributedString.length))
        self.attributedString.addAttribute(NSAttributedString.Key.kern, value: 1, range: NSRange(location: 0, length: self.attributedString.length - 1))
    }
    
    ///Method responsible for loading the data into the visual attributes on the details screen
    func loadMovie(){
        self.setupInTextSynopsys()
        self.synopsysLabel.attributedText = self.attributedString
        self.titleLabel.text = self.movie?.title
        self.posterImage.image = nil
        self.movie?.image(completion: { (result) in
            switch result {
            case .error(let error):
                self.present(error)
            case .success(let image):
                self.posterImage.image = image
            }
        })
    }
    
    ///Action responsible for remove current view controller
    @IBAction func handleBack(_ sender: Any) {
        self.coordinator?.dismiss()
    }
}


//MARK: - UICollectionViewDataSource

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











