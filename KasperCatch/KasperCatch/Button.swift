//
//  Button.swift
//  KasperCatch
//
//  Created by Jackeline Lee on 11/25/18.
//  Copyright © 2018 Jackeline Lee. All rights reserved.
//

import Foundation
import SpriteKit

protocol ButtonDelegate: class {
    func playAgainButton(sender: Button)
    func homeButton(sender: Button)
}

class Button: SKSpriteNode {
    
    //weak so that you don't create a strong circular reference with the parent
    weak var delegate: ButtonDelegate!
    
    override init(texture: SKTexture?, color: SKColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    func setup() {
        isUserInteractionEnabled = true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        setScale(0.9)
        for touch: AnyObject in touches{
            
            let positionOfTouch = touch.location(in: self)
            let tappedNode = atPoint(positionOfTouch)
            let nameOfTappedNode = tappedNode.name
            switch nameOfTappedNode{
            case "playAgainButton":
                self.delegate.playAgainButton(sender: self)
            case "toMenuButton":
                self.delegate.homeButton(sender: self)
            default:
                break
            }
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        setScale(1.0)
    }
}
