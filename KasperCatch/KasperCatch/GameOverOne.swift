//
//  GameOverOne.swift
//  KasperCatch
//
//  Created by Jackeline Lee on 11/19/18.
//  Copyright © 2018 Jackeline Lee. All rights reserved.
//

import UIKit
import SpriteKit

class GameOverOne: SKScene, ButtonDelegate {
    
    var doggo : String?
    let model = itemsModel.sharedInstance
    private var button = Button()
    
    init(size: CGSize, won:Bool, score: Int, dog: String){
        self.doggo = dog
        super.init(size: size)
        
        backgroundColor = SKColor.gray
        let message = won ? "You Won! :D" : "You Lose :("
        let gameOverLabel = SKLabelNode(fontNamed: "Chalkduster")
        gameOverLabel.text = message
        gameOverLabel.fontSize = 40
        gameOverLabel.fontColor = SKColor.white
        gameOverLabel.position = CGPoint(x: size.width/2, y: size.height/2+50)
        addChild(gameOverLabel)
        if model.getScore() < score {
            model.setScore(score)
            let highScoreLabel = SKLabelNode(fontNamed: "Chalkduster")
            highScoreLabel.text = "New High Score!!"
            highScoreLabel.fontSize = 35
            highScoreLabel.fontColor = SKColor.yellow
            highScoreLabel.position = CGPoint(x: size.width/2, y: (size.height/2))
            
            let scoreLabel = SKLabelNode(fontNamed: "Chalkduster")
            scoreLabel.text = "Your Score: \(score)"
            scoreLabel.fontSize = 40
            scoreLabel.fontColor = SKColor.yellow
            scoreLabel.position = CGPoint(x: size.width/2, y: (size.height/2)-50)
            addChild(scoreLabel)
            addChild(highScoreLabel)
        }
        else{
            model.setScore(score)
            let scoreLabel = SKLabelNode(fontNamed: "Chalkduster")
            scoreLabel.text = "Your Score: \(score)"
            scoreLabel.fontSize = 40
            scoreLabel.fontColor = SKColor.white
            scoreLabel.position = CGPoint(x: size.width/2, y: (size.height/2)-50)
            addChild(scoreLabel)
        }
        
        
    }
    override func didMove(to view: SKView) {
  
        let playAgainLabel = SKLabelNode(fontNamed: "Marker Felt Wide")
        playAgainLabel.text = "Play Again!"
        playAgainLabel.fontSize = 25
        playAgainLabel.fontColor = SKColor.white
        playAgainLabel.position = CGPoint(x: size.width/2, y: (size.height/2)-110)
        playAgainLabel.zPosition = 2
        addChild(playAgainLabel)
        
        let playAgainButton = Button(texture: nil, color: SKColor.red, size: CGSize(width: 150, height: 55))
        playAgainButton.name = "playAgainButton"
        playAgainButton.position = CGPoint(x: size.width/2, y: (size.height/2)-100)
        playAgainButton.delegate = self
        playAgainButton.zPosition = 1
        addChild(playAgainButton)
        
        let toMenuLabel = SKLabelNode(fontNamed: "Marker Felt Wide")
        toMenuLabel.text = "Main Menu"
        toMenuLabel.fontSize = 25
        toMenuLabel.fontColor = SKColor.white
        toMenuLabel.position = CGPoint(x: size.width/2, y: (size.height/2)-170)
        toMenuLabel.zPosition = 2
        addChild(toMenuLabel)
        
        
        let toMenuButton = Button(texture: nil, color: SKColor.blue, size: CGSize(width: 150, height: 55))
        toMenuButton.name = "toMenuButton"
        toMenuButton.position = CGPoint(x: size.width/2, y: (size.height/2)-160)
        toMenuButton.delegate = self
        toMenuButton.zPosition = 1
        addChild(toMenuButton)
    }
    
    func playAgainButton(sender: Button) {
        let scene = GameSceneOne(size: self.size, dogName: doggo!)
        let reveal = SKTransition.flipVertical(withDuration: 0.3)
        self.view?.presentScene(scene, transition: reveal)
    }
    
    
    func homeButton(sender: Button) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "MainView")
        vc.view.frame = (self.view?.window?.rootViewController?.view.frame)!
        vc.view.layoutIfNeeded()
        
        UIView.transition(with: (self.view?.window)!, duration: 0.3, options: .transitionFlipFromRight, animations: {
            self.view?.window?.rootViewController = vc
        }) { completed in
            
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
