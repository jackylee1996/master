//
//  Extension.swift
//  State Parks
//
//  Created by Jackeline Lee on 10/9/18.
//  Copyright © 2018 Jackeline Lee. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    
    func rotate(_ toValue: CGFloat, duration: CFTimeInterval = 0.2) {
        let animation = CABasicAnimation(keyPath: "transform.rotation")
        
        animation.toValue = toValue
        animation.duration = duration
        animation.isRemovedOnCompletion = false
        animation.fillMode = kCAFillModeForwards
        
        self.layer.add(animation, forKey: nil)
    }
}
