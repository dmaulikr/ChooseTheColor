//
//  GameScene.swift
//  ChooseTheColor
//
//  Created by Greg Willis on 2/27/16.
//  Copyright (c) 2016 Willis Programming. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    
    var square0 = SKSpriteNode?()
    var square1 = SKSpriteNode?()
    var square2 = SKSpriteNode?()
    var square3 = SKSpriteNode?()
    
    var squareSize = CGSize(width: 150, height: 150)
    var squarePositionOffset : CGFloat = 85
    
    var mainLabel = SKLabelNode?()
    var scoreLabel = SKLabelNode?()
    
    var score = 0
    
    override func didMoveToView(view: SKView) {
        backgroundColor = ColorProvider.offBlackColor
        
        spawnSquare0()
        spawnSquare1()
        spawnSquare2()
        spawnSquare3()
        
        spawnMainLabel()
        spawnScoreLabel()
        
        hideLabel()
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
       /* Called when a touch begins */
        
        for touch in touches {
            let location = touch.locationInNode(self)
        }
    }
    
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}

// MARK: - Spawn Functions
extension GameScene {
    func spawnSquare0() {
        square0 = SKSpriteNode(color: ColorProvider.offWhiteColor, size: squareSize)
        if let square0 = square0 {
            square0.position = CGPoint(x: CGRectGetMidX(self.frame) - squarePositionOffset, y: CGRectGetMidY(self.frame) + squarePositionOffset)
            addChild(square0)
        }
        
    }
   
    func spawnSquare1() {
        square1 = SKSpriteNode(color: ColorProvider.offWhiteColor, size: squareSize)
        if let square1 = square1 {
            square1.position = CGPoint(x: CGRectGetMidX(self.frame) + squarePositionOffset, y: CGRectGetMidY(self.frame) + squarePositionOffset)
            addChild(square1)
        }
    }
    
    func spawnSquare2() {
        square2 = SKSpriteNode(color: ColorProvider.offWhiteColor, size: squareSize)
        if let square2 = square2 {
            square2.position = CGPoint(x: CGRectGetMidX(self.frame) - squarePositionOffset, y: CGRectGetMidY(self.frame) - squarePositionOffset)
            addChild(square2)
        }
    }
    
    func spawnSquare3() {
        square3 = SKSpriteNode(color: ColorProvider.offWhiteColor, size: squareSize)
        if let square3 = square3 {
            square3.position = CGPoint(x: CGRectGetMidX(self.frame) + squarePositionOffset, y: CGRectGetMidY(self.frame) - squarePositionOffset)
            addChild(square3)
        }
    }
    
    func spawnMainLabel() {
        mainLabel = SKLabelNode(fontNamed: "Futura")
        if let mainLabel = mainLabel {
            mainLabel.fontSize = 100
            mainLabel.fontColor = ColorProvider.offWhiteColor
            mainLabel.position = CGPoint(x: CGRectGetMidX(frame), y: CGRectGetHeight(frame) * 0.8)
            mainLabel.text = "Start!"
            
            addChild(mainLabel)
        }
    }
    
    func spawnScoreLabel() {
        scoreLabel = SKLabelNode(fontNamed: "Futura")
        if let scoreLabel = scoreLabel {
            scoreLabel.fontSize = 50
            scoreLabel.fontColor = ColorProvider.offWhiteColor
            scoreLabel.position = CGPoint(x: CGRectGetMidX(self.frame), y: CGRectGetMidY(self.frame) * 0.2)
            scoreLabel.text = "Score: \(score)"
            addChild(scoreLabel)
        }
    }
}

//MARK: - Timer Functions
extension GameScene {
    
    func hideLabel() {
        let wait = SKAction.waitForDuration(1.5)
        let fadeOut = SKAction.fadeOutWithDuration(1.5)
        
        mainLabel?.runAction(SKAction.sequence([wait, fadeOut]))
    }
}

