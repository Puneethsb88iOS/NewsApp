//
//  Button+ CornerRadius.swift
//  NewsApp
//
//  Created by Puneeth SB on 21/04/22.
//

import Foundation
import UIKit

extension UIButton {
    
    @IBInspectable var cornerRadius: CGFloat  {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
        }
    }
}
