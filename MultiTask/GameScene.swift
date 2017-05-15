//
//  GameScene.swift
//  MultiTask
//
//  Created by Aditya Narayan on 5/9/17.
//
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    let leftArrow = SKSpriteNode(imageNamed: "blue-arrow-left")
    let rightArrow = SKSpriteNode(imageNamed: "blue-arrow-right")
    let upArrow = SKSpriteNode(imageNamed: "blue-arrow-up")
    let downArrow = SKSpriteNode(imageNamed: "blue-arrow-down")
    
    var arrowArray = [SKSpriteNode]()
    
    var ball: SKSpriteNode!
    var paddle: SKSpriteNode!
    
    override func didMove(to view: SKView) {
        /*
        self.player.setScale(0.7)
        self.player.position = CGPoint(x: self.size.width/2, y: 0 - self.player.size.height)
        self.player.zPosition = 2
        self.player.physicsBody = SKPhysicsBody(rectangleOf: self.player.size)
        self.player.physicsBody!.affectedByGravity = false
        self.player.physicsBody!.categoryBitMask = PhysicsCategories.Player
        self.player.physicsBody!.collisionBitMask = PhysicsCategories.None
        self.player.physicsBody!.contactTestBitMask = PhysicsCategories.Enemy
        self.addChild(self.player)
        */
        
        let swipeGestureLeft = UISwipeGestureRecognizer(target: self, action: #selector(GameScene.handleSwipeLeft(sender:)))
        let swipeGestureRight = UISwipeGestureRecognizer(target: self, action: #selector(GameScene.handleSwipeRight(sender:)))
        
        swipeGestureLeft.direction = UISwipeGestureRecognizerDirection.left
        swipeGestureRight.direction = UISwipeGestureRecognizerDirection.right
        
        //self.view?.addGestureRecognizer(swipeGestureLeft)
        //self.view?.addGestureRecognizer(swipeGestureRight)
        
        
        arrowArray = [leftArrow,rightArrow,upArrow,downArrow]
        
        leftArrow.setScale(0.1)
        leftArrow.position = CGPoint(x: self.size.width, y: self.size.height/2)
        
        rightArrow.setScale(0.1)
        rightArrow.position = CGPoint(x: self.size.width/2, y: self.size.height/2)
        
        upArrow.setScale(0.1)
        upArrow.position = CGPoint(x: self.size.width/1.3, y: 0)
        
        downArrow.setScale(0.1)
        downArrow.position = CGPoint(x: self.size.width/1.3, y: self.size.height)
        
        ball = self.childNode(withName: "Ball") as! SKSpriteNode!
        paddle = self.childNode(withName: "Paddle") as! SKSpriteNode!
        
        ball.physicsBody?.applyImpulse(CGVector(dx: 25, dy: 25))
        
        let border = SKPhysicsBody(edgeLoopFrom: (view.scene?.frame)!)
        border.friction = 0
        self.physicsBody = border
        self.startGame()
    }
    
    
    func startGame() {
        let arrowIndex = Int(arc4random_uniform(4))
        let whichArrow = arrowArray[arrowIndex]
        self.spawnArrow(arrow: whichArrow)
    }
    
    func spawnArrow(arrow: SKSpriteNode) {
        self.addChild(arrow)
        
        if(arrow === leftArrow){
            let moveLeftArrow = SKAction.moveTo(x: self.size.width/2, duration: 5)
            let endGame = SKAction.run(self.gameOver)
            let arrowSequence = SKAction.sequence([moveLeftArrow, endGame])
            arrow.run(arrowSequence)
        }
        else if(arrow === rightArrow) {
            let moveRightArrow = SKAction.moveTo(x: self.size.width, duration: 5)
            let endGame = SKAction.run(self.gameOver)
            let arrowSequence = SKAction.sequence([moveRightArrow, endGame])
            arrow.run(arrowSequence)
        }
        else if(arrow === upArrow) {
            let moveUpArrow = SKAction.moveTo(y: self.size.height, duration: 5)
            let endGame = SKAction.run(self.gameOver)
            let arrowSequence = SKAction.sequence([moveUpArrow, endGame])
            arrow.run(arrowSequence)
        }
        else if(arrow === downArrow) {
            let moveDownArrow = SKAction.moveTo(y: 0, duration: 5)
            let endGame = SKAction.run(self.gameOver)
            let arrowSequence = SKAction.sequence([moveDownArrow, endGame])
            arrow.run(arrowSequence)
        }
    
    }
    
    func gameOver() {
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let touchLocation = touch.location(in: self)
            
            if(touchLocation.x < self.size.width/2){
                paddle.position.x = touchLocation.x
            }
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let touchLocation = touch.location(in: self)
            
            if(touchLocation.x < self.size.width/2){
                paddle.position.x = touchLocation.x
            }
        }
    }
    
    func handleSwipeLeft(sender: UISwipeGestureRecognizer){
        if (sender.location(in: self.view).x > self.size.width/2){
            print("LEFT")
        }
    }
    
    func handleSwipeRight(sender: UISwipeGestureRecognizer){
        if (sender.location(in: self.view).x > self.size.width/2){
            print("RIGHT")
        }
    }
    
}

































