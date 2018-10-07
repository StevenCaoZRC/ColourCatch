//
//  MainMenu.swift
//  ColourCatchAssignment
//
//  Created by Steven Cao on 7/10/18.
//  Copyright © 2018 Steven Cao. All rights reserved.
//

import SpriteKit

class MainMenu: SKScene{
    //Creating two sprite nodes
    let Start = SKSpriteNode (imageNamed: "StartButton")
    var Title: SKLabelNode!
    var Title2: SKLabelNode!
    var HighScore: SKLabelNode!
    var CurrentScore: SKLabelNode!
    //This runs on load
    override func didMove(to view: SKView)
    {
        //Set current scene BG color
        self.backgroundColor = UIColorFromRGB(rgbValue: 0x282828)
        
        //Set right nodes size
        Start.size = CGSize(width: 160, height: 160)
        //Set the right nodes position
        Start.position = CGPoint(x: self.frame.width / 2 , y: self.frame.height / 2 - 32)
        addChild(Start)
        CreateLabel()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let location = touches.first?.location(in: self)
       if Start.contains(location!){
            let newScene = GameScene(size: (self.view?.bounds.size)!)
            let transition = SKTransition.crossFade(withDuration: 2)
            self.view?.presentScene(newScene, transition: transition)
            transition.pausesOutgoingScene = true
            transition.pausesIncomingScene = true
        }
    }
    //0xRGB
    func UIColorFromRGB(rgbValue: UInt) -> UIColor
    {
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16  ) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8  ) / 255.0,
            blue: CGFloat((rgbValue & 0x0000FF)  ) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    func CreateLabel()
    {
        //Creating Title------
        Title = SKLabelNode();
        Title.text = "COLOUR"
        //Setting font size
        Title.fontSize = 64
        //Setting font name
        Title.fontName = "AlNile-Bold"
        //Setting font position
        Title.position = CGPoint(x: self.frame.midX, y: self.frame.midY + 150)
        //Add child
        self.addChild(Title)
        
        Title2 = SKLabelNode();
        Title2.text = "CATCH"
        Title2.fontSize = 54
        Title2.fontName = "AlNile"
        Title2.position = CGPoint(x: self.frame.midX, y: self.frame.midY + 105)
        self.addChild(Title2)
        //--------
        //HightScore
        HighScore = SKLabelNode();
        HighScore.text = "BEST:"
        HighScore.fontColor = UIColorFromRGB(rgbValue: 0xff0079)
        HighScore.fontSize = 36
        HighScore.fontName = "AlNile-Bold"
        HighScore.position = CGPoint(x: self.frame.midX - 93, y: self.frame.midY - 180)
        self.addChild(HighScore)
        //Current Score
        CurrentScore = SKLabelNode();
        CurrentScore.text = "SCORE:"
        CurrentScore.fontColor = UIColorFromRGB(rgbValue: 0x00ffff)
        CurrentScore.fontSize = 30
        CurrentScore.fontName = "AlNile-Bold"
        CurrentScore.position = CGPoint(x: self.frame.midX - 87, y: self.frame.midY - 236)
        self.addChild(CurrentScore)
    }
    
}
