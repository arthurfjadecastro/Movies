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
    
    var coordinator: Coordinator?
    
    
    
    override func viewDidLoad() {
        
    }
    @IBAction func btnBack(_ sender: Any) {
        
        self.coordinator?.present(.displayMovies)
    }
}
