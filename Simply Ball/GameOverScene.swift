//
//  GameOverScene.swift
//  Simply Ball
//
//  Created by Tomek Niemczyk on 15/11/2019.
//  Copyright © 2019 Tomek Niemczyk. All rights reserved.
//

import Foundation
import SpriteKit


class GameOverScene: SKScene{
    
    let restartLabel = SKLabelNode(fontNamed: "Adventure")

    override func didMove(to view: SKView) {

        let gamOverLabel = SKLabelNode(fontNamed: "Adventure")
        gamOverLabel.text = "GAME OVER"
        gamOverLabel.fontSize = 120
        gamOverLabel.fontColor = SKColor.white
        gamOverLabel.position = CGPoint(x: self.size.width/2, y: self.size.height * 0.7)
        print(-self.size.width / 2.6)
        gamOverLabel.zPosition = 2
        gamOverLabel.alpha = 0.0
        gamOverLabel.run(SKAction.fadeIn(withDuration: 2.0))
        self.addChild(gamOverLabel)
        
        let scoreLabel = SKLabelNode(fontNamed: "Adventure")
        scoreLabel.text = "SCORE: \(score)"
        scoreLabel.fontSize = 80
        scoreLabel.fontColor = SKColor.white
        scoreLabel.position = CGPoint(x: self.size.width/2, y: self.size.height * 0.5)
        scoreLabel.zPosition = 2
        scoreLabel.alpha = 0.0
        scoreLabel.run(SKAction.fadeIn(withDuration: 2.0))
        self.addChild(scoreLabel)
        
        let defaults = UserDefaults()
        var highScore = defaults.integer(forKey: "highScoreSave")
        
        if score > highScore{
            highScore = score
            defaults.set(highScore, forKey: "highScoreSave")
        }
        
        let highScoreLabel = SKLabelNode(fontNamed: "Adventure")
        highScoreLabel.text = "HIGH SCORE: \(highScore)"
        highScoreLabel.fontSize = 80
        highScoreLabel.fontColor = SKColor.white
        highScoreLabel.position = CGPoint(x: self.size.width/2, y: self.size.height * 0.4)
        highScoreLabel.zPosition = 2
        highScoreLabel.alpha = 0.0
        highScoreLabel.run(SKAction.fadeIn(withDuration: 2.0))
        self.addChild(highScoreLabel)
        
        restartLabel.text = "RESTART"
        restartLabel.fontSize = 120
        restartLabel.fontColor = SKColor.white
        restartLabel.position = CGPoint(x: self.size.width/2, y: self.size.height * 0.2)
        print(-self.size.width / 2.6)
        restartLabel.zPosition = 2
        restartLabel.alpha = 0.0
        restartLabel.run(SKAction.fadeIn(withDuration: 2.0))
        self.addChild(restartLabel)
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for touch: AnyObject in touches{
            
            let pointOfTouch  = touch.location(in: self)
             
            if restartLabel.contains(pointOfTouch){
                
                 let moveTo = GameScene(size: self.size)
                 moveTo.scaleMode = self.scaleMode
                 let myTransition = SKTransition.fade(withDuration: 0.5)
                 self.view!.presentScene(moveTo, transition: myTransition)
            }
            
        }
        
    }
}
