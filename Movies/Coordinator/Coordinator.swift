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
    
    var currentController: UIViewController { get }
    
    init(current: UIViewController)
    
    func present(_ display: Display)
    
    func dismiss()
    
}
