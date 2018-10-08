//
//  GameScene.swift
//  ColourCatchAssignment
//
//  Created by Steven Cao on 7/10/18.
//  Copyright © 2018 Steven Cao. All rights reserved.
//

import SpriteKit
import GameplayKit

var GameOver : Bool = false
enum Colors: Int {
    case Yellow, Blue, Red, Purple
    mutating func next()
    {
        self = Colors(rawValue: rawValue + 1) ?? Colors.Yellow
    }
     mutating func back()
    {
        self = Colors(rawValue: rawValue - 1) ?? Colors.Purple
    }
    
}
class GameScene: SKScene {
    let ColorCircle = SKSpriteNode()
    let Player = SKSpriteNode()
    var ScoreLabel: SKLabelNode! = nil
    var Score : Int =  0
    var HighScore: Int = 0
    var Difficultly : Int = 5
    var FadeOutTime = 0;
    var Ball : String = "BlueBall"

    var CurrentColor = Colors.Yellow
    var SectionColor = Colors.Yellow
    let userDefaults = UserDefaults.standard
    override func didMove(to view: SKView) {
        self.backgroundColor = UIColorFromRGB(rgbValue: 0x282828)
        GameOver = false;
        AddLevelStuff()
        Ball = RandomPlayer()
        AddPlayer()
        Player.run(SKAction.move(to: CGPoint( x: ColorCircle.position.x ,y: ColorCircle.position.y), duration: TimeInterval(Difficultly)))
      
        MoveToCenter()
    }
    override func update(_ currentTime: TimeInterval) {
        if(ColorCircle.contains(Player.position))
        {
            if(CurrentColor == SectionColor)
            {
                Player.run(SKAction.fadeOut(withDuration: 0.5))
                MoveToCenter()
                ScoreLabel.text = String(Score)
                userDefaults.set(Score, forKey: "Score")
                if(Score >= HighScore)
                {
                    userDefaults.set(Score, forKey: "HighScore")
                }
                
            }
            else if (CurrentColor != SectionColor){
                userDefaults.set(Score, forKey: "Score")
                GameOver = true;
                let newScene = MainMenu(size: (self.view?.bounds.size)!)
                let transition = SKTransition.crossFade(withDuration: 1)
                self.view?.presentScene(newScene, transition: transition)
                transition.pausesOutgoingScene = true
                transition.pausesIncomingScene = true
            }
            if(Score >= 40)
            {
                Difficultly = 3;
            }
            else if(Score >= 90)
            {
                Difficultly = 1;
            }
        }
        
        
    }
    //0xRGB
    func UIColorFromRGB(rgbValue: UInt) -> UIColor
    {
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16  ) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8  ) / 255.0,
            blue: CGFloat((rgbValue & 0x0000FF)) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    func AddLevelStuff()
    {
        //Adding Color Wheel
        ColorCircle.texture = SKTexture(imageNamed: "ColorWheel")
        ColorCircle.size = CGSize(width: 160, height: 160)
        ColorCircle.position = CGPoint(x: self.frame.width/2, y: self.frame.height/2 - 200 )
        ColorCircle.zRotation = 0
        self.addChild(ColorCircle)
        
        ScoreLabel = SKLabelNode()
        ScoreLabel.text = String(Score)
        ScoreLabel.fontSize = 50
        ScoreLabel.fontName = "ArialRoundedMTBold"
        ScoreLabel.position = CGPoint(x: self.frame.midX, y: self.frame.midY - 330)
        self.addChild(ScoreLabel)
        
      
    }
    func AddPlayer()
    {
        //Adding Player
        Player.texture = SKTexture(imageNamed: Ball)
        Player.size = CGSize(width: 25, height: 25)
        Player.position = CGPoint(x: self.frame.width/2, y: self.frame.height/2 + 400 )
        self.addChild(Player)
    }
    func RandomPlayer() -> String
    {
        let RandVal = Int(arc4random_uniform(5) + 1)
        if(RandVal == 1)
        {
            CurrentColor = Colors.Blue
            return "BlueBall"
        }
        else if (RandVal == 2)
        {
            CurrentColor = Colors.Purple
            return "PurpleBall"
        }
        else if (RandVal == 3)
        {
            CurrentColor = Colors.Red
            return "RedBall"
        }
        else //if (RandVal == 4)
        {
            CurrentColor = Colors.Yellow
            return "YellowBall"
        }
      //  return "BlueBall"
    }
    func MoveToCenter()
    {
        if(Player.position.x == ColorCircle.position.x && Player.position.y == ColorCircle.position.y)
        {
            
           // Player.run( SKAction.wait(forDuration: 4))
            Player.run( SKAction.fadeIn(withDuration: 0.5))
            Ball = RandomPlayer()
            Score += 10;
            Player.texture = SKTexture(imageNamed: Ball)
            Player.position =  CGPoint(x: frame.width/2, y: frame.height/2 + 400 )
            Player.run(SKAction.move(to: CGPoint( x: ColorCircle.position.x ,y: ColorCircle.position.y), duration: TimeInterval(Difficultly)))
          
        
        }
        
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {

        let touch = touches.first!
        let location = touch.location(in: self)
        
        //Checks if anywhere on the left side of the screen is taped then rotates the circle
        if(location.x < (scene?.frame.width)!/2)
        {
            ColorCircle.run(SKAction.rotate(byAngle: CGFloat( Double.pi / 2), duration: 1))
            SectionColor.next()
        }
            //Checks if anywhere on the right side of the screen is tapped then rotates the circle
        else  if(location.x > (scene?.frame.width)!/2)
        {
            ColorCircle.run(SKAction.rotate(byAngle: -CGFloat( Double.pi / 2), duration: 1))
            SectionColor.back()
        }
    
    }
}

extension CGFloat{
    static func degreeToRadians(degree: CGFloat)->CGFloat{
        return((degree * CGFloat.pi)/180)
    }
}
