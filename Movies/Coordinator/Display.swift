//
//  Display.swift
//  Movies
//
//  Created by Arthur Castro on 21/03/19.
//  Copyright © 2019 Arthur Castro. All rights reserved.
//

import Foundation


struct Display {
    ///Reference controller
    let controller : String
    ///Reference storyboard
    let storyboard: String
    
    
    
    /**
        Add Calling Screens 
    */
    
    ///First ViewController
    static let movies = Display(controller: "Movies", storyboard: "Movies")
    ///Second ViewController
    static let movieDetails = Display(controller: "MovieDetails", storyboard: "MovieDetails")
    ///
    
    
    
}
