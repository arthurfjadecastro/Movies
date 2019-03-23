//
//  MoviesConcern.swift
//  Movies
//
//  Created by Arthur Castro on 22/03/19.
//  Copyright © 2019 Arthur Castro. All rights reserved.
//

import Foundation
import UIKit

class MoviesConcern {
    
    //MARK: - Properties
     var title = String()
     var image = UIImage()
     var duration = String()
     var genre = String()
     var synopsis = String()
    
    
    init(title: String, image: UIImage, duration: String, genre: String, synopsis: String) {
        self.title = title
        self.image = image
        self.duration = duration
        self.genre = genre
        self.synopsis = synopsis
    }
    
    
    
    static func fetchMovies() -> [MoviesConcern] {
        return [
            MoviesConcern(title: "ae1", image:#imageLiteral(resourceName: "ae1.png") , duration: "10 hours", genre: "Fe", synopsis: "MTO LOUCO O FILME"),
            MoviesConcern(title: "ae12", image:#imageLiteral(resourceName: "ae2.png") , duration: "5 hours", genre: "MA", synopsis: "MTO LOUCO O FILME2")
            
        ]
    }
    
    
    
}
