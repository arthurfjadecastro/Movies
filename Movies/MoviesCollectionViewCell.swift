//
//  MoviesCollectionViewCell.swift
//  Movies
//
//  Created by Arthur Castro on 23/03/19.
//  Copyright © 2019 Arthur Castro. All rights reserved.
//

import Foundation
import UIKit



class MoviesCollectionViewCell: UICollectionViewCell {
    
    
    //MARK: - IBO
    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var alphaView: UIView! // polish with change color alpha plus - postponed
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var movieGenre: UILabel!
    @IBOutlet weak var movieDuration: UILabel!
    @IBOutlet weak var movieDescription: UILabel!
    
    
    
    override func layoutSubviews() {
        self.alphaView.roundCorners(corners: [.allCorners], radius: 10)
        self.movieImageView.roundCorners(corners: [.topLeft, .topRight], radius: 10)
        self.alphaView.layer.masksToBounds = true
        self.movieImageView.layer.masksToBounds = true
    }
    
    
    
//    var movie: MoviesConcern! {
//        didSet{
////            self.updateUI()
//        }
//    }
//    
    
//    func updateUI(){
//        if let _movie = self.movie {
//            self.movieImageView.image = _movie.image
//            self.movieTitle.text = _movie.title
//            self.movieDuration.text = _movie.duration
//            self.movieGenre.text = _movie.genre
//            self.movieDescription.text = _movie.synopsis
//        } else {
//            self.movieImageView.image = nil
//            self.movieTitle.text = nil
//            self.movieDuration.text = nil
//            self.movieGenre.text = nil
//            self.movieDescription.text = nil
//        }
//
//    }
    
    
}



extension UIView {

    func roundCorners(corners: UIRectCorner, radius: CGFloat) {
            let _path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
            let _mask = CAShapeLayer()
            _mask.path = _path.cgPath
            self.layer.mask = _mask
        
        
    }
}
