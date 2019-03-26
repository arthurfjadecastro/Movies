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
            return self.layer.cornerRadius
        }
        set{
            self.layer.cornerRadius = newValue
            self.layer.masksToBounds = newValue > 0
        }
    }
    
    
    @IBInspectable var shadowOpacity: Float {
        get {
            return self.layer.shadowOpacity
        }
        set{
            self.layer.shadowOpacity = newValue
        }
    }
    
    
    @IBInspectable var shadowColor: UIColor? {
        get {
            guard let color = self.layer.shadowColor else { return nil }
            return UIColor(cgColor: color)
        }
        set{
            guard let color = newValue else {
                assertionFailure("Could not capture new color ")
                return
            }
            self.layer.shadowColor = color.cgColor
        }
    }
    
    
    @IBInspectable var shadowOffset: CGSize {
        get {
            return self.layer.shadowOffset
        }
        set{
            self.layer.shadowOffset = newValue
        }
    }
    
    
    @IBInspectable var shadowRadius: CGFloat {
        get{
            return self.layer.shadowRadius
        }
        set{
            self.layer.shadowRadius = shadowRadius
        }
    }
    
    
    
    
    
    
}
