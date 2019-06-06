//
//  GameScene.swift
//  Kelime
//
//  Created by İsa Diliballı on 7.04.2019.
//  Copyright © 2019 İsa Diliballı. All rights reserved.
//  23.04.2019 Projeye ara verildi.
//

import SpriteKit
import GameplayKit
import UIKit
import Firebase
import FirebaseDatabase


class GameScene: SKScene {
    
   
    var arkaplan = SKSpriteNode()
    var kelimekutusu = SKSpriteNode()
    
    var kelimeharf = UILabel()
    
    var cevapArray : [String] = [] // kullanılıyor
    var cevapharfArray : [String] = [] // kullanılıyor
    var soruArray : [String] = []  // kullanılıyor
    
    var kelimeArray : [String] = [] // kullanılıyor
    
    var ref : DatabaseReference!
    
    
    var soruletterAtama : [String] = []
    var cevapletterAtama : [String] = []
    
    var kelime: SKLabelNode!
    
    var cevapharf: SKLabelNode!
    
    var soru: SKLabelNode!
    
    var timer : Timer!
    var toplamZaman = 20
    var zaman: SKLabelNode!
    
    var otherQuestionWord : SKLabelNode!
    
    var cevapdolukutu : SKSpriteNode!
    var soruarkaplan : SKSpriteNode!
    
    var ck1 : SKSpriteNode!
    var ck2 : SKSpriteNode!
    var ck3 : SKSpriteNode!
    var ck4 : SKSpriteNode!
    var ck5 : SKSpriteNode!
    var k1 : SKLabelNode!
    var k2 : SKLabelNode!
    var k3 : SKLabelNode!
    var k4 : SKLabelNode!
    var k5 : SKLabelNode!
    var bk1 : SKSpriteNode!
    var bk2 : SKSpriteNode!
    var bk3 : SKSpriteNode!
    var bk4 : SKSpriteNode!
    var bk5 : SKSpriteNode!

    
    var dolukututik1 = false
    var boskutukontrol1 = false
    var dolukututik2 = false
    var boskutukontrol2 = false
    var dolukututik3 = false
    var boskutukontrol3 = false
    var dolukututik4 = false
    var boskutukontrol4 = false
    var dolukututik5 = false
    var boskutukontrol5 = false
    
    var cevapkontrol : [String] = ["ABC","ABC","ABC","ABC"]
    var cevapkontrol2 : [String] = ["ABC","ABC","ABC","ABC","ABC"]
    var cevapletter = [String]()
    var soruletter = [String]()
    var secilencevap = String()
    var cevapkontrolbirlestir = "isadiliballi"
    
    
    var timerWarning: SKLabelNode!
    var otherQuestion : SKSpriteNode!
    var finishTimerPanel : SKSpriteNode!
    
    
    
   
   
