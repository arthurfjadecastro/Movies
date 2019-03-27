//
//  Coordinator.swift
//  Movies
//
//  Created by Arthur Castro on 21/03/19.
//  Copyright © 2019 Arthur Castro. All rights reserved.
//

import Foundation
import UIKit


///Basic elements to create coordinator
protocol Coordinator {
    ///Current controller on the screen
    var currentController: UIViewController { get }
    //Initializer
    init(current: UIViewController)
    ///Method define present new screen
    func present(_ display: Display, beforePresenting: ((UIViewController) -> Void)?)
    ///Remove a current controller
    func dismiss()
    
}
