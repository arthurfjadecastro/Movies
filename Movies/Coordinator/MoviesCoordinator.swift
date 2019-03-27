//
//  MoviesCoordinator.swift
//  Movies
//
//  Created by Arthur Castro on 21/03/19.
//  Copyright © 2019 Arthur Castro. All rights reserved.
//

import Foundation
import UIKit


class MoviesCoordinator: Coordinator {
    

    //MARK: - Properties
    
    ///Current controller displayed on screen
    var currentController: UIViewController

    
    //MARK: - Initializer
    
    required init(current: UIViewController) {
        self.currentController = current
    }
    
    ///Present new controller, goes through a callback before completed.
    func present(_ display: Display, beforePresenting: ((UIViewController) -> Void)?) {
        self.presentController(display, beforePresenting: beforePresenting)
    }
    
    ///Implementation remove actually controller in screen
    func dismiss() {
        self.currentController.dismiss(animated: true, completion: nil)
    }
    
    
    
    
    //MARK: - Helper methods
    
    
    /**
        Present next view controller
        - Parameter current: current controller
        - Parameter next: next controller
     
    */
    func present(with current: UIViewController,and next: UIViewController) {
        current.present(next, animated: true, completion: nil)
    }
    
    ///Install the coordinator by passing the first view controller of the project
    static func installCoordinator(){
        ///Load first viewcontroller
        guard var _initialController = UIApplication.shared.windows.first?.rootViewController as? (Coordinable & UIViewController) else {
            assertionFailure("Fail when try capture first controller")
            return
            
        }
        _initialController.coordinator = MoviesCoordinator(current: _initialController)
    }

    /**
        Instance the next viewcontroller that belongs to a coordinate style
     
        - Note: Performs a callback that transits before presenting
    */
    typealias CoordinableController = UIViewController & Coordinable
    fileprivate func presentController(_ display: Display, beforePresenting: ((UIViewController) -> Void)?  ) {
        
        let _storyBoard = UIStoryboard(name: display.storyboard, bundle: nil)
        let _controller = _storyBoard.instantiateViewController(withIdentifier: display.controller)
        guard var _nextController = _controller as? CoordinableController else {
            assertionFailure("Fail capture next controller")
            return
        }
        let _coordinator = MoviesCoordinator(current: _nextController)
        _nextController.coordinator = _coordinator
        beforePresenting?(_nextController)
        self.present(with: self.currentController, and: _nextController)
    }
    
    
    
}





