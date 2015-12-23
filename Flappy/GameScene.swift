//
//  GameScene.swift
//  Flappy
//
//  Created by oilklenze on 15/12/23.
//  Copyright (c) 2015年 pp. All rights reserved.
//

import SpriteKit

struct  physicsCatagory {
    static let Ghost : UInt32 = 0x1 << 1
    static let Ground : UInt32 = 0x1 << 2
    static let Wall  : UInt32 = 0x1 << 3
    
}

class GameScene: SKScene {
    var Ground = SKSpriteNode ()
    var Ghost = SKSpriteNode ()
    
    var wallPair = SKNode ()
    
    var moverAndRemove = SKAction()
    
    var gameStarted = Bool()
    
    override func didMoveToView(view: SKView) {
        
        Ground = SKSpriteNode (imageNamed: "Ground")
        Ground.setScale(0.5)
        Ground.position = CGPoint (x: self.frame.width/2, y: 0 + Ground.frame.height/2 )
        Ground.physicsBody = SKPhysicsBody (rectangleOfSize: Ground.size)
        Ground.physicsBody?.categoryBitMask = physicsCatagory.Ground
        Ground.physicsBody?.collisionBitMask = physicsCatagory.Ghost
        Ground.physicsBody?.contactTestBitMask = physicsCatagory.Ghost
        Ground.physicsBody?.affectedByGravity = false
        Ground.physicsBody?.dynamic = false
        Ground.zPosition = 3
        
        
        self.addChild(Ground)
        
        Ghost = SKSpriteNode (imageNamed: "Ghost")
        Ghost.size = CGSizeMake(60, 70)
        Ghost.position = CGPoint (x: self.frame.width/2 - Ghost.frame.width, y: self.frame.height/2)
        
        Ghost.physicsBody = SKPhysicsBody(circleOfRadius: Ghost.frame.height / 2)
        Ghost.physicsBody?.categoryBitMask  = physicsCatagory.Ghost
        Ghost.physicsBody?.collisionBitMask = physicsCatagory.Ground | physicsCatagory.Wall
        Ghost.physicsBody?.contactTestBitMask = physicsCatagory.Ground | physicsCatagory.Wall
        Ghost.physicsBody?.affectedByGravity = false
        Ghost.physicsBody?.dynamic = true
        Ghost.zPosition = 2
        
        
        self.addChild(Ghost)
        
        
        
        
        
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        /* Called when a touch begins */
        if gameStarted == false{
            gameStarted = true
            Ghost.physicsBody?.affectedByGravity = true
            
            
            let spawn = SKAction.runBlock ({
                ()in
                
                self.createWalls()
                
                
            })
            
            let delay = SKAction.waitForDuration (1.5)
            let SpawnDelay = SKAction.sequence([spawn, delay])
            let spawnDelayForever = SKAction.repeatActionForever(SpawnDelay)
            self.runAction(spawnDelayForever)
            
            
            let distance = CGFloat (self.frame.width + wallPair.frame.width)
            let movePipes = SKAction.moveByX(-distance, y: 0, duration: NSTimeInterval(0.008 * distance))
            let removePipes = SKAction.removeFromParent()
            
            moverAndRemove = SKAction.sequence([movePipes , removePipes])
            Ghost.physicsBody?.velocity  = CGVectorMake(0, 0)
            Ghost.physicsBody?.applyImpulse(CGVectorMake(0, 90))
            
        }
        else{
            Ghost.physicsBody?.velocity  = CGVectorMake(0, 0)
            Ghost.physicsBody?.applyImpulse(CGVectorMake(0, 90))
        }
        
        
        
        
    }
    func createWalls () {
        
        wallPair = SKNode ()
        
        let topWall = SKSpriteNode (imageNamed: "Wall")
        let btmWall = SKSpriteNode (imageNamed: "Wall")
        
        topWall.position = CGPoint (x: self.frame.width, y:self.frame.height / 2 + 350)
        btmWall.position = CGPoint (x: self.frame.width, y:self.frame.height / 2 - 350)
        
        topWall.setScale(0.5)
        btmWall.setScale(0.5)
        
        topWall.physicsBody =   SKPhysicsBody (rectangleOfSize: topWall.size )
        topWall.physicsBody?.categoryBitMask =  physicsCatagory.Wall
        topWall.physicsBody?.collisionBitMask = physicsCatagory.Ghost
        topWall.physicsBody?.collisionBitMask = physicsCatagory.Ghost
        topWall.physicsBody?.dynamic = false
        topWall.physicsBody?.affectedByGravity = false
        
        
        btmWall.physicsBody =   SKPhysicsBody (rectangleOfSize: btmWall.size )
        btmWall.physicsBody?.categoryBitMask =  physicsCatagory.Wall
        btmWall.physicsBody?.collisionBitMask = physicsCatagory.Ghost
        btmWall.physicsBody?.collisionBitMask = physicsCatagory.Ghost
        btmWall.physicsBody?.dynamic = false
        btmWall.physicsBody?.affectedByGravity = false
        
        topWall.zRotation = CGFloat(M_PI)
        
        wallPair.addChild(topWall)
        wallPair.addChild(btmWall)
        
        var randomPosition = CGFloat.random(min: -200, max: 200)
        
        wallPair.position.y   = wallPair.position.y + randomPosition
        
        wallPair.zPosition = 1
        wallPair.runAction(moverAndRemove)
        self.addChild(wallPair)
        
    }
    
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
    
    
}
