//
//  DisplayMoviesViewController.swift
//  Movies
//
//  Created by Arthur Castro on 21/03/19.
//  Copyright © 2019 Arthur Castro. All rights reserved.
//

import UIKit





class DisplayMoviesViewController: UIViewController, Coordinable {
    
    
    var coordinator: Coordinator?
    

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    


    @IBAction func testCoordinator(_ sender: Any) {
        
        self.coordinator?.present(.newScreen)
    }
    
}
