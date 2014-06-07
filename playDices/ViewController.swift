//
//  ViewController.swift
//  playDices
//
//  Created by jamszhy on 14/6/4.
//  Copyright (c) 2014年 jamszhy. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var dice1View = UIImageView()
    var dice2View = UIImageView()
    var dice3View = UIImageView()
    var timer : NSTimer? = nil
    var number = 0
    var playerLabel = UILabel()
    var bossLabel = UILabel()
    var playerMoneyLabel = UILabel()
    var bossMoneyLabel = UILabel()
    var playerMoney = 1000
    var bossMoney = 1000
    var yourSelection = 0
    var dice1Num = 0
    var dice2Num = 0
    var dice3Num = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
//        var backView = UIImageView()
//        backView.frame = CGRectMake(0,0,320,480)
//        let m1 = UIImage(named:"背景.png")
//        backView.image = m1
//        self.view.addSubview(backView)
        
        dice1View.frame = CGRectMake(0,50,100,100)
        let image = UIImage(named:"骰子1.png")
        //image.animatedImageNamed("骰子1.png", duration:1.0)
        dice1View.image = image
        self.view.addSubview(dice1View)
        
        dice2View.frame = CGRectMake(110,50,100,100)
        let image2 = UIImage(named:"骰子2.png")
        //image.animatedImageNamed("骰子1.png", duration:1.0)
        dice2View.image = image2
        self.view.addSubview(dice2View)
        
        dice3View.frame = CGRectMake(220,50,100,100)
        let image3 = UIImage(named:"骰子3.png")
        //image.animatedImageNamed("骰子1.png", duration:1.0)
        dice3View.image = image3
        self.view.addSubview(dice3View)
        
        playerLabel.frame = CGRectMake(50,250,100,50)
        playerLabel.text = "Player:"
        bossLabel.frame = CGRectMake(50,300,100,50)
        
        bossLabel.text = "Boss:"
        playerMoneyLabel.frame = CGRectMake(150,250,150,50)
        bossMoneyLabel.frame = CGRectMake(150,300,150,50)
        
        playerMoneyLabel.text = String(playerMoney)
        bossMoneyLabel.text = String(bossMoney)
        
        self.view.addSubview(playerLabel)
        self.view.addSubview(bossLabel)
        self.view.addSubview(playerMoneyLabel)
        self.view.addSubview(bossMoneyLabel)
        
        var bigButton = UIButton()
        bigButton.frame = CGRectMake(20,200,80,30)
        bigButton.backgroundColor = UIColor.blueColor()
        bigButton.setTitle("买大", forState:UIControlState.Normal)
        self.view.addSubview(bigButton)
        bigButton.addTarget(self, action: Selector.convertFromExtendedGraphemeClusterLiteral("buyBig"),forControlEvents:UIControlEvents.TouchUpInside)
        
        var sameButton = UIButton()
        sameButton.frame = CGRectMake(125,200,80,30)
        sameButton.backgroundColor = UIColor.blueColor()
        sameButton.setTitle("买豹子", forState:UIControlState.Normal)
        self.view.addSubview(sameButton)
        sameButton.addTarget(self, action: Selector.convertFromExtendedGraphemeClusterLiteral("buySame"),forControlEvents:UIControlEvents.TouchUpInside)
        
        var smallButton = UIButton()
        smallButton.frame = CGRectMake(230,200,80,30)
        smallButton.backgroundColor = UIColor.blueColor()
        smallButton.setTitle("买小", forState:UIControlState.Normal)
        self.view.addSubview(smallButton)
        smallButton.addTarget(self, action: Selector.convertFromExtendedGraphemeClusterLiteral("buySmall"),forControlEvents:UIControlEvents.TouchUpInside)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func buyBig() {
        yourSelection = 1
        if let m = timer {
            m.invalidate()
        }
        timer = NSTimer.scheduledTimerWithTimeInterval(0.1, target: self, selector: Selector.convertFromExtendedGraphemeClusterLiteral("changeImage"), userInfo: nil, repeats: true)
    }

    func buySame() {
        yourSelection = 2
        if let m = timer {
            m.invalidate()
        }
        timer = NSTimer.scheduledTimerWithTimeInterval(0.1, target: self, selector: Selector.convertFromExtendedGraphemeClusterLiteral("changeImage"), userInfo: nil, repeats: true)
    }


    func buySmall() {
        yourSelection = 3
        if let m = timer {
            m.invalidate()
        }
        timer = NSTimer.scheduledTimerWithTimeInterval(0.1, target: self, selector: Selector.convertFromExtendedGraphemeClusterLiteral("changeImage"), userInfo: nil, repeats: true)
    }
    
    func changeImage() {
        
        var i = arc4random()%6 + 1;
        var str = "骰子" + String(i) + ".png"
        var image = UIImage(named:str)
        dice1View.image = image
        dice1Num = Int(i)
        
        i = arc4random()%6 + 1;
        str = "骰子" + String(i) + ".png"
        image = UIImage(named:str)
        dice2View.image = image
        dice2Num = Int(i)
        
        i = arc4random()%6 + 1;
        str = "骰子" + String(i) + ".png"
        image = UIImage(named:str)
        dice3View.image = image
        dice3Num = Int(i)
        number++
        
        if number >= 20 {
            if let m = timer {
                number = 0
                m.invalidate()
                judgeResult()
            }
        }
    }
    
    func judgeResult() {
        if yourSelection == 1 {
            if dice1Num+dice2Num+dice3Num >= 11 {
                playerMoney += 30
                bossMoney -= 30
            }
            else {
                playerMoney -= 30
                bossMoney += 30
            }
        }
        else if yourSelection == 2 {
            if dice1Num == dice2Num && dice2Num == dice3Num  {
                playerMoney += 300
                bossMoney -= 300
            }
            else {
                playerMoney -= 300
                bossMoney += 300
            }
        }
        else if yourSelection == 3 {
            if dice1Num+dice2Num+dice3Num < 11 {
                playerMoney += 30
                bossMoney -= 30
            }
            else {
                playerMoney -= 30
                bossMoney += 30
            }
        }
        playerMoneyLabel.text = String(playerMoney)
        bossMoneyLabel.text = String(bossMoney)
    }
}

