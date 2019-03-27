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
    ///Inspected layer where cornerRadius is changed via storyboard
    @IBInspectable var cornerRadius: CGFloat {
        get{
            return self.layer.cornerRadius
        }
        set{
            self.layer.cornerRadius = newValue
            self.layer.masksToBounds = newValue > 0
        }
    }
    
    ///Inspected layer where shadowOpacity is changed via storyboard
    @IBInspectable var shadowOpacity: Float {
        get {
            return self.layer.shadowOpacity
        }
        set{
            self.layer.shadowOpacity = newValue
        }
    }
    
    ///Inspected layer where shadowColor is changed via storyboard
    @IBInspectable var shadowColor: UIColor? {
        get {
            guard let _color = self.layer.shadowColor else { return nil }
            return UIColor(cgColor: _color)
        }
        set{
            guard let _color = newValue else {
                assertionFailure("Could not capture new color ")
                return
            }
            self.layer.shadowColor = _color.cgColor
        }
    }
    
    ///Inspected layer where shadowOffset is changed via storyboard
    @IBInspectable var shadowOffset: CGSize {
        get {
            return self.layer.shadowOffset
        }
        set{
            self.layer.shadowOffset = newValue
        }
    }
    
    ///Inspected layer where shadowRadius is changed via storyboard
    @IBInspectable var shadowRadius: CGFloat {
        get{
            return self.layer.shadowRadius
        }
        set{
            self.layer.shadowRadius = shadowRadius
        }
    }
}
