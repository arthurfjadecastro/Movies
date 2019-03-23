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


struct Movie {
    
    //MARK: - Properties
    let title: String
    let image: URL
    let genres: [String]
    let synopsis: String
    
    
    init(title: String, image: URL, genres: [String], synopsis: String) {
        self.title = title
        self.image = image
        self.genres = genres
        self.synopsis = synopsis
    }

}
