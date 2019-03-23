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
    
    var currentController: UIViewController
    
    required init(current: UIViewController) {
        self.currentController = current
    }
    
    func present(_ display: Display) {
    
        self.presentController(display)
    }
    
    func dismiss() {
        self.currentController.dismiss(animated: true, completion: nil)
    }
    
    
    
    //MARK: - Helper methods
    
    static func installCoordinator(){
        ///Load first viewcontroller
        guard var _initialController = UIApplication.shared.windows.first?.rootViewController as? (Coordinable & UIViewController) else {
            assertionFailure("fail when try capture first controller")
            return
            
        }
        _initialController.coordinator = MoviesCoordinator(current: _initialController)
    }
    
    typealias CoordinableController = UIViewController & Coordinable
    fileprivate func presentController(_ display: Display  ) {
        let _storyBoard = UIStoryboard(name: display.storyboard, bundle: nil)
        let _controller = _storyBoard.instantiateViewController(withIdentifier: display.controller)
        guard var _nextController = _controller as? CoordinableController else {
            assertionFailure("fail capture next controller")
            return
        }
        let _coordinator = MoviesCoordinator(current: _nextController)
        _nextController.coordinator = _coordinator
        self.present(with: self.currentController, and: _nextController)
    }
    
    func present(with current: UIViewController,and next: UIViewController) {
         
            next.modalTransitionStyle = .crossDissolve
            current.present(next, animated: true, completion: nil)
        
        
        
    }
    
}





