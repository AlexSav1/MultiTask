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
        
        arrowArray = [leftArrow,rightArrow]
        
        //leftArrow.setScale(0.2)
        leftArrow.size = CGSize(width: 30, height: 15)
        leftArrow.position = CGPoint(x: self.size.width, y: 10)
        //print(self.size.height)
        print(leftArrow.size.width)
        ball = self.childNode(withName: "Ball") as! SKSpriteNode!
        paddle = self.childNode(withName: "Paddle") as! SKSpriteNode!
        
        ball.physicsBody?.applyImpulse(CGVector(dx: 25, dy: 25))
        
        let border = SKPhysicsBody(edgeLoopFrom: (view.scene?.frame)!)
        border.friction = 0
        self.physicsBody = border
        self.startGame()
    }
    
    
    func startGame() {
        //let arrowIndex = Int(arc4random_uniform(4))
        //let whichArrow = arrowArray[arrowIndex]
        self.spawnArrow(arrow: leftArrow)
    }
    
    func spawnArrow(arrow: SKSpriteNode) {
        self.addChild(arrow)
        
        if(arrow == leftArrow){
            let moveLeftArrow = SKAction.moveTo(x: 0, duration: 10)
            let endGame = SKAction.run(self.gameOver)
            let arrowSequence = SKAction.sequence([moveLeftArrow, endGame])
            arrow.run(arrowSequence)
        }
        
    }
    
    func gameOver() {
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let touchLocation = touch.location(in: self)
            paddle.position.x = touchLocation.x
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let touchLocation = touch.location(in: self)
            paddle.position.x = touchLocation.x
        }
    }
}

