    override func didMove(to view: SKView) {
        
     
        background()  // A1
        kelimeislemleri()
       
        
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
  
        
        let touch:UITouch = touches.first!
        let positionInScene = touch.location(in: self)
        let touchedNode = self.atPoint(positionInScene)
        
        if let name = touchedNode.name
        {
            if name == "ck1" || name == "k1" {
                if dolukututik1 == false {
                    dolukututik1 = true
                    if boskutukontrol1 == false {
                        ck1.position = CGPoint(x: 115, y: self.size.height / 1.8)
                        k1.position = CGPoint(x: self.ck1.frame.midX, y: self.ck1.frame.midY)
                        boskutukontrol1 = true
                        cevapkontrol[0] = k1.text!
                        print(cevapkontrol[0])
                    }
                    else if boskutukontrol2 == false {
                        ck1.position = CGPoint(x: 245, y: self.size.height / 1.8)
                        k1.position = CGPoint(x: self.ck1.frame.midX, y: self.ck1.frame.midY)
                        boskutukontrol2 = true
                        cevapkontrol[1] = k1.text!
                        print(cevapkontrol[1])
                    }
                    else if boskutukontrol3 == false {
                        ck1.position = CGPoint(x: 375, y: self.size.height / 1.8)
                        k1.position = CGPoint(x: self.ck1.frame.midX, y: self.ck1.frame.midY)
                        boskutukontrol3 = true
                        cevapkontrol[2] = k1.text!
                        print(cevapkontrol[2])
                    }
                    else if boskutukontrol4 == false {
                        ck1.position = CGPoint(x: 505, y: self.size.height / 1.8)
                        k1.position = CGPoint(x: self.ck1.frame.midX, y: self.ck1.frame.midY)
                        boskutukontrol4 = true
                        cevapkontrol[3] = k1.text!
                        print(cevapkontrol[3])
                    }
                    else {}
                }
                else
                {
                   // cevapkontrol.removeAll()
                    
                    dolukututik1 = false
                    ck1.position = CGPoint(x: 115, y: self.size.height / 2.2)
                    k1.position = CGPoint(x: ck1.frame.midX, y: self.ck1.frame.midY)
                    
                    dolukututik2 = false
                    ck2.position = CGPoint(x: 245, y: self.size.height / 2.2)
                    k2.position = CGPoint(x: ck2.frame.midX, y: self.ck2.frame.midY)
                    
                    dolukututik3 = false
                    ck3.position = CGPoint(x: 375, y: self.size.height / 2.2)
                    k3.position = CGPoint(x: ck3.frame.midX, y: self.ck3.frame.midY)
                    
                    dolukututik4 = false
                    ck4.position = CGPoint(x: 505, y: self.size.height / 2.2)
                    k4.position = CGPoint(x: ck4.frame.midX, y: self.ck4.frame.midY)
                    
                    if boskutukontrol1 == true {
                        boskutukontrol1 = false
                    }
                    if boskutukontrol2 == true {
                        boskutukontrol2 = false
                    }
                    if boskutukontrol3 == true {
                        boskutukontrol3 = false
                    }
                    if boskutukontrol4 == true {
                        boskutukontrol4 = false
                    }
                }
            }
            
            
            if name == "ck2" || name == "k2" {
                if dolukututik2 == false {
                    dolukututik2 = true
                    if boskutukontrol1 == false {
                        ck2.position = CGPoint(x: 115, y: self.size.height / 1.8)
                        k2.position = CGPoint(x: ck2.frame.midX, y: self.ck2.frame.midY)
                        boskutukontrol1 = true
                        cevapkontrol[0] = k2.text!
                        print(cevapkontrol[0])
                      
                    }
                    else if boskutukontrol2 == false {
                        ck2.position = CGPoint(x: 245, y: self.size.height / 1.8)
                        k2.position = CGPoint(x: ck2.frame.midX, y: self.ck2.frame.midY)
                        boskutukontrol2 = true
                        cevapkontrol[1] = k2.text!
                        print(cevapkontrol[1])
                      
                    }
                    else if boskutukontrol3 == false {
                        ck2.position = CGPoint(x: 375, y: self.size.height / 1.8)
                        k2.position = CGPoint(x: ck2.frame.midX, y: self.ck2.frame.midY)
                        boskutukontrol3 = true
                        cevapkontrol[2] = k2.text!
                        print(cevapkontrol[2])
                        
                    }
                    else if boskutukontrol4 == false {
                        ck2.position = CGPoint(x: 505, y: self.size.height / 1.8)
                        k2.position = CGPoint(x: ck2.frame.midX, y: self.ck2.frame.midY)
                        boskutukontrol4 = true
                        cevapkontrol[3] = k2.text!
                        print(cevapkontrol[3])
                        
                    }
                    else {
                        
                    }
                }
                else
                {
                   
                    
                    dolukututik1 = false
                    ck1.position = CGPoint(x: 115, y: self.size.height / 2.2)
                    k1.position = CGPoint(x: ck1.frame.midX, y: self.ck1.frame.midY)
                    
                    dolukututik2 = false
                    ck2.position = CGPoint(x: 245, y: self.size.height / 2.2)
                    k2.position = CGPoint(x: ck2.frame.midX, y: self.ck2.frame.midY)
                    
                    dolukututik3 = false
                    ck3.position = CGPoint(x: 375, y: self.size.height / 2.2)
                    k3.position = CGPoint(x: ck3.frame.midX, y: self.ck3.frame.midY)
                    
                    dolukututik4 = false
                    ck4.position = CGPoint(x: 505, y: self.size.height / 2.2)
                    k4.position = CGPoint(x: ck4.frame.midX, y: self.ck4.frame.midY)
                    
                    if boskutukontrol1 == true {
                        boskutukontrol1 = false
                    }
                    if boskutukontrol2 == true {
                        boskutukontrol2 = false
                    }
                    if boskutukontrol3 == true {
                        boskutukontrol3 = false
                    }
                    if boskutukontrol4 == true {
                        boskutukontrol4 = false
                    }
                    
                }
            }
            
            
            if name == "ck3" || name == "k3" {
                if dolukututik3 == false {
                    dolukututik3 = true
                    if boskutukontrol1 == false {
                        ck3.position = CGPoint(x: 115, y: self.size.height / 1.8)
                        k3.position = CGPoint(x: ck3.frame.midX, y: self.ck3.frame.midY)
                        boskutukontrol1 = true
                        cevapkontrol[0] = k3.text!
                        print(cevapkontrol[0])
                    }
                    else if boskutukontrol2 == false {
                        ck3.position = CGPoint(x: 245, y: self.size.height / 1.8)
                        k3.position = CGPoint(x: ck3.frame.midX, y: self.ck3.frame.midY)
                        boskutukontrol2 = true
                        cevapkontrol[1] = k3.text!
                        print(cevapkontrol[1])
                    }
                    else if boskutukontrol3 == false {
                        ck3.position = CGPoint(x: 375, y: self.size.height / 1.8)
                        k3.position = CGPoint(x: ck3.frame.midX, y: self.ck3.frame.midY)
                        boskutukontrol3 = true
                        cevapkontrol[2] = k3.text!
                        print(cevapkontrol[2])
                    }
                    else if boskutukontrol4 == false {
                        ck3.position = CGPoint(x: 505, y: self.size.height / 1.8)
                        k3.position = CGPoint(x: ck3.frame.midX, y: self.ck3.frame.midY)
                        boskutukontrol4 = true
                        cevapkontrol[3] = k3.text!
                        print(cevapkontrol[3])
                    }
                    else {
                        
                    }
                }
                else
                {
                 //   cevapkontrol.removeAll()
                    
                    dolukututik1 = false
                    ck1.position = CGPoint(x: 115, y: self.size.height / 2.2)
                    k1.position = CGPoint(x: ck1.frame.midX, y: self.ck1.frame.midY)
                    
                    dolukututik2 = false
                    ck2.position = CGPoint(x: 245, y: self.size.height / 2.2)
                    k2.position = CGPoint(x: ck2.frame.midX, y: self.ck2.frame.midY)
                    
                    dolukututik3 = false
                    ck3.position = CGPoint(x: 375, y: self.size.height / 2.2)
                    k3.position = CGPoint(x: ck3.frame.midX, y: self.ck3.frame.midY)
                    
                    dolukututik4 = false
                    ck4.position = CGPoint(x: 505, y: self.size.height / 2.2)
                    k4.position = CGPoint(x: ck4.frame.midX, y: self.ck4.frame.midY)
                    
                    if boskutukontrol1 == true {
                        boskutukontrol1 = false
                    }
                    if boskutukontrol2 == true {
                        boskutukontrol2 = false
                    }
                    if boskutukontrol3 == true {
                        boskutukontrol3 = false
                    }
                    if boskutukontrol4 == true {
                        boskutukontrol4 = false
                    }
                    
                }
            }
            
            if name == "ck4" || name == "k4" {
                if dolukututik4 == false {
                    dolukututik4 = true
                    if boskutukontrol1 == false {
                        ck4.position = CGPoint(x: 115, y: self.size.height / 1.8)
                        k4.position = CGPoint(x: ck4.frame.midX, y: self.ck4.frame.midY)
                        boskutukontrol1 = true
                        cevapkontrol[0] = k4.text!
                        print(cevapkontrol[0])
                    }
                    else if boskutukontrol2 == false {
                        ck4.position = CGPoint(x: 245, y: self.size.height / 1.8)
                        k4.position = CGPoint(x: ck4.frame.midX, y: self.ck4.frame.midY)
                        boskutukontrol2 = true
                        cevapkontrol[1] = k4.text!
                        print(cevapkontrol[1])
                    }
                    else if boskutukontrol3 == false {
                        ck4.position = CGPoint(x: 375, y: self.size.height / 1.8)
                        k4.position = CGPoint(x: ck4.frame.midX, y: self.ck4.frame.midY)
                        boskutukontrol3 = true
                        cevapkontrol[2] = k4.text!
                        print(cevapkontrol[2])
                    }
                    else if boskutukontrol4 == false {
                        ck4.position = CGPoint(x: 505, y: self.size.height / 1.8)
                        k4.position = CGPoint(x: ck4.frame.midX, y: self.ck4.frame.midY)
                        boskutukontrol4 = true
                        cevapkontrol[3] = k4.text!
                        print(cevapkontrol[3])
                    }
                    else {
                        
                    }
                }
                else
                {
             
                    
                    dolukututik1 = false
                    ck1.position = CGPoint(x: 115, y: self.size.height / 2.2)
                    k1.position = CGPoint(x: ck1.frame.midX, y: self.ck1.frame.midY)
                    
                    dolukututik2 = false
                    ck2.position = CGPoint(x: 245, y: self.size.height / 2.2)
                    k2.position = CGPoint(x: ck2.frame.midX, y: self.ck2.frame.midY)
                    
                    dolukututik3 = false
                    ck3.position = CGPoint(x: 375, y: self.size.height / 2.2)
                    k3.position = CGPoint(x: ck3.frame.midX, y: self.ck3.frame.midY)
                    
                    dolukututik4 = false
                    ck4.position = CGPoint(x: 505, y: self.size.height / 2.2)
                    k4.position = CGPoint(x: ck4.frame.midX, y: self.ck4.frame.midY)
                    
                    if boskutukontrol1 == true {
                        boskutukontrol1 = false
                    }
                    if boskutukontrol2 == true {
                        boskutukontrol2 = false
                    }
                    if boskutukontrol3 == true {
                        boskutukontrol3 = false
                    }
                    if boskutukontrol4 == true {
                        boskutukontrol4 = false
                    }
                }
                
            }
      

        }
      
        self.cevapkontrolbirlestir = cevapkontrol.joined(separator: "")
        if self.secilencevap == self.cevapkontrolbirlestir
        {
            self.cevapkontrol = ["A","B","C","D"]
            self.soru.removeFromParent()
            self.bk1.removeFromParent()
            self.bk2.removeFromParent()
            self.bk3.removeFromParent()
            self.bk4.removeFromParent()
            self.ck1.removeFromParent()
            self.ck2.removeFromParent()
            self.ck3.removeFromParent()
            self.ck4.removeFromParent()
            self.k1.removeFromParent()
            self.k2.removeFromParent()
            self.k3.removeFromParent()
            self.k4.removeFromParent()
            self.soruarkaplan.removeFromParent()
            self.zaman.removeFromParent()
            
            dolukututik1 = false
            dolukututik2 = false
            dolukututik3 = false
            dolukututik4 = false
            boskutukontrol1 = false
            boskutukontrol2 = false
            boskutukontrol3 = false
            boskutukontrol4 = false
            
            return soruislemleri2()
        }
        
        
        if let name = touchedNode.name
        {
            if name == "ck11" || name == "k11" {
                if dolukututik1 == false {
                    dolukututik1 = true
                    if boskutukontrol1 == false {
                        ck1.position = CGPoint(x: 75, y: self.size.height / 1.8)
                        k1.position = CGPoint(x: self.ck1.frame.midX, y: self.ck1.frame.midY)
                        boskutukontrol1 = true
                        cevapkontrol2[0] = k1.text!
                    }
                    else if boskutukontrol2 == false {
                        ck1.position = CGPoint(x: 195, y: self.size.height / 1.8)
                        k1.position = CGPoint(x: self.ck1.frame.midX, y: self.ck1.frame.midY)
                        boskutukontrol2 = true
                        cevapkontrol2[1] = k1.text!
                    }
                    else if boskutukontrol3 == false {
                        ck1.position = CGPoint(x: 315, y: self.size.height / 1.8)
                        k1.position = CGPoint(x: self.ck1.frame.midX, y: self.ck1.frame.midY)
                        boskutukontrol3 = true
                        cevapkontrol2[2] = k1.text!
                    }
                    else if boskutukontrol4 == false {
                        ck1.position = CGPoint(x: 435, y: self.size.height / 1.8)
                        k1.position = CGPoint(x: self.ck1.frame.midX, y: self.ck1.frame.midY)
                        boskutukontrol4 = true
                        cevapkontrol2[3] = k1.text!
                    }
                    else if boskutukontrol5 == false {
                        ck1.position = CGPoint(x: 555, y: self.size.height / 1.8)
                        k1.position = CGPoint(x: ck1.frame.midX, y: self.ck1.frame.midY)
                        boskutukontrol5 = true
                        cevapkontrol2[4] = k1.text!
                    }

                    else {}
                }
                else
                {
                    dolukututik1 = false
                    ck1.position = CGPoint(x: 75, y: self.size.height / 2.2)
                    k1.position = CGPoint(x: ck1.frame.midX, y: self.ck1.frame.midY)
                    
                    dolukututik2 = false
                    ck2.position = CGPoint(x: 195, y: self.size.height / 2.2)
                    k2.position = CGPoint(x: ck2.frame.midX, y: self.ck2.frame.midY)
                    
                    dolukututik3 = false
                    ck3.position = CGPoint(x: 315, y: self.size.height / 2.2)
                    k3.position = CGPoint(x: ck3.frame.midX, y: self.ck3.frame.midY)
                    
                    dolukututik4 = false
                    ck4.position = CGPoint(x: 435, y: self.size.height / 2.2)
                    k4.position = CGPoint(x: ck4.frame.midX, y: self.ck4.frame.midY)
                    
                    dolukututik5 = false
                    ck5.position = CGPoint(x: 555, y: self.size.height / 2.2)
                    k5.position = CGPoint(x: ck5.frame.midX, y: self.ck5.frame.midY)
                    
                    if boskutukontrol1 == true {
                        boskutukontrol1 = false
                    }
                    if boskutukontrol2 == true {
                        boskutukontrol2 = false
                    }
                    if boskutukontrol3 == true {
                        boskutukontrol3 = false
                    }
                    if boskutukontrol4 == true {
                        boskutukontrol4 = false
                    }
                    if boskutukontrol5 == true {
                        boskutukontrol5 = false
                    }                }
            }
            
            
            if name == "ck22" || name == "k22" {
                if dolukututik2 == false {
                    dolukututik2 = true
                    if boskutukontrol1 == false {
                        ck2.position = CGPoint(x: 75, y: self.size.height / 1.8)
                        k2.position = CGPoint(x: ck2.frame.midX, y: self.ck2.frame.midY)
                        boskutukontrol1 = true
                        cevapkontrol2[0] = k5.text!
                        
                    }
                    else if boskutukontrol2 == false {
                        ck2.position = CGPoint(x: 195, y: self.size.height / 1.8)
                        k2.position = CGPoint(x: ck2.frame.midX, y: self.ck2.frame.midY)
                        boskutukontrol2 = true
                        cevapkontrol2[1] = k5.text!
                        
                    }
                    else if boskutukontrol3 == false {
                        ck2.position = CGPoint(x: 315, y: self.size.height / 1.8)
                        k2.position = CGPoint(x: ck2.frame.midX, y: self.ck2.frame.midY)
                        boskutukontrol3 = true
                        cevapkontrol2[2] = k5.text!
                        
                    }
                    else if boskutukontrol4 == false {
                        ck2.position = CGPoint(x: 435, y: self.size.height / 1.8)
                        k2.position = CGPoint(x: ck2.frame.midX, y: self.ck2.frame.midY)
                        boskutukontrol4 = true
                        cevapkontrol2[3] = k5.text!
                        
                    }
                    else if boskutukontrol5 == false {
                        ck2.position = CGPoint(x: 555, y: self.size.height / 1.8)
                        k2.position = CGPoint(x: ck2.frame.midX, y: self.ck2.frame.midY)
                        boskutukontrol5 = true
                        cevapkontrol2[4] = k5.text!
                    }

                    else {
                        
                    }
                }
                else
                {
                    dolukututik1 = false
                    ck1.position = CGPoint(x: 75, y: self.size.height / 2.2)
                    k1.position = CGPoint(x: ck1.frame.midX, y: self.ck1.frame.midY)
                    
                    dolukututik2 = false
                    ck2.position = CGPoint(x: 195, y: self.size.height / 2.2)
                    k2.position = CGPoint(x: ck2.frame.midX, y: self.ck2.frame.midY)
                    
                    dolukututik3 = false
                    ck3.position = CGPoint(x: 315, y: self.size.height / 2.2)
                    k3.position = CGPoint(x: ck3.frame.midX, y: self.ck3.frame.midY)
                    
                    dolukututik4 = false
                    ck4.position = CGPoint(x: 435, y: self.size.height / 2.2)
                    k4.position = CGPoint(x: ck4.frame.midX, y: self.ck4.frame.midY)
                    
                    dolukututik5 = false
                    ck5.position = CGPoint(x: 555, y: self.size.height / 2.2)
                    k5.position = CGPoint(x: ck5.frame.midX, y: self.ck5.frame.midY)
                    
                    if boskutukontrol1 == true {
                        boskutukontrol1 = false
                    }
                    if boskutukontrol2 == true {
                        boskutukontrol2 = false
                    }
                    if boskutukontrol3 == true {
                        boskutukontrol3 = false
                    }
                    if boskutukontrol4 == true {
                        boskutukontrol4 = false
                    }
                    if boskutukontrol5 == true {
                        boskutukontrol5 = false
                    }
                    
                }
            }
            
            
            if name == "ck33" || name == "k33" {
                if dolukututik3 == false {
                    dolukututik3 = true
                    if boskutukontrol1 == false {
                        ck3.position = CGPoint(x: 75, y: self.size.height / 1.8)
                        k3.position = CGPoint(x: ck3.frame.midX, y: self.ck3.frame.midY)
                        boskutukontrol1 = true
                        cevapkontrol2[0] = k3.text!
                    }
                    else if boskutukontrol2 == false {
                        ck3.position = CGPoint(x: 195, y: self.size.height / 1.8)
                        k3.position = CGPoint(x: ck3.frame.midX, y: self.ck3.frame.midY)
                        boskutukontrol2 = true
                        cevapkontrol2[1] = k3.text!
                    }
                    else if boskutukontrol3 == false {
                        ck3.position = CGPoint(x: 315, y: self.size.height / 1.8)
                        k3.position = CGPoint(x: ck3.frame.midX, y: self.ck3.frame.midY)
                        boskutukontrol3 = true
                        cevapkontrol2[2] = k3.text!
                    }
                    else if boskutukontrol4 == false {
                        ck3.position = CGPoint(x: 435, y: self.size.height / 1.8)
                        k3.position = CGPoint(x: ck3.frame.midX, y: self.ck3.frame.midY)
                        boskutukontrol4 = true
                        cevapkontrol2[3] = k3.text!
                    }
                    else if boskutukontrol5 == false {
                        ck3.position = CGPoint(x: 555, y: self.size.height / 1.8)
                        k3.position = CGPoint(x: ck3.frame.midX, y: self.ck3.frame.midY)
                        boskutukontrol5 = true
                        cevapkontrol2[4] = k3.text!
                    }

                    else {
                        
                    }
                }
                else
                {
                  
                    
                    dolukututik1 = false
                    ck1.position = CGPoint(x: 75, y: self.size.height / 2.2)
                    k1.position = CGPoint(x: ck1.frame.midX, y: self.ck1.frame.midY)
                    
                    dolukututik2 = false
                    ck2.position = CGPoint(x: 195, y: self.size.height / 2.2)
                    k2.position = CGPoint(x: ck2.frame.midX, y: self.ck2.frame.midY)
                    
                    dolukututik3 = false
                    ck3.position = CGPoint(x: 315, y: self.size.height / 2.2)
                    k3.position = CGPoint(x: ck3.frame.midX, y: self.ck3.frame.midY)
                    
                    dolukututik4 = false
                    ck4.position = CGPoint(x: 435, y: self.size.height / 2.2)
                    k4.position = CGPoint(x: ck4.frame.midX, y: self.ck4.frame.midY)
                    
                    dolukututik5 = false
                    ck5.position = CGPoint(x: 555, y: self.size.height / 2.2)
                    k5.position = CGPoint(x: ck5.frame.midX, y: self.ck5.frame.midY)
                    
                    if boskutukontrol1 == true {
                        boskutukontrol1 = false
                    }
                    if boskutukontrol2 == true {
                        boskutukontrol2 = false
                    }
                    if boskutukontrol3 == true {
                        boskutukontrol3 = false
                    }
                    if boskutukontrol4 == true {
                        boskutukontrol4 = false
                    }
                    if boskutukontrol5 == true {
                        boskutukontrol5 = false
                    }
                }
            }
            
            if name == "ck44" || name == "k44" {
                if dolukututik4 == false {
                    dolukututik4 = true
                    if boskutukontrol1 == false {
                        ck4.position = CGPoint(x: 75, y: self.size.height / 1.8)
                        k4.position = CGPoint(x: ck4.frame.midX, y: self.ck4.frame.midY)
                        boskutukontrol1 = true
                        cevapkontrol2[0] = k4.text!
                    }
                    else if boskutukontrol2 == false {
                        ck4.position = CGPoint(x: 195, y: self.size.height / 1.8)
                        k4.position = CGPoint(x: ck4.frame.midX, y: self.ck4.frame.midY)
                        boskutukontrol2 = true
                        cevapkontrol2[1] = k4.text!
                    }
                    else if boskutukontrol3 == false {
                        ck4.position = CGPoint(x: 315, y: self.size.height / 1.8)
                        k4.position = CGPoint(x: ck4.frame.midX, y: self.ck4.frame.midY)
                        boskutukontrol3 = true
                        cevapkontrol2[2] = k4.text!
                    }
                    else if boskutukontrol4 == false {
                        ck4.position = CGPoint(x: 435, y: self.size.height / 1.8)
                        k4.position = CGPoint(x: ck4.frame.midX, y: self.ck4.frame.midY)
                        boskutukontrol4 = true
                        cevapkontrol2[3] = k4.text!
                    }
                    else if boskutukontrol5 == false {
                        ck4.position = CGPoint(x: 555, y: self.size.height / 1.8)
                        k4.position = CGPoint(x: ck4.frame.midX, y: self.ck4.frame.midY)
                        boskutukontrol5 = true
                        cevapkontrol2[4] = k4.text!                    }

                    else {
                        
                    }
                }
                else
                {
                    
                    
                    dolukututik1 = false
                    ck1.position = CGPoint(x: 75, y: self.size.height / 2.2)
                    k1.position = CGPoint(x: ck1.frame.midX, y: self.ck1.frame.midY)
                    
                    dolukututik2 = false
                    ck2.position = CGPoint(x: 195, y: self.size.height / 2.2)
                    k2.position = CGPoint(x: ck2.frame.midX, y: self.ck2.frame.midY)
                    
                    dolukututik3 = false
                    ck3.position = CGPoint(x: 315, y: self.size.height / 2.2)
                    k3.position = CGPoint(x: ck3.frame.midX, y: self.ck3.frame.midY)
                    
                    dolukututik4 = false
                    ck4.position = CGPoint(x: 435, y: self.size.height / 2.2)
                    k4.position = CGPoint(x: ck4.frame.midX, y: self.ck4.frame.midY)
                    
                    dolukututik5 = false
                    ck5.position = CGPoint(x: 555, y: self.size.height / 2.2)
                    k5.position = CGPoint(x: ck5.frame.midX, y: self.ck5.frame.midY)
                    
                    if boskutukontrol1 == true {
                        boskutukontrol1 = false
                    }
                    if boskutukontrol2 == true {
                        boskutukontrol2 = false
                    }
                    if boskutukontrol3 == true {
                        boskutukontrol3 = false
                    }
                    if boskutukontrol4 == true {
                        boskutukontrol4 = false
                    }
                    if boskutukontrol5 == true {
                        boskutukontrol5 = false
                    }                }
                
            }
            if name == "ck55" || name == "k55" {
                if dolukututik5 == false {
                    dolukututik5 = true
                    if boskutukontrol1 == false {
                        ck5.position = CGPoint(x: 75, y: self.size.height / 1.8)
                        k5.position = CGPoint(x: ck5.frame.midX, y: self.ck5.frame.midY)
                        boskutukontrol1 = true
                        cevapkontrol2[0] = k4.text!
                    }
                    else if boskutukontrol2 == false {
                        ck5.position = CGPoint(x: 195, y: self.size.height / 1.8)
                        k5.position = CGPoint(x: ck5.frame.midX, y: self.ck5.frame.midY)
                        boskutukontrol2 = true
                        cevapkontrol2[1] = k4.text!
                    }
                    else if boskutukontrol3 == false {
                        ck5.position = CGPoint(x: 315, y: self.size.height / 1.8)
                        k5.position = CGPoint(x: ck5.frame.midX, y: self.ck5.frame.midY)
                        boskutukontrol3 = true
                        cevapkontrol2[2] = k4.text!
                    }
                    else if boskutukontrol4 == false {
                        ck5.position = CGPoint(x: 435, y: self.size.height / 1.8)
                        k5.position = CGPoint(x: ck5.frame.midX, y: self.ck5.frame.midY)
                        boskutukontrol4 = true
                        cevapkontrol2[3] = k4.text!
                    }
                    else if boskutukontrol5 == false {
                        ck5.position = CGPoint(x: 555, y: self.size.height / 1.8)
                        k5.position = CGPoint(x: ck5.frame.midX, y: self.ck5.frame.midY)
                        boskutukontrol5 = true
                        cevapkontrol2[4] = k5.text!
                    }
                    else {
                        
                    }
                }
                else
                {
                    
                    
                    dolukututik1 = false
                    ck1.position = CGPoint(x: 75, y: self.size.height / 2.2)
                    k1.position = CGPoint(x: ck1.frame.midX, y: self.ck1.frame.midY)
                    
                    dolukututik2 = false
                    ck2.position = CGPoint(x: 195, y: self.size.height / 2.2)
                    k2.position = CGPoint(x: ck2.frame.midX, y: self.ck2.frame.midY)
                    
                    dolukututik3 = false
                    ck3.position = CGPoint(x: 315, y: self.size.height / 2.2)
                    k3.position = CGPoint(x: ck3.frame.midX, y: self.ck3.frame.midY)
                    
                    dolukututik4 = false
                    ck4.position = CGPoint(x: 435, y: self.size.height / 2.2)
                    k4.position = CGPoint(x: ck4.frame.midX, y: self.ck4.frame.midY)
                    
                    dolukututik5 = false
                    ck5.position = CGPoint(x: 555, y: self.size.height / 2.2)
                    k5.position = CGPoint(x: ck5.frame.midX, y: self.ck5.frame.midY)
                    
                    if boskutukontrol1 == true {
                        boskutukontrol1 = false
                    }
                    if boskutukontrol2 == true {
                        boskutukontrol2 = false
                    }
                    if boskutukontrol3 == true {
                        boskutukontrol3 = false
                    }
                    if boskutukontrol4 == true {
                        boskutukontrol4 = false
                    }
                    if boskutukontrol5 == true {
                        boskutukontrol5 = false
                    }
                }
                
            }
          if name == "otherQuestion"
          {
          
          timerWarning.text = "BİTTİ"
            timerWarning.fontColor = UIColor.red
            timerWarning.fontSize = 200
        
            }
            
        }
        self.cevapkontrolbirlestir = cevapkontrol2.joined(separator: "")
        if self.secilencevap == self.cevapkontrolbirlestir
        {
             soru.text = "BİTTİ"
            self.cevapkontrol2 = ["A","B","C","D","E"]
          //  self.soru.removeFromParent()
            self.bk1.removeFromParent()
            self.bk2.removeFromParent()
            self.bk3.removeFromParent()
            self.bk4.removeFromParent()
            self.bk5.removeFromParent()
            self.ck1.removeFromParent()
            self.ck2.removeFromParent()
            self.ck3.removeFromParent()
            self.ck4.removeFromParent()
            self.ck5.removeFromParent()
            self.k1.removeFromParent()
            self.k2.removeFromParent()
            self.k3.removeFromParent()
            self.k4.removeFromParent()
            self.k5.removeFromParent()
            self.soruarkaplan.removeFromParent()
            self.zaman.removeFromParent()
            
            dolukututik1 = false
            dolukututik2 = false
            dolukututik3 = false
            dolukututik4 = false
            dolukututik5 = false
            boskutukontrol1 = false
            boskutukontrol2 = false
            boskutukontrol3 = false
            boskutukontrol4 = false
            boskutukontrol5 = false
            
           
        }
    }
    
  
 
 
    // (A1) ARKAPLAN RESİM AYARLARI
      func background()
    {
        let backgroundimage = SKTexture(imageNamed: "background.png")
        arkaplan = SKSpriteNode(texture: backgroundimage)
        arkaplan.position = CGPoint(x: 0, y: 0)
        arkaplan.zPosition = 0
        arkaplan.setScale(2)
        self.addChild(arkaplan)
    }
    // A1 SON
    
   
    
