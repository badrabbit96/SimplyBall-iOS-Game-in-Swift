//
//  GameViewController.swift
//  Simply Ball
//
//  Created by Tomek Niemczyk on 14/11/2019.
//  Copyright © 2019 Tomek Niemczyk. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let view = self.view as! SKView? {
            // Load the SKScene from 'GameScene.sks'
          
           let scene = LaunchScreen(size: CGSize(width: 750, height: 1334))
            
          // let scene = SKScene(fileNamed: "GameScene")
            //   scene?.size = CGSize(width: 1536, height: 2048)

                // Set the scale mode to scale to fit the window
            scene.scaleMode = .aspectFill

                // Present the scene
                view.presentScene(scene)
            
            
            view.ignoresSiblingOrder = true
            
            //view.showsFPS = true
            //view.showsNodeCount = true
        }
    }

    override var shouldAutorotate: Bool {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
}
