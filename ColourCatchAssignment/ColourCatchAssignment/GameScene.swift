//
//  GameScene.swift
//  ColourCatchAssignment
//
//  Created by Steven Cao on 7/10/18.
//  Copyright © 2018 Steven Cao. All rights reserved.
//

import SpriteKit
import GameplayKit
enum Colors {
    case Blue
    case Red
    case Yellow
    case Purple
    case None
}
class GameScene: SKScene {
    let ColorCircle = SKSpriteNode()
    let Player = SKSpriteNode()
    var ScoreLabel: SKLabelNode! = nil
    var Score : Int =  0;
    var Difficultly : Int = 5;
    var Ball : String = "BlueBall"
    var PlayerExist : Bool = false
    var CurrentColor = Colors.None
    var SectionColor = Colors.None
    
    override func didMove(to view: SKView) {
        self.backgroundColor = UIColorFromRGB(rgbValue: 0x282828)
        AddLevelStuff()
        Ball = RandomPlayer()
        AddPlayer()
        Player.run(SKAction.move(to: CGPoint( x: ColorCircle.position.x ,y: ColorCircle.position.y), duration: TimeInterval(Difficultly)))
      
        MoveToCenter()
    }
    override func update(_ currentTime: TimeInterval) {
        
        if(ColorCircle.zRotation >= (CGFloat)(316.0 * (180.0  / Float.pi)) && ColorCircle.zRotation <= (CGFloat)(45.0 * (180.0 / Float.pi)))
        {
            SectionColor = Colors.Yellow
        }
        else  if(ColorCircle.zRotation >= (CGFloat)(46.0 * (180.0  / Float.pi)) && ColorCircle.zRotation <= (CGFloat)(135.0 * (180.0 / Float.pi)))
        {
            SectionColor = Colors.Blue
        }
        else  if(ColorCircle.zRotation >= (CGFloat)(136.0 * (180.0  / Float.pi)) && ColorCircle.zRotation <= (CGFloat)(225.0 * (180.0 / Float.pi)))
        {
            SectionColor = Colors.Red
        }
        else  if(ColorCircle.zRotation >= (CGFloat)(256.0 * ( 180.0  / Float.pi)) && ColorCircle.zRotation <= (CGFloat)(315.0 * (180.0 / Float.pi)))
        {
            SectionColor = Colors.Purple
        }
        if(ColorCircle.contains(Player.position))
        {
            let TestVar = ColorCircle.zRotation
            if(CurrentColor == SectionColor)
            {
                MoveToCenter()
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
        PlayerExist = false
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
            Player.run(SKAction.fadeOut(withDuration: 2))
            Player.run( SKAction.fadeIn(withDuration: 2))
            Player.run( SKAction.wait(forDuration: 4))
            Ball = RandomPlayer()
            Player.texture = SKTexture(imageNamed: Ball)
            Player.position =  CGPoint(x: self.frame.width/2, y: self.frame.height/2 + 400 )
            Player.run(SKAction.move(to: CGPoint( x: ColorCircle.position.x ,y: ColorCircle.position.y), duration: TimeInterval(Difficultly)))
        
        }
        
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {

        let touch = touches.first!
        let location = touch.location(in: self)
        if(ColorCircle.zRotation == (CGFloat)(360.0 * (180.0 / Float.pi)))
        {
            ColorCircle.zRotation - (CGFloat)(360.0 * (180.0 / Float.pi))
        }
        if(location.x < (scene?.frame.width)!/2)
        {
            ColorCircle.run(SKAction.rotate(byAngle: CGFloat( Double.pi / 2), duration: 1))
        }
        else  if(location.x > (scene?.frame.width)!/2)
        {
            ColorCircle.run(SKAction.rotate(byAngle: -CGFloat( Double.pi / 2), duration: 1))
        }
    
    }
}