    func kelimeislemleri()
    {
        let randomsayi = Int.random(in: 1..<3) // kelime sayısı ile değiştirilecek ÖNEMLİ
        let randomsayistring = String(randomsayi)
    
        ref = Database.database().reference()
        ref.child("Kelimeler").child(randomsayistring).observeSingleEvent(of: .value, with: { (snapshot) in
            let value = snapshot.value as? NSDictionary
            let kelimeler = value?["kelime"] as? String ?? ""
            
            // (XX) kelimeArray İÇİNDEKİ ELEMANI HARFLERİNE AYIRMA İŞLEMİ
            let atama = kelimeler
            let harfArray = atama.map {String($0)}
            self.kelimeArray = harfArray
            // XX SON
            
            // (XX) KELİME HARF SAYISINI BULMA İŞLEMİ
           // let kelimeharfsayisi = harfArray.count
            // XX SON
            
            
            
            var xPos = CGFloat(Double("37.5")!)
            
            for i in 0..<harfArray.count {
                let kelimedizi = harfArray[i]
                let kelimeler = kelimedizi
                
                let kelimekutusu = SKSpriteNode(imageNamed: "kelimekutusu.png")
                kelimekutusu.position = CGPoint(x: xPos, y: self.size.height / 5)
                kelimekutusu.zPosition = 1
                kelimekutusu.setScale(0.27)
                kelimekutusu.anchorPoint = CGPoint(x: 0, y: 0)
                xPos += 135
                self.addChild(kelimekutusu)
                
                self.kelime = SKLabelNode(fontNamed: "Avenir")
                self.kelime.text = kelimeler
                self.kelime.fontSize = 80
                self.kelime.zPosition = 2
                self.kelime.fontColor = UIColor.black
                self.kelime.verticalAlignmentMode = .center
                self.kelime.horizontalAlignmentMode = .center
                self.kelime.position = CGPoint(x: kelimekutusu.frame.midX, y: kelimekutusu.frame.midY)
                self.addChild(self.kelime)
            }
            
  
            
            self.soruislemleri()
            
       
           
            
        }) { (error) in
            print(error.localizedDescription)
        }
    }  // kelimeislemleri() SON
    
   
    func soruislemleri()
    {
       
           ref = Database.database().reference()
      
        for n in 1...8 // VERİ TABANINDAKİ CEVAP VEYA SORU SAYISI İLE DEĞİŞTİRİLECEL... (ÖNEMLİ)
            {
                // Veri tabanındaki bütün soru ve cevaplar cevapArray ve soruArray dizilerine atandı.
                let art = String(n)
                ref.child("Sorular").child("4harf").child(art).observeSingleEvent(of: .value) { (snapshot) in
                    let value = snapshot.value as? NSDictionary
                    let cevaplarArray = [value?["cevap"] as? String ?? ""]
                     self.cevapArray += cevaplarArray
                    let sorularArray = [value?["soru"] as? String ?? ""]
                    self.soruArray += sorularArray
                    
                    if n == 8 // VERİ TABANINDAKİ CEVAP VEYA SORU SAYISI İLE DEĞİŞTİRİLECEK... (ÖNEMLİ)
                    {
                        // cevapArray dizisinin eleman sayısı sabite atandı.
                        let cevapArrayLength = self.cevapArray.count
                        
                       
                        
                        for i in 0..<cevapArrayLength
                        {
                            // cevapArray dizisindeki bütün elemanların ilk harfleri sabite atandı.
                            let firstletter = self.cevapArray[i].prefix(1)
                            
                            
                            // kelimeArray dizisinin ilk elamanı (Dizi İçinde Harfler Var) cevapArrayin ilk harfi ile eşit mi kontrol edildi.
                            if firstletter == self.kelimeArray[0]
                            {
                                // Belirli bir harf ile başlayan soru ve cevap dizilere atandı.
                                self.cevapletter += [self.cevapArray[i]]
                                self.soruletter += [self.soruArray[i]]
                            
                            }
                           
                           
                        }
                        // Belirli bir harf ile başlayan cevaplar arasından rasgele bir cevap ve sorusu seçildi.
                        if self.cevapletter.isEmpty == false
                        {
                        let randomsayi = Int.random(in: 0..<self.cevapletter.count)
                        self.secilencevap = self.cevapletter[randomsayi]
                        let secilensoru = self.soruletter[randomsayi]
                         print(self.secilencevap)
                         print(secilensoru)
                            
                            
                            // Dizi içerisindeki eleman harflerine ayrıldı.
                            let atama = self.secilencevap
                            var harfArray = atama.map {String($0)}
                            self.cevapharfArray = harfArray
                            print(self.cevapharfArray)
                      
                            
                           // Cevabın harfleri kutular içine random şekilde atandı.
                            var randomharf = [String]()
                            
                            for _ in 0..<harfArray.count
                            {
                                let rand = Int(arc4random_uniform(UInt32(harfArray.count)))
                                randomharf.append(harfArray[rand])
                                harfArray.remove(at: rand)
                               
                                
                                
                                let randomstring = randomharf.joined(separator: "")
                                if randomstring == self.secilencevap
                                {
                                    print("HARF DÜZENİ AYNI")
                                    return self.soruislemleri()
                                }
                              
                              
                            }
                            
                            self.ck1 = SKSpriteNode(imageNamed: "cevapdolukutu.png")
                            self.ck1.position = CGPoint(x: 115, y: self.size.height / 2.2)
                            self.ck1.zPosition = 2
                            self.ck1.setScale(0.25)
                            self.ck1.anchorPoint = CGPoint(x: 0, y: 0)
                            self.ck1.isUserInteractionEnabled = false
                            self.ck1.name = "ck1"
                            self.addChild(self.ck1)
                            
                            self.k1 = SKLabelNode(fontNamed: "Avenir")
                            self.k1.text = randomharf[0]
                            self.k1.fontSize = 70
                            self.k1.zPosition = 3
                            self.k1.fontColor = UIColor.white
                            self.k1.verticalAlignmentMode = .center
                            self.k1.horizontalAlignmentMode = .center
                            self.k1.position = CGPoint(x: self.ck1.frame.midX, y: self.ck1.frame.midY)
                            self.k1.name = "k1"
                            self.addChild(self.k1)
                            
                            self.ck2 = SKSpriteNode(imageNamed: "cevapdolukutu.png")
                            self.ck2.position = CGPoint(x: 245, y: self.size.height / 2.2)
                            self.ck2.zPosition = 2
                            self.ck2.setScale(0.25)
                            self.ck2.anchorPoint = CGPoint(x: 0, y: 0)
                            self.ck2.isUserInteractionEnabled = false
                            self.ck2.name = "ck2"
                            self.addChild(self.ck2)
                            
                            self.k2 = SKLabelNode(fontNamed: "Avenir")
                            self.k2.text = randomharf[1]
                            self.k2.fontSize = 70
                            self.k2.zPosition = 3
                            self.k2.fontColor = UIColor.white
                            self.k2.verticalAlignmentMode = .center
                            self.k2.horizontalAlignmentMode = .center
                            self.k2.position = CGPoint(x: self.ck2.frame.midX, y: self.ck2.frame.midY)
                            self.k2.name = "k2"
                            self.addChild(self.k2)
                            
                            self.ck3 = SKSpriteNode(imageNamed: "cevapdolukutu.png")
                            self.ck3.position = CGPoint(x: 375, y: self.size.height / 2.2)
                            self.ck3.zPosition = 2
                            self.ck3.setScale(0.25)
                            self.ck3.anchorPoint = CGPoint(x: 0, y: 0)
                            self.ck3.isUserInteractionEnabled = false
                            self.ck3.name = "ck3"
                            self.addChild(self.ck3)
                            
                            self.k3 = SKLabelNode(fontNamed: "Avenir")
                            self.k3.text = randomharf[2]
                            self.k3.fontSize = 70
                            self.k3.zPosition = 3
                            self.k3.fontColor = UIColor.white
                            self.k3.verticalAlignmentMode = .center
                            self.k3.horizontalAlignmentMode = .center
                            self.k3.position = CGPoint(x: self.ck3.frame.midX, y: self.ck3.frame.midY)
                            self.k3.name = "k3"
                            self.addChild(self.k3)
                            
                            self.ck4 = SKSpriteNode(imageNamed: "cevapdolukutu.png")
                            self.ck4.position = CGPoint(x: 505, y: self.size.height / 2.2)
                            self.ck4.zPosition = 2
                            self.ck4.setScale(0.25)
                            self.ck4.anchorPoint = CGPoint(x: 0, y: 0)
                            self.ck4.isUserInteractionEnabled = false
                            self.ck4.name = "ck4"
                            self.addChild(self.ck4)
                            
                            self.k4 = SKLabelNode(fontNamed: "Avenir")
                            self.k4.text = randomharf[3]
                            self.k4.fontSize = 70
                            self.k4.zPosition = 3
                            self.k4.fontColor = UIColor.white
                            self.k4.verticalAlignmentMode = .center
                            self.k4.horizontalAlignmentMode = .center
                            self.k4.position = CGPoint(x: self.ck4.frame.midX, y: self.ck4.frame.midY)
                            self.k4.name = "k4"
                            self.addChild(self.k4)
                            
                            
                            self.bk1 = SKSpriteNode(imageNamed: "cevapboskutu.png")
                            self.bk1.position = CGPoint(x: 115, y: self.size.height / 1.8)
                            self.bk1.zPosition = 1
                            self.bk1.setScale(0.25)
                            self.bk1.anchorPoint = CGPoint(x: 0, y: 0)
                            self.bk1.isUserInteractionEnabled = false
                            self.bk1.name = "bk1"
                            self.addChild(self.bk1)
                            
                            self.bk2 = SKSpriteNode(imageNamed: "cevapboskutu.png")
                            self.bk2.position = CGPoint(x: 245, y: self.size.height / 1.8)
                            self.bk2.zPosition = 1
                            self.bk2.setScale(0.25)
                            self.bk2.anchorPoint = CGPoint(x: 0, y: 0)
                            self.bk2.isUserInteractionEnabled = false
                            self.bk2.name = "bk2"
                            self.addChild(self.bk2)
                            
                            self.bk3 = SKSpriteNode(imageNamed: "cevapboskutu.png")
                            self.bk3.position = CGPoint(x: 375, y: self.size.height / 1.8)
                            self.bk3.zPosition = 1
                            self.bk3.setScale(0.25)
                            self.bk3.anchorPoint = CGPoint(x: 0, y: 0)
                            self.bk3.isUserInteractionEnabled = false
                            self.bk3.name = "bk3"
                            self.addChild(self.bk3)
                            
                            self.bk4 = SKSpriteNode(imageNamed: "cevapboskutu.png")
                            self.bk4.position = CGPoint(x: 505, y: self.size.height / 1.8)
                            self.bk4.zPosition = 1
                            self.bk4.setScale(0.25)
                            self.bk4.anchorPoint = CGPoint(x: 0, y: 0)
                            self.bk4.isUserInteractionEnabled = false
                            self.bk4.name = "bk4"
                            self.addChild(self.bk4)
                            
                                let xPoz = CGFloat(Double("0")!)
                                
                                self.soruarkaplan = SKSpriteNode(imageNamed: "soruarkaplan.png")
                                self.soruarkaplan.position = CGPoint(x: xPoz, y: self.size.height / 1.5)
                                self.soruarkaplan.zPosition = 1
                                self.soruarkaplan.setScale(1)
                                self.soruarkaplan.anchorPoint = CGPoint(x: 0, y: 0)
                                self.addChild(self.soruarkaplan)
                                
                            
                                self.soru = SKLabelNode(fontNamed: "Avenir")
                                self.soru.text = secilensoru
                                self.soru.zPosition = 2
                                self.soru.lineBreakMode = .byWordWrapping
                                self.soru.numberOfLines = 0
                                self.soru.preferredMaxLayoutWidth = self.frame.maxX
                                self.soru.verticalAlignmentMode = .center
                                self.soru.fontColor = UIColor.white
                                self.soru.position = CGPoint(x: self.soruarkaplan.frame.midX, y: self.soruarkaplan.frame.midY)
                                self.addChild(self.soru)
                            
                           
                            self.startTimer()
                            self.zamanlabel()
                        }
                        
                    }
                }
        }
        
        
    } // soruislemleri() SON
    
