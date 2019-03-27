//
//  UIViewController+PresentError.swift
//  Movies
//
//  Created by Arthur Castro on 24/03/19.
//  Copyright © 2019 Arthur Castro. All rights reserved.
//

import Foundation
import UIKit



extension UIViewController {
    ///Method displays error alert
    func present(_ error: Error) {
        let _alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
        let _ok = UIAlertAction(title: "Ok", style: .default, handler: nil)
        _alert.addAction(_ok)
        self.present(_alert, animated: true, completion: nil)
    }
    
}
