//
//  GameViewController.swift
//  ColourCatchAssignment
//
//  Created by Steven Cao on 7/10/18.
//  Copyright © 2018 Steven Cao. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let view = self.view as! SKView? {
            // Load the SKScene from 'GameScene.swift'
            let scene = MainMenu(size: view.bounds.size)
                // Set the scale mode to scale to fit the window
                    scene.scaleMode = .aspectFill
                    // Present the scene
                    view.presentScene(scene)
                    view.ignoresSiblingOrder = true
                    view.showsFPS = true
                    view.showsNodeCount = true
            
        }
    }
}
