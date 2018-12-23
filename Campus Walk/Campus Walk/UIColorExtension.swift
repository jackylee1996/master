//
//  UIColorExtension.swift
//  Campus Walk
//
//  Created by Jackeline Lee on 10/15/18.
//  Copyright © 2018 Jackeline Lee. All rights reserved.
//

import Foundation

import UIKit

extension UIColor {
    static var randomColor : UIColor {return UIColor(red: CGFloat(arc4random() % 256)/255.0, green: CGFloat(arc4random() % 256)/255.0, blue: CGFloat(arc4random() % 256)/255.0, alpha: 1.0)}
    
    static var lightBlue : UIColor {return UIColor(red: 216.0/255.0, green: 241.0/255.0, blue: 155.0/255.0, alpha: 1.0)}
    
    static var mediumBlue : UIColor {return UIColor(red: 106.0/255.0, green: 133.0/255.0, blue: 255.0/255.0, alpha: 1.0)}
    
    static var darkBlue : UIColor {return UIColor(red: 1.0/255.0, green: 46.0/255.0, blue: 255.0/255.0, alpha: 1.0)}
    
    static var babyPink : UIColor {return UIColor(red: 236.0/255.0, green: 169.0/255.0, blue: 181.0/255.0, alpha: 1.0)}
    
    static var sexyYellow : UIColor {return UIColor(red: 251.0/255.0, green: 223.0/255.0, blue: 86.0/255.0, alpha: 1.0)}
}
