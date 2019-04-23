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
            if name == "otherQuestion"
            {
                self.otherQuestionWord.text = "TIKLANDI!"
                return self.soruislemleri()
            }
        
        }
        
        
        
        
    }
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for touch in touches
        {
            let konum = touch.location(in: self)
        
                cevapdolukutu.position.x = konum.x
                cevapdolukutu.position.y = konum.y
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
      
        for n in 1...6 // VERİ TABANINDAKİ CEVAP VEYA SORU SAYISI İLE DEĞİŞTİRİLECEL... (ÖNEMLİ)
            {
                // Veri tabanındaki bütün soru ve cevaplar cevapArray ve soruArray dizilerine atandı.
                let art = String(n)
                ref.child("Sorular").child("4harf").child(art).observeSingleEvent(of: .value) { (snapshot) in
                    let value = snapshot.value as? NSDictionary
                    let cevaplarArray = [value?["cevap"] as? String ?? ""]
                     self.cevapArray += cevaplarArray
                    let sorularArray = [value?["soru"] as? String ?? ""]
                    self.soruArray += sorularArray
                    
                    if n == 6 // VERİ TABANINDAKİ CEVAP VEYA SORU SAYISI İLE DEĞİŞTİRİLECEK... (ÖNEMLİ)
                    {
                        // cevapArray dizisinin eleman sayısı sabite atandı.
                        let cevapArrayLength = self.cevapArray.count
                        
                        var cevapletter = [String]()
                        var soruletter = [String]()
                        
                        for i in 0..<cevapArrayLength
                        {
                            // cevapArray dizisindeki bütün elemanların ilk harfleri sabite atandı.
                            let firstletter = self.cevapArray[i].prefix(1)
                            
                            
                            // kelimeArray dizisinin ilk elamanı (Dizi İçinde Harfler Var) cevapArrayin ilk harfi ile eşit mi kontrol edildi.
                            if firstletter == self.kelimeArray[0]
                            {
                                // Belirli bir harf ile başlayan soru ve cevap dizilere atandı.
                                cevapletter += [self.cevapArray[i]]
                                soruletter += [self.soruArray[i]]
                               
                            }
                           
                           
                        }
                        // Belirli bir harf ile başlayan cevaplar arasından rasgele bir cevap ve sorusu seçildi.
                        if cevapletter.isEmpty == false
                        {
                        let randomsayi = Int.random(in: 0..<cevapletter.count)
                        let secilencevap = cevapletter[randomsayi]
                        let secilensoru = soruletter[randomsayi]
                         print(secilencevap)
                         print(secilensoru)
                            
                            
                            // Dizi içerisindeki eleman harflerine ayrıldı.
                            let atama = secilencevap
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
                                if randomstring == secilencevap
                                {
                                    print("HARF DÜZENİ AYNI")
                                    return self.soruislemleri()
                                }
                              
                              
                            }
    
                                var xPos = CGFloat(Double("115")!)
                            
                                for i in 0..<randomharf.count {
                                    
                                    let cevapdizi = randomharf[i]
                                    
                                    self.cevapdolukutu = SKSpriteNode(imageNamed: "cevapdolukutu.png")
                                    self.cevapdolukutu.position = CGPoint(x: xPos, y: self.size.height / 2.2)
                                    self.cevapdolukutu.zPosition = 1
                                    self.cevapdolukutu.setScale(0.25)
                                    self.cevapdolukutu.anchorPoint = CGPoint(x: 0, y: 0)
                                    xPos += 130
                                    self.addChild(self.cevapdolukutu)
                                    
                                    self.cevapharf = SKLabelNode(fontNamed: "Avenir")
                                    self.cevapharf.text = cevapdizi
                                    self.cevapharf.fontSize = 70
                                    self.cevapharf.zPosition = 2
                                    self.cevapharf.fontColor = UIColor.white
                                    self.cevapharf.verticalAlignmentMode = .center
                                    self.cevapharf.horizontalAlignmentMode = .center
                                    self.cevapharf.position = CGPoint(x: self.cevapdolukutu.frame.midX, y: self.cevapdolukutu.frame.midY)
                                    self.addChild(self.cevapharf)
                                }
                            
                                
                                var xPosition = CGFloat(Double("115")!)
                                
                                for _ in 0..<randomharf.count
                                {
                                    let cevapboskutu = SKSpriteNode(imageNamed: "cevapboskutu.png")
                                    cevapboskutu.position = CGPoint(x: xPosition, y: self.size.height / 1.8)
                                    cevapboskutu.zPosition = 1
                                    cevapboskutu.setScale(0.25)
                                    cevapboskutu.anchorPoint = CGPoint(x: 0, y: 0)
                                    xPosition += 130
                                    self.addChild(cevapboskutu)
                                    
                                }
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
        
    } // soruislemleri() SON
 
   
    
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
    
            let finishTimerPanel = SKSpriteNode(imageNamed: "finishTimerPanel.png")
            finishTimerPanel.position = CGPoint(x: self.size.width / 2, y: self.size.height / 2)
            finishTimerPanel.zPosition = 4
            finishTimerPanel.setScale(0.7)
            finishTimerPanel.anchorPoint = CGPoint(x: 0.5, y: 0.5)
            finishTimerPanel.name = "finishTimerPanel"
            self.addChild(finishTimerPanel)
            
           /*
                 let blurEffect = UIBlurEffect(style: .regular)
                 let blurEffectView = UIVisualEffectView(effect: blurEffect)
                 blurEffectView.frame = view!.bounds
                 view!.addSubview(blurEffectView)
            
            */
         
            
            var timerWarning: SKLabelNode!
            
            timerWarning = SKLabelNode(fontNamed: "Avenir Light")
            timerWarning.text = "SÜRENİZ BİTTİ!"
            timerWarning.zPosition = 5
            timerWarning.fontColor = UIColor.black
            timerWarning.fontSize = 60
            timerWarning.verticalAlignmentMode = .center
            timerWarning.position = CGPoint(x: finishTimerPanel.frame.midX, y: finishTimerPanel.frame.midY / 0.9)
            self.addChild(timerWarning)
            
            let otherQuestion = SKSpriteNode(imageNamed: "button.png")
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
