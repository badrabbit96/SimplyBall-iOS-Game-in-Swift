//
//  LanuchScreen.swift
//  Simply Ball
//
//  Created by Tomek Niemczyk on 26/11/2019.
//  Copyright © 2019 Tomek Niemczyk. All rights reserved.
//

import Foundation
import SpriteKit


class LaunchScreen: SKScene{

    let newGameLabel = SKLabelNode(fontNamed: "Adventure")
    let gameName = SKLabelNode(fontNamed: "Adventure")

    override func didMove(to view: SKView) {
    
        var color = hexStringToUIColor(hex: "#191919")
        
        let background = SKShapeNode()
        background.fillColor = color
        background.path = UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width: self.size.width, height: self.size.height), cornerRadius: 0).cgPath
        background.alpha = 0.3
        background.zPosition = 0
        self.addChild(background)
        
        //background.run(SKAction.colorize(with: SKColor.purple, colorBlendFactor: 1.0, duration: 2.0))

        let rotateCircle = SKSpriteNode(imageNamed: "circle")
        rotateCircle.setScale(1)
        rotateCircle.size = CGSize(width: 400, height: 400)
        rotateCircle.position = CGPoint(x: self.size.width/2, y: self.size.height/2)
        rotateCircle.zPosition = 2
        self.addChild(rotateCircle)
        
        let rotateCircleUp = SKAction.scale(to: 1.5, duration: 1.5)
        let rotateCircleDown = SKAction.scale(to: 1, duration: 1.5)
        let rotateCircleeSequence = SKAction.sequence([rotateCircleUp,rotateCircleDown])
        rotateCircle.run(rotateCircleeSequence)
        
        let roate: Double = Double(-Double.pi / 2) * 4
        rotateCircle.run(.rotate(toAngle: CGFloat(roate), duration: 1.5))
        
        gameName.text = "Simply Ball"
        gameName.fontSize = 140
        gameName.fontColor = SKColor.white
        gameName.position = CGPoint(x: self.size.width/2, y: self.size.height * 0.8)
        gameName.zPosition = 2
        gameName.alpha = 0.0
        gameName.run(SKAction.fadeIn(withDuration: 2.0))
        self.addChild(gameName)
        
        newGameLabel.text = "START"
        newGameLabel.fontSize = 120
        newGameLabel.fontColor = SKColor.white
        newGameLabel.position = CGPoint(x: self.size.width/2, y: self.size.height * 0.15)
        newGameLabel.zPosition = 2
        newGameLabel.alpha = 0.0
        newGameLabel.name = "start"
        newGameLabel.run(SKAction.fadeIn(withDuration: 2.0))
        self.addChild(newGameLabel)
    }
    
   
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for touch: AnyObject in touches{
                   
                   let pointOfTouch  = touch.location(in: self)
                    
                   if newGameLabel.contains(pointOfTouch){
                       
                    
                    let moveTo = GameScene(size: self.size)
                    moveTo.scaleMode = self.scaleMode
                    let myTransition = SKTransition.fade(withDuration: 0.5)
                    self.view!.presentScene(moveTo, transition: myTransition)
                       
                   }
                   
                   
               }
    }
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


