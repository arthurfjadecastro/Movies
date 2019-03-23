//
//  MoviesConcern.swift
//  Movies
//
//  Created by Arthur Castro on 22/03/19.
//  Copyright © 2019 Arthur Castro. All rights reserved.
//

import Foundation
import UIKit




enum Genre {
    case action
}


struct MoviesConcern {
    
    //MARK: - Properties
     var title = String()
     var image = UIImage()
     var duration = TimeInterval()
     var genre: Genre?
     var synopsis = String()
    
    
    
    init(title: String, image: UIImage, duration: TimeInterval, genre: Genre, synopsis: String) {
        self.title = title
        self.image = image
        self.duration = duration
        self.genre = genre
        self.synopsis = synopsis
    }

}
