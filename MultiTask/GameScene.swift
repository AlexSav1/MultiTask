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
        let swipeGestureUp = UISwipeGestureRecognizer(target: self, action: #selector(GameScene.handleSwipeUp(sender:)))
        let swipeGestureDown = UISwipeGestureRecognizer(target: self, action: #selector(GameScene.handleSwipeDown(sender:)))
        
        swipeGestureLeft.direction = .left
        swipeGestureRight.direction = .right
        swipeGestureUp.direction = .up
        swipeGestureDown.direction = .down
        
        let rightSide = UIView(frame: CGRect(x: (self.view?.frame.width)!/2, y: (self.view?.frame.origin.y)!, width: (self.view?.frame.width)!/2, height: (self.view?.frame.height)!))
        
        rightSide.addGestureRecognizer(swipeGestureLeft)
        rightSide.addGestureRecognizer(swipeGestureRight)
        rightSide.addGestureRecognizer(swipeGestureUp)
        rightSide.addGestureRecognizer(swipeGestureDown)
        self.view?.addSubview(rightSide)
        
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
        
        self.spawnArrow()
    }
    
    func spawnArrow() {
        
        let arrowIndex = Int(arc4random_uniform(4))
        let arrow = arrowArray[arrowIndex]
        
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
        print("LEFT")
        if(self.children.contains(leftArrow)){
            print("GOTTEM")
            leftArrow.removeAllActions()
            leftArrow.removeFromParent()
            leftArrow.position = CGPoint(x: self.size.width, y: self.size.height/2)
            self.spawnArrow()
        }
    }
    
    func handleSwipeRight(sender: UISwipeGestureRecognizer){
        print("RIGHT")
        if(self.children.contains(rightArrow)){
            print("GOTTEM")
            rightArrow.removeAllActions()
            rightArrow.removeFromParent()
            rightArrow.position = CGPoint(x: self.size.width/2, y: self.size.height/2)
            self.spawnArrow()
        }
    }
    
    func handleSwipeUp(sender: UISwipeGestureRecognizer){
        print("UP")
        if(self.children.contains(upArrow)){
            print("GOTTEM")
            upArrow.removeAllActions()
            upArrow.removeFromParent()
            upArrow.position = CGPoint(x: self.size.width/1.3, y: 0)
            self.spawnArrow()
        }
    }
    
    func handleSwipeDown(sender: UISwipeGestureRecognizer){
        print("DOWN")
        if(self.children.contains(downArrow)){
            print("GOTTEM")
            downArrow.removeAllActions()
            downArrow.removeFromParent()
            downArrow.position = CGPoint(x: self.size.width/1.3, y: self.size.height)
            self.spawnArrow()
        }
    }
}

































