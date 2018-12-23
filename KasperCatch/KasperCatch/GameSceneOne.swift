//
//  GameSceneOne.swift
//  KasperCatch
//
//  Created by Jackeline Lee on 11/17/18.
//  Copyright © 2018 Jackeline Lee. All rights reserved.
//

import UIKit
import SpriteKit

struct PhysicsCategory {
    static let dog : UInt32 = 0b1
    static let item : UInt32 = 0b10
    static let badItem : UInt32 = 0b11
}

class GameSceneOne: SKScene {

    var dogString : String?
    
    
    init(size: CGSize, dogName: String){
        self.dogString = dogName
        super.init(size: size)
        //let dog = SKSpriteNode(imageNamed: dogString!)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    var doggo = SKSpriteNode()
    
    var score = 0
    let foodItem = itemsModel.sharedInstance
    let scoreLabel = SKLabelNode(fontNamed: "Chalkduster")
    let heart = SKSpriteNode(imageNamed: "heart")
    var lives = 5
    let livesLabel = SKLabelNode(fontNamed: "Chalkduster")
    var countDown = 3
    let countDownLabel = SKLabelNode(fontNamed: "Chalkduster")
    var minDuration = 1.0
    var maxDuration = 3.0
    var duration = 1.0
    
    
    override func didMove(to view: SKView) {
        backgroundColor = SKColor.black
//        let dogName = viewController.dogString
        let dog = SKSpriteNode(imageNamed: dogString!)
//        let dogName = oneGameViewControllerDelegate?.getString()
//        dogString = dogName
        dog.position = CGPoint(x: size.width * 0.5, y: size.height * 0.1)
        dog.size = CGSize(width: 100, height: 100)
        doggo = dog
        addChild(dog)
        
        scoreLabel.text = "SCORE: \(score)"
        scoreLabel.fontSize = 40
        scoreLabel.fontColor = SKColor.white
        scoreLabel.position = CGPoint(x: size.width/3, y: size.height - 60)
        addChild(scoreLabel)
        
        livesLabel.text = "\(lives)"
        livesLabel.fontSize = 30
        livesLabel.fontColor = SKColor.white
        livesLabel.position = CGPoint(x: size.width - 30, y: size.height - 60)
        heart.position = CGPoint(x: size.width - 65, y: size.height - 50)
        heart.size = CGSize(width: 50, height: 50)
        addChild(livesLabel)
        addChild(heart)
        
        physicsWorld.gravity = .zero
        physicsWorld.contactDelegate = self
        
        countDownLabel.text = "\(countDown)"
        countDownLabel.position = CGPoint(x: size.width/2, y: size.height/2)
        countDownLabel.fontSize = 50
        countDownLabel.fontColor = SKColor.white
        addChild(countDownLabel)
        
        let countDownSequence = SKAction.sequence([SKAction.wait(forDuration: 1.0),SKAction.run(countDownStart)])
        let sequence = [SKAction.run(addItem),SKAction.run(addBadItem),SKAction.wait(forDuration: duration)]
        run(SKAction.sequence([SKAction.repeat(countDownSequence, count: 4),SKAction.run(countDownEnd),SKAction.repeatForever(SKAction.sequence(sequence))]))

    }
    
    func countDownStart(){
        countDown = countDown - 1
        if countDown == 0 {
            countDownLabel.text = ("GO!!")
        }
        else {
            countDownLabel.text = ("\(countDown)")
        }
    }
    
    func countDownEnd(){
        countDownLabel.removeFromParent()
    }

    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            doggo.position.x = location.x
            doggo.position.y = location.y
        }
        doggo.physicsBody = SKPhysicsBody(circleOfRadius: doggo.size.width/3)
        doggo.physicsBody?.isDynamic = false
        doggo.physicsBody?.categoryBitMask = PhysicsCategory.dog
        doggo.physicsBody?.contactTestBitMask = PhysicsCategory.item
        doggo.physicsBody?.collisionBitMask = PhysicsCategory.item
        doggo.physicsBody?.usesPreciseCollisionDetection = true
    }
    
    
    func random() -> CGFloat {
        return CGFloat(Float(arc4random()) / 0xFFFFFFFF)
    }
    
    func random(min: CGFloat, max: CGFloat) -> CGFloat {
        return random() * (max - min) + min
    }
    
    func addItem() {
        
        let randomIndex = arc4random_uniform(10)
        let randomItem = foodItem.itemImage(at: Int(randomIndex))
        
        let item = SKSpriteNode(imageNamed: randomItem)
        item.size = CGSize(width: 50, height: 50)
        item.scale(to: item.size)
        
        item.physicsBody = SKPhysicsBody(rectangleOf: item.size)
        item.physicsBody?.isDynamic = true
        item.physicsBody?.categoryBitMask = PhysicsCategory.item
        item.physicsBody?.contactTestBitMask = PhysicsCategory.dog
        item.physicsBody?.collisionBitMask = PhysicsCategory.dog
        
        let actualX = random(min: item.size.width/2, max: size.width - item.size.width/2)
        
        item.position = CGPoint(x: actualX, y: size.height - item.size.height * 2)
        
        addChild(item)
        
        let actualDuration = random(min: CGFloat(minDuration), max: CGFloat(maxDuration))

        let actionMove = SKAction.move(to: CGPoint(x: actualX, y: item.size.height/2), duration: TimeInterval(actualDuration))
        
        let actionMoveDone = SKAction.removeFromParent()
        
        item.run(SKAction.sequence([actionMove, actionMoveDone]))

    }
    
    func addBadItem(){
        
        let randomIndex = arc4random_uniform(10) + 10
        let randomItem = foodItem.itemImage(at: Int(randomIndex))
        
        let item = SKSpriteNode(imageNamed: randomItem)
        item.size = CGSize(width: 50, height: 50)
        item.scale(to: item.size)
        
        item.physicsBody = SKPhysicsBody(rectangleOf: item.size)
        item.physicsBody?.isDynamic = true
        item.physicsBody?.categoryBitMask = PhysicsCategory.badItem
        item.physicsBody?.contactTestBitMask = PhysicsCategory.dog
        item.physicsBody?.collisionBitMask = PhysicsCategory.dog
        
        let actualX = random(min: item.size.width/2, max: size.width - item.size.width/2)
        
        item.position = CGPoint(x: actualX, y: size.height - item.size.height * 2)
        
        addChild(item)
        
        let actualDuration = random(min: CGFloat(minDuration), max: CGFloat(maxDuration))
        
        let actionMove = SKAction.move(to: CGPoint(x: actualX, y: item.size.height/2), duration: TimeInterval(actualDuration))
        
        let actionMoveDone = SKAction.removeFromParent()
        
        item.run(SKAction.sequence([actionMove, actionMoveDone]))
        
    }
    
    func didCollideWithItem(item: SKSpriteNode){
        score = score + 5
        scoreLabel.text = "SCORE: \(score)"
        if score == 25 {
            if maxDuration > 1.0 {
                maxDuration = maxDuration - 0.5
                duration = duration - 0.1
            }
        }
        if score == 50 {
            if maxDuration > 1.0 {
                maxDuration = maxDuration - 0.5
                duration = duration - 0.5
            }
        }
        if score == 75 {
            if maxDuration > 1.0 {
                maxDuration = maxDuration - 0.5
                duration = duration - 0.2
            }
        }
        if score == 100 {
            if maxDuration > 1.0 {
                maxDuration = maxDuration - 0.5
                duration = duration - 0.2
            }
        }

        item.removeFromParent()
    }
    
  
    func didCollideWithBadItem(item: SKSpriteNode){
        let sequence = SKAction.sequence([SKAction.run(blinkRed),SKAction.wait(forDuration: 0.2), SKAction.run(blinkBlack),SKAction.wait(forDuration: 0.2)])
        run(SKAction.repeat(sequence, count: 3))
        lives = lives - 1
        if lives == 0 {
            let reveal = SKTransition.flipVertical(withDuration: 0.3)
            let gameOverScene = GameOverOne(size: self.size, won: false, score: score, dog: dogString!)
            self.view?.presentScene(gameOverScene, transition: reveal)
        }
        livesLabel.text = "\(lives)"
        item.removeFromParent()

    }

    func blinkRed(){
        backgroundColor = SKColor.red
    }
    func blinkBlack(){
        backgroundColor = SKColor.black
    }
}

extension GameSceneOne: SKPhysicsContactDelegate {
    
    func didBegin(_ contact: SKPhysicsContact) {
        var firstBody : SKPhysicsBody
        var secondBody: SKPhysicsBody
        if contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask{
            firstBody = contact.bodyA
            secondBody = contact.bodyB
        }
        else {
            firstBody = contact.bodyB
            secondBody = contact.bodyA
        }
        
        if ((firstBody.categoryBitMask == PhysicsCategory.dog) && secondBody.categoryBitMask == PhysicsCategory.item){
            didCollideWithItem(item: secondBody.node as! SKSpriteNode)
        }
        if ((firstBody.categoryBitMask == PhysicsCategory.dog) && secondBody.categoryBitMask == PhysicsCategory.badItem){
            didCollideWithBadItem(item: secondBody.node as! SKSpriteNode)
        }
    }
}
