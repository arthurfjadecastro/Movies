//
//  MoviesCell.swift
//  Movies
//
//  Created by Arthur Castro on 24/03/19.
//  Copyright © 2019 Arthur Castro. All rights reserved.
//

import Foundation
import UIKit
import Hero

///This cell is responsible for containing the visual element of image for the movies that are viewed.
class MovieCell: UITableViewCell  {

    @IBOutlet weak var posterImage: UIImageView!
    
    ///Computed property
    var movie: Movie? {
        didSet{
            self.posterImage.image = nil
            self.movie?.image(completion: { (result) in
                switch result {
                case .error(let _error):
                    self.window?.rootViewController?.present(_error)
                case .success(let _image):
                    self.posterImage.image = _image
                }
            })
        }
    }
    
    
    
 
    
    
}