    func soruislemleri2()
    {
        
        ref = Database.database().reference()
        
        for n in 1...7 // VERİ TABANINDAKİ CEVAP VEYA SORU SAYISI İLE DEĞİŞTİRİLECEL... (ÖNEMLİ)
        {
            // Veri tabanındaki bütün soru ve cevaplar cevapArray ve soruArray dizilerine atandı.
            let art = String(n)
            ref.child("Sorular").child("5harf").child(art).observeSingleEvent(of: .value) { (snapshot) in
                let value = snapshot.value as? NSDictionary
                let cevaplarArray = [value?["cev"] as? String ?? ""]
                self.cevapArray += cevaplarArray
                let sorularArray = [value?["sor"] as? String ?? ""]
                self.soruArray += sorularArray
                
                if n == 7 // VERİ TABANINDAKİ CEVAP VEYA SORU SAYISI İLE DEĞİŞTİRİLECEK... (ÖNEMLİ)
                {
                    // cevapArray dizisinin eleman sayısı sabite atandı.
                    let cevapArrayLength = self.cevapArray.count
                    
                    
                    
                    for i in 0..<cevapArrayLength
                    {
                        // cevapArray dizisindeki bütün elemanların ilk harfleri sabite atandı.
                        let firstletter = self.cevapArray[i].prefix(1)
                        
                        
                        // kelimeArray dizisinin ilk elamanı (Dizi İçinde Harfler Var) cevapArrayin ilk harfi ile eşit mi kontrol edildi.
                        if firstletter == self.kelimeArray[1]
                        {
                            // Belirli bir harf ile başlayan soru ve cevap dizilere atandı.
                            self.cevapletter += [self.cevapArray[i]]
                            self.soruletter += [self.soruArray[i]]
                            
                        }
                        
                        
                    }
                    // Belirli bir harf ile başlayan cevaplar arasından rasgele bir cevap ve sorusu seçildi.
                    if self.cevapletter.isEmpty == false
                    {
                        let randomsayi = Int.random(in: 0..<self.cevapletter.count)
                        self.secilencevap = self.cevapletter[randomsayi]
                        let secilensoru = self.soruletter[randomsayi]
                        print(self.secilencevap)
                        print(secilensoru)
                        
                        
                        // Dizi içerisindeki eleman harflerine ayrıldı.
                        let atama = self.secilencevap
                        var harfArray = atama.map {String($0)}
                        self.cevapharfArray = harfArray
                        print(self.cevapharfArray)
                        
                        
                        // Cevabın harfleri kutular içine random şekilde atandı.
                        var randomharf = [String]()
                        
                        for _ in 0..<harfArray.count
                        {
                            let rand = Int(arc4random_uniform(UInt32(harfArray.count)))
                            randomharf.append(harfArray[rand])
                            harfArray.remove(at: rand)
                            
                            
                            
                            let randomstring = randomharf.joined(separator: "")
                            if randomstring == self.secilencevap
                            {
                                print("HARF DÜZENİ AYNI")
                                return self.soruislemleri()
                            }
                            
                            
                        }
                        
                        self.ck1 = SKSpriteNode(imageNamed: "cevapdolukutu.png")
                        self.ck1.position = CGPoint(x: 75, y: self.size.height / 2.2)
                        self.ck1.zPosition = 2
                        self.ck1.setScale(0.24)
                        self.ck1.anchorPoint = CGPoint(x: 0, y: 0)
                        self.ck1.isUserInteractionEnabled = false
                        self.ck1.name = "ck11"
                        self.addChild(self.ck1)
                        
                        self.k1 = SKLabelNode(fontNamed: "Avenir")
                        self.k1.text = randomharf[0]
                        self.k1.fontSize = 70
                        self.k1.zPosition = 3
                        self.k1.fontColor = UIColor.white
                        self.k1.verticalAlignmentMode = .center
                        self.k1.horizontalAlignmentMode = .center
                        self.k1.position = CGPoint(x: self.ck1.frame.midX, y: self.ck1.frame.midY)
                        self.k1.name = "k11"
                        self.addChild(self.k1)
                        
                        self.ck2 = SKSpriteNode(imageNamed: "cevapdolukutu.png")
                        self.ck2.position = CGPoint(x: 195, y: self.size.height / 2.2)
                        self.ck2.zPosition = 2
                        self.ck2.setScale(0.24)
                        self.ck2.anchorPoint = CGPoint(x: 0, y: 0)
                        self.ck2.isUserInteractionEnabled = false
                        self.ck2.name = "ck22"
                        self.addChild(self.ck2)
                        
                        self.k2 = SKLabelNode(fontNamed: "Avenir")
                        self.k2.text = randomharf[1]
                        self.k2.fontSize = 70
                        self.k2.zPosition = 3
                        self.k2.fontColor = UIColor.white
                        self.k2.verticalAlignmentMode = .center
                        self.k2.horizontalAlignmentMode = .center
                        self.k2.position = CGPoint(x: self.ck2.frame.midX, y: self.ck2.frame.midY)
                        self.k2.name = "k22"
                        self.addChild(self.k2)
                        
                        self.ck3 = SKSpriteNode(imageNamed: "cevapdolukutu.png")
                        self.ck3.position = CGPoint(x: 315, y: self.size.height / 2.2)
                        self.ck3.zPosition = 2
                        self.ck3.setScale(0.24)
                        self.ck3.anchorPoint = CGPoint(x: 0, y: 0)
                        self.ck3.isUserInteractionEnabled = false
                        self.ck3.name = "ck33"
                        self.addChild(self.ck3)
                        
                        self.k3 = SKLabelNode(fontNamed: "Avenir")
                        self.k3.text = randomharf[2]
                        self.k3.fontSize = 70
                        self.k3.zPosition = 3
                        self.k3.fontColor = UIColor.white
                        self.k3.verticalAlignmentMode = .center
                        self.k3.horizontalAlignmentMode = .center
                        self.k3.position = CGPoint(x: self.ck3.frame.midX, y: self.ck3.frame.midY)
                        self.k3.name = "k33"
                        self.addChild(self.k3)
                        
                        self.ck4 = SKSpriteNode(imageNamed: "cevapdolukutu.png")
                        self.ck4.position = CGPoint(x: 435, y: self.size.height / 2.2)
                        self.ck4.zPosition = 2
                        self.ck4.setScale(0.24)
                        self.ck4.anchorPoint = CGPoint(x: 0, y: 0)
                        self.ck4.isUserInteractionEnabled = false
                        self.ck4.name = "ck44"
                        self.addChild(self.ck4)
                        
                        self.k4 = SKLabelNode(fontNamed: "Avenir")
                        self.k4.text = randomharf[3]
                        self.k4.fontSize = 65
                        self.k4.zPosition = 3
                        self.k4.fontColor = UIColor.white
                        self.k4.verticalAlignmentMode = .center
                        self.k4.horizontalAlignmentMode = .center
                        self.k4.position = CGPoint(x: self.ck4.frame.midX, y: self.ck4.frame.midY)
                        self.k4.name = "k44"
                        self.addChild(self.k4)
                        
                        self.ck5 = SKSpriteNode(imageNamed: "cevapdolukutu.png")
                        self.ck5.position = CGPoint(x: 555, y: self.size.height / 2.2)
                        self.ck5.zPosition = 2
                        self.ck5.setScale(0.24)
                        self.ck5.anchorPoint = CGPoint(x: 0, y: 0)
                        self.ck5.isUserInteractionEnabled = false
                        self.ck5.name = "ck55"
                        self.addChild(self.ck5)
                        
                        self.k5 = SKLabelNode(fontNamed: "Avenir")
                        self.k5.text = randomharf[4]
                        self.k5.fontSize = 65
                        self.k5.zPosition = 3
                        self.k5.fontColor = UIColor.white
                        self.k5.verticalAlignmentMode = .center
                        self.k5.horizontalAlignmentMode = .center
                        self.k5.position = CGPoint(x: self.ck5.frame.midX, y: self.ck5.frame.midY)
                        self.k5.name = "k55"
                        self.addChild(self.k5)
                        
                        
                        self.bk1 = SKSpriteNode(imageNamed: "cevapboskutu.png")
                        self.bk1.position = CGPoint(x: 75, y: self.size.height / 1.8)
                        self.bk1.zPosition = 1
                        self.bk1.setScale(0.24)
                        self.bk1.anchorPoint = CGPoint(x: 0, y: 0)
                        self.bk1.isUserInteractionEnabled = false
                        self.bk1.name = "bk1"
                        self.addChild(self.bk1)
                        
                        self.bk2 = SKSpriteNode(imageNamed: "cevapboskutu.png")
                        self.bk2.position = CGPoint(x: 195, y: self.size.height / 1.8)
                        self.bk2.zPosition = 1
                        self.bk2.setScale(0.24)
                        self.bk2.anchorPoint = CGPoint(x: 0, y: 0)
                        self.bk2.isUserInteractionEnabled = false
                        self.bk2.name = "bk2"
                        self.addChild(self.bk2)
                        
                        self.bk3 = SKSpriteNode(imageNamed: "cevapboskutu.png")
                        self.bk3.position = CGPoint(x: 315, y: self.size.height / 1.8)
                        self.bk3.zPosition = 1
                        self.bk3.setScale(0.24)
                        self.bk3.anchorPoint = CGPoint(x: 0, y: 0)
                        self.bk3.isUserInteractionEnabled = false
                        self.bk3.name = "bk3"
                        self.addChild(self.bk3)
                        
                        self.bk4 = SKSpriteNode(imageNamed: "cevapboskutu.png")
                        self.bk4.position = CGPoint(x: 435, y: self.size.height / 1.8)
                        self.bk4.zPosition = 1
                        self.bk4.setScale(0.24)
                        self.bk4.anchorPoint = CGPoint(x: 0, y: 0)
                        self.bk4.isUserInteractionEnabled = false
                        self.bk4.name = "bk4"
                        self.addChild(self.bk4)
                        
                        self.bk5 = SKSpriteNode(imageNamed: "cevapboskutu.png")
                        self.bk5.position = CGPoint(x: 555, y: self.size.height / 1.8)
                        self.bk5.zPosition = 1
                        self.bk5.setScale(0.24)
                        self.bk5.anchorPoint = CGPoint(x: 0, y: 0)
                        self.bk5.isUserInteractionEnabled = false
                        self.bk5.name = "bk5"
                        self.addChild(self.bk5)
                        
                        let xPoz = CGFloat(Double("0")!)
                        
                        let soruarkaplan = SKSpriteNode(imageNamed: "soruarkaplan.png")
                        soruarkaplan.position = CGPoint(x: xPoz, y: self.size.height / 1.5)
                        soruarkaplan.zPosition = 1
                        soruarkaplan.setScale(1)
                        soruarkaplan.anchorPoint = CGPoint(x: 0, y: 0)
                        self.addChild(soruarkaplan)
                        
                        
                        self.soru = SKLabelNode(fontNamed: "Avenir")
                        self.soru.text = secilensoru
                        self.soru.zPosition = 2
                        self.soru.lineBreakMode = .byWordWrapping
                        self.soru.numberOfLines = 0
                        self.soru.preferredMaxLayoutWidth = self.frame.maxX
                        self.soru.verticalAlignmentMode = .center
                        self.soru.fontColor = UIColor.white
                        self.soru.position = CGPoint(x: soruarkaplan.frame.midX, y: soruarkaplan.frame.midY)
                        self.addChild(self.soru)
                        
                        
                        self.startTimer()
                        self.zamanlabel()
                    }
                    
                }
            }
        }

        
        // soruislemleri2 SON
    }
 
   
    
