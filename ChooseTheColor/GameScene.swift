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
    var timerLabel = SKLabelNode?()
    
    var colorArrayString = ["Orange", "Green", "Blue", "Red"]
    var colorArrayChoice = 0

    var tempColor = [ColorProvider.color0, ColorProvider.color1, ColorProvider.color2, ColorProvider.color3]
    var colorChoice = 0
    
    var correctSquare = 0
    
    var touchLocation = CGPoint?()
    var touchedNode = SKNode?()
    
    var isAlive = true
    var score = 0
    var countDownNumber = 12
    
    override func didMoveToView(view: SKView) {
        backgroundColor = ColorProvider.offBlackColor
        
        spawnSquare0()
        spawnSquare1()
        spawnSquare2()
        spawnSquare3()
        
        spawnMainLabel()
        spawnScoreLabel()
        spawnTimerLabel()
        
        randomizeColors()
        countDownTimer()
        resetGameVariables()
        
//        hideLabel()
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
       /* Called when a touch begins */
        
        for touch in touches {
            touchLocation = touch.locationInNode(self)
            touchedNode = nodeAtPoint(touchLocation!)
            
            if touchedNode?.name != "correct" {
                isAlive = false
                gameOverLogic()
            }
            if touchedNode?.name == "correct" {
                addToScore()
                randomizeColors()
            }
            
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
            scoreLabel.fontSize = 40
            scoreLabel.fontColor = ColorProvider.offWhiteColor
            scoreLabel.position = CGPoint(x: CGRectGetMidX(self.frame), y: CGRectGetMidY(self.frame) * 0.1)
            scoreLabel.text = "Score: \(score)"
            addChild(scoreLabel)
        }
    }
    
    func spawnTimerLabel() {
        timerLabel = SKLabelNode(fontNamed: "Futura")
        if let timerLabel = timerLabel {
            timerLabel.fontSize = 50
            timerLabel.fontColor = ColorProvider.offWhiteColor
            timerLabel.position = CGPoint(x: CGRectGetMidX(self.frame), y: CGRectGetMidY(self.frame) * 0.30)
//            timerLabel.text = "0"
            addChild(timerLabel)
        }
    }
}

// MARK: - Timer Functions
extension GameScene {
    
    func hideLabel() {
        let wait = SKAction.waitForDuration(1.5)
        let fadeOut = SKAction.fadeOutWithDuration(1.5)
        
        mainLabel?.runAction(SKAction.sequence([wait, fadeOut]))
    }
    
    func countDownTimer() {
        let wait = SKAction.waitForDuration(1.0)
        let countDown = SKAction.runBlock {
            self.countDownNumber--
            
            if self.countDownNumber <= 10 && self.isAlive {
                self.timerLabel?.text = "\(self.countDownNumber)"
            }
        }
        let sequence = SKAction.sequence([wait, countDown])
        runAction(SKAction.repeatAction(sequence, count: countDownNumber))
    }
}

// MARK: - Color controller functions
extension GameScene {
    
    func randomizeColors() {
        colorArrayChoice = Int(round(random() * 3))
        colorChoice = Int(round(random() * 3))
        correctSquare = Int(round(random() * 3))
        
        printColorCorrectSquare()
        printColors()
    }
    
    func printColors() {
        
        mainLabel?.fontColor = tempColor[colorChoice]
        mainLabel?.text = "\(colorArrayString[colorArrayChoice])"
        
    }
    
    func printColorCorrectSquare() {
        
        
        if colorChoice == 0 {
            square0?.color = tempColor[colorChoice]
            square1?.color = ColorProvider.color1
            square2?.color = ColorProvider.color2
            square3?.color = ColorProvider.color3
            
            square0?.name = "correct"
            square1?.name = "incorrect0"
            square2?.name = "incorrect1"
            square3?.name = "incorrect2"
        }
        if colorChoice == 1 {
            square0?.color = ColorProvider.color2
            square1?.color = tempColor[colorChoice]
            square2?.color = ColorProvider.color3
            square3?.color = ColorProvider.color0
            
            square0?.name = "incorrect0"
            square1?.name = "correct"
            square2?.name = "incorrect2"
            square3?.name = "incorrect3"
        }
        if colorChoice == 2 {
            square0?.color = ColorProvider.color3
            square1?.color = ColorProvider.color0
            square2?.color = tempColor[colorChoice]
            square3?.color = ColorProvider.color1
            
            square0?.name = "incorrect0"
            square1?.name = "incorrect1"
            square2?.name = "correct"
            square3?.name = "incorrect3"
        }
        if colorChoice == 3 {
            square0?.color = ColorProvider.color1
            square1?.color = ColorProvider.color2
            square2?.color = ColorProvider.color0
            square3?.color = tempColor[colorChoice]
            
            square0?.name = "incorrect0"
            square1?.name = "incorrect1"
            square2?.name = "incorrect2"
            square3?.name = "correct"
        }
    }
}

// MARK: - Score Functions
extension GameScene {
    
    func addToScore() {
        score++
        updateScore()
    }
    
    func updateScore() {
        scoreLabel?.text = "Score: \(score)"
    }
}

// MARK: - Gameover Functions
extension GameScene {
    
    func gameOverLogic() {
        mainLabel?.fontColor = ColorProvider.offWhiteColor
        mainLabel?.fontSize = 60
        mainLabel?.text = "Game Over"
        
        timerLabel?.text = "Try Again"
        
        square0?.removeFromParent()
        square1?.removeFromParent()
        square2?.removeFromParent()
        square3?.removeFromParent()
    }
    
    func resetTheGame() {
        let wait = SKAction.waitForDuration(3.0)
        let gameScene = GameScene(size: self.size)
        let transition = SKTransition.doorwayWithDuration(1.0)
        
        gameScene.scaleMode = SKSceneScaleMode.ResizeFill
        
        let changeScene = SKAction.runBlock {
            self.scene?.view?.presentScene(gameScene, transition: transition)
        }
        
        let sequence = SKAction.sequence([wait, changeScene])
        runAction(SKAction.repeatAction(sequence, count: 1))
    }
    
    func resetGameVariables() {
        isAlive = true
        score = 0
        countDownNumber = 12
        
        spawnSquare0()
        spawnSquare1()
        spawnSquare2()
        spawnSquare3()
    }
}