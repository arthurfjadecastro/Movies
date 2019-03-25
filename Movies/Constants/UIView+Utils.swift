//
//  UIView+Utils.swift
//  Movies
//
//  Created by Arthur Castro on 25/03/19.
//  Copyright © 2019 Arthur Castro. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
 
    @IBInspectable var cornerRadius: CGFloat {
        get{
            return layer.cornerRadius
        }
        set{
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }
    
    
}