    func startTimer()
    {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }
    @objc func updateTimer()
    {
        zaman.text = toplamZaman.description
        if toplamZaman != 0
        {
            toplamZaman -= 1
        }
        else
        {
            timer.invalidate()
    
            finishTimerPanel = SKSpriteNode(imageNamed: "finishTimerPanel.png")
            finishTimerPanel.position = CGPoint(x: self.size.width / 2, y: self.size.height / 2)
            finishTimerPanel.zPosition = 4
            finishTimerPanel.setScale(0.7)
            finishTimerPanel.anchorPoint = CGPoint(x: 0.5, y: 0.5)
            finishTimerPanel.name = "finishTimerPanel"
            self.addChild(finishTimerPanel)
        
            
           
            
            timerWarning = SKLabelNode(fontNamed: "Avenir Light")
            timerWarning.text = "SÜRENİZ BİTTİ!"
            timerWarning.zPosition = 5
            timerWarning.fontColor = UIColor.black
            timerWarning.fontSize = 60
            timerWarning.verticalAlignmentMode = .center
            timerWarning.position = CGPoint(x: finishTimerPanel.frame.midX, y: finishTimerPanel.frame.midY / 0.9)
            timerWarning.name = "timerWarning"
            self.addChild(timerWarning)
            
            otherQuestion = SKSpriteNode(imageNamed: "button.png")
            otherQuestion.position = CGPoint(x: finishTimerPanel.frame.midX, y: finishTimerPanel.frame.midY / 1.2)
            otherQuestion.zPosition = 5
            otherQuestion.setScale(0.5)
            otherQuestion.isUserInteractionEnabled = false
            otherQuestion.name = "otherQuestion"
            self.addChild(otherQuestion)
            
            
            self.otherQuestionWord = SKLabelNode(fontNamed: "Avenir Light")
            self.otherQuestionWord.text = "DİĞER SORU"
            self.otherQuestionWord.zPosition = 6
            self.otherQuestionWord.fontColor = UIColor.black
            self.otherQuestionWord.fontSize = 40
            self.otherQuestionWord.verticalAlignmentMode = .center
            self.otherQuestionWord.position = CGPoint(x: finishTimerPanel.frame.midX, y: otherQuestion.frame.midY)
            self.otherQuestionWord.isUserInteractionEnabled = false
            self.otherQuestionWord.name = "otherQuestion"
            self.addChild(self.otherQuestionWord)
         
        }
    }
    
  
 
    func zamanlabel()
    {
        zaman = SKLabelNode(fontNamed: "Avenir Bold")
        zaman.zPosition = 2
        zaman.fontSize = 100
        zaman.verticalAlignmentMode = .center
        zaman.fontColor = UIColor.init(displayP3Red: 255, green: 0, blue: 0, alpha: 1)
        zaman.position = CGPoint(x: self.size.width / 2, y: self.size.height / 2.5)
        self.addChild(zaman)
        
      
    } // zamanlabel() SON
    
   
}
