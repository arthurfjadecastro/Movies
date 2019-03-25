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

class MovieCell: UITableViewCell  {
    
      let idGenerate = UUID().uuidString
    
    
    @IBOutlet weak var posterImage: UIImageView!
    
    var movie: Movie? {
        didSet{
            self.movie?.image(completion: { (result) in
                switch result {
                case .error(let error):
                    self.window?.rootViewController?.present(error)
                case .success(let image):
                    self.posterImage.hero.id = self.idGenerate
                    self.posterImage.image = image
                    
                }
            })
        }
    }
    
    
    
 
    
    
}
