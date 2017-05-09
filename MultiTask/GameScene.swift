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
    
    var ball: SKSpriteNode!
    var paddle: SKSpriteNode!
    
    override func didMove(to view: SKView) {
        ball = self.childNode(withName: "Ball") as! SKSpriteNode!
        paddle = self.childNode(withName: "Paddle") as! SKSpriteNode!
        
        ball.physicsBody?.applyImpulse(CGVector(dx: 50, dy: 50))
        
        let border = SKPhysicsBody(edgeLoopFrom: (view.scene?.frame)!)
        border.friction = 0
        self.physicsBody = border
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

































