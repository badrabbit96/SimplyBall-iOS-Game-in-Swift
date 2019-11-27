//
//  GameScene.swift
//  Simply Ball
//
//  Created by Tomek Niemczyk on 14/11/2019.
//  Copyright © 2019 Tomek Niemczyk. All rights reserved.
//

import SpriteKit
import GameplayKit

var score = 0

class GameScene: SKScene {

    var label: SKLabelNode?

    let rotateCircle = SKSpriteNode(imageNamed: "circle")

    var circleColor = 0
    var degree = 0
    
    var gameStatus = 0

    let scoreLabel = SKLabelNode(fontNamed: "Adventure")
    let newGameLabel = SKLabelNode(fontNamed: "Adventure")

    var dropTime = 1.2
    var delapyDrop = 0.0
    var rotationTime = 0.15

    override func didMove(to view: SKView) {
            
      startGame()
    }
    
    func backgroundColorChange(){
        let background = SKShapeNode()
        
        switch circleColor {
        case 0:
            background.fillColor = UIColor.green
        case 1:
            background.fillColor = UIColor.red
        case 2:
            background.fillColor = UIColor.yellow
        case 3:
            background.fillColor = UIColor.blue
        default:
            print("null")
        }
        
        background.path = UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width: self.size.width, height: self.size.height), cornerRadius: 0).cgPath
        background.alpha = 0.3
        background.zPosition = 0
        self.addChild(background)
        
    }

    func gameOver() {
       
        let changeScene = SKAction.run(moveToGameOverScene)
        let waitToChange = SKAction.wait(forDuration: 0.6)
        let changeSceneSequence = SKAction.sequence([waitToChange, changeScene])
        self.run(changeSceneSequence)
        
    }
    
    func moveToGameOverScene(){
        let moveTo = GameOverScene(size: self.size)
        moveTo.scaleMode = self.scaleMode
        let myTransition = SKTransition.fade(withDuration: 0.5)
        self.view!.presentScene(moveTo, transition: myTransition)
    }
    
    public func startGame() {
        
        rotateCircle.setScale(1)
        rotateCircle.size = CGSize(width: 400, height: 400)
        rotateCircle.position = CGPoint(x: self.size.width/2, y: self.size.height * 0.2)
        rotateCircle.zPosition = 2
        self.addChild(rotateCircle)
        
        scoreLabel.text = "0"
        scoreLabel.fontSize = 150
        scoreLabel.fontColor = SKColor.white
        //scoreLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.left
        scoreLabel.position = CGPoint(x: self.size.width * 0.15, y: self.size.height * 0.85)
        print(-self.size.width / 2.6)
        scoreLabel.zPosition = 2
        self.addChild(scoreLabel)

        backgroundColorChange()
        
        gameStatus = 0
        score = 0
        
        //let spawn = SKAction.run(spawnBall)
        //let waitToSpawn = SKAction.wait(forDuration: TimeInterval(delapyDrop))
        //let spawnSequence = SKAction.sequence([spawn, waitToSpawn])
        //let spawnForever = SKAction.repeatForever(spawnSequence)
        //self.run(spawnForever)
        
        spawnBall()
    }
    func spawnBall() {
        if gameStatus==0{
        let circle = SKShapeNode(circleOfRadius: 60)
        var color = hexStringToUIColor(hex: "#000000")
        let ballColor = Int.random(in: 0 ..< 4)

        if (ballColor == 0) {
            color = hexStringToUIColor(hex: "#3cde75") //green
        }
        if (ballColor == 1) {
            color = hexStringToUIColor(hex: "#f02c00") //red
        }
        if (ballColor == 2) {
            color = hexStringToUIColor(hex: "#fadf30") //yellow
        }
        if (ballColor == 3) {
            color = hexStringToUIColor(hex: "#00acdc") //blue
        }
        

        circle.position = CGPoint(x: self.size.width/2, y: self.size.height)
        circle.strokeColor = color
        circle.glowWidth = 1.0
        circle.fillColor = color
        circle.zPosition = 2
        self.addChild(circle)

            //fix problem with circle drop at score=0
            if score==0{
                let startMovingBall = SKAction.moveTo(y: self.size.height * 0.01, duration: dropTime)
                let ballSequence = SKAction.sequence([startMovingBall])
                circle.run(ballSequence)
            }
            else{
                let startMovingBall = SKAction.moveTo(y: self.size.height * 0.318, duration: dropTime)
                let ballSequence = SKAction.sequence([startMovingBall])
                circle.run(ballSequence)
            }
            
            let deleteBall = SKAction.removeFromParent()

            DispatchQueue.main.asyncAfter(deadline: .now() + dropTime) {
            if(ballColor == self.circleColor) {
                
                self.backgroundColorChange()
                
                score += 1
                self.scoreLabel.text = "\(score)"
                let scoreTextUp = SKAction.scale(to: 1.2, duration: 0.2)
                let scoreTextDown = SKAction.scale(to: 1, duration: 0.2)
                let scoreSequence = SKAction.sequence([scoreTextUp,scoreTextDown])
                self.scoreLabel.run(scoreSequence)
                
                let rotateCircleUp = SKAction.scale(to: 1.2, duration: 0.2)
                let rotateCircleDown = SKAction.scale(to: 1, duration: 0.2)
                let rotateCircleeSequence = SKAction.sequence([rotateCircleUp,rotateCircleDown])
                self.rotateCircle.run(rotateCircleeSequence)
                
                let ballSequence2 = SKAction.sequence([deleteBall])
                circle.run(ballSequence2)
                
                DispatchQueue.main.asyncAfter(deadline: .now() + self.delapyDrop) {
                self.spawnBall()
                }
            }
            else
            {
                self.gameStatus = 1
                // stop circle after game over
                //let ballSequence2 = SKAction.sequence([deleteBall])
                //circle.run(ballSequence2)
            
                self.gameOver()
            }
        }

    }
    }

    func pressToRotateCircle() {

        let roate: Double = Double(-Double.pi / 2) * Double(degree)
        rotateCircle.run(.rotate(toAngle: CGFloat(roate), duration: rotationTime))
    }
    

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {

        //green = 0, red = 1, yellow = 2, blue = 3

        if gameStatus == 0{
        if(circleColor == 3) {
            circleColor = 0
        }
        else {
            circleColor += 1
        }
        degree += 1
        pressToRotateCircle()
        }
    }

    // color for ball
    func hexStringToUIColor (hex: String) -> UIColor {
        var cString: String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()

        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }

        if ((cString.count) != 6) {
            return UIColor.gray
        }

        var rgbValue: UInt64 = 0
        Scanner(string: cString).scanHexInt64(&rgbValue)

        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }



}
