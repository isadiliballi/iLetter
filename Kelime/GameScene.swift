//
//  GameScene.swift
//  Kelime
//
//  Created by İsa Diliballı on 7.04.2019.
//  Copyright © 2019 İsa Diliballı. All rights reserved.
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
    var cevapidArray : [Int32] = []
    var soruArray : [String] = []  // kullanılıyor
    
    var kelimeidArray : [Int32] = []
    var kelimeArray : [String] = [] // kullanılıyor
    var kelimeharfArray : [Int32] = []
    
    var ref : DatabaseReference!
   
    
    
    
    override func didMove(to view: SKView) {
        
     
        background()  // A1
        kelimeislemleri()
  
      
        
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
        let randomsayi = Int.random(in: 1..<5)
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
       //     let kelimeharfsayisi = harfArray.count
            // XX SON
            
            
            
            var xPos = CGFloat(Double("37.5")!)
            
            // --------------------------------------------------------------------
            var label: SKLabelNode!
            
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
                
                label = SKLabelNode(fontNamed: "Avenir")
                label.text = kelimeler
                label.fontSize = 80
                label.zPosition = 2
                label.fontColor = UIColor.black
                label.verticalAlignmentMode = .center
                label.horizontalAlignmentMode = .center
                label.position = CGPoint(x: kelimekutusu.frame.midX, y: kelimekutusu.frame.midY)
                self.addChild(label)
            }
            // --------------------------------------------------------------------
            
  
            
            self.soruislemleri()
            
        }) { (error) in
            print(error.localizedDescription)
        }
    }  // kelimeislemleri() SON
    
    
    func soruislemleri()
    {
           ref = Database.database().reference()
       
            for n in 1...4 // VERİ TABANINDAKİ CEVAP VEYA SORU SAYISI İLE DEĞİŞTİRİLECEL... (ÖNEMLİ)
            {
                // Veri tabanındaki bütün soru ve cevaplar cevapArray ve soruArray dizilerine atandı.
                let art = String(n)
                ref.child("Sorular").child("4harf").child(art).observeSingleEvent(of: .value) { (snapshot) in
                    let value = snapshot.value as? NSDictionary
                    let cevaplarArray = [value?["cevap"] as? String ?? ""]
                     self.cevapArray += cevaplarArray
                    let sorularArray = [value?["soru"] as? String ?? ""]
                    self.soruArray += sorularArray
                    
                    if n == 4 // VERİ TABANINDAKİ CEVAP VEYA SORU SAYISI İLE DEĞİŞTİRİLECEL... (ÖNEMLİ)
                    {
                        // cevapArray dizisinin eleman sayısı sabite atandı.
                        let cevapArrayLength = self.cevapArray.count
                        
                        var cevapletter = [String]()
                        var soruletter = [String]()
                        
                        for i in 0...cevapArrayLength - 1
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
                        let randomsayi = Int.random(in: 0...cevapletter.count - 1)
                        let secilencevap = cevapletter[randomsayi]
                        let secilensoru = soruletter[randomsayi]
                         print(secilencevap)
                         print(secilensoru)
                            
                            
                            
                            // Dizi içerisindeki eleman harflerine ayrıldı.
                            let atama = secilencevap
                            var harfArray = atama.map {String($0)}
                            self.cevapharfArray = harfArray
                            print(self.cevapharfArray)
                            
                        //    var xPos = 72
                            
                           // Cevabın harfleri kutular içine random şekilde atandı.
                            var randomharf = [String]();
                            for _ in 0..<harfArray.count
                            {
                                let rand = Int(arc4random_uniform(UInt32(harfArray.count)))
                                randomharf.append(harfArray[rand])
                                harfArray.remove(at: rand)
                            }
                            
                            print(randomharf)
                            
      // ------------------------------------------------------------------------------------------------------------
                            
                            var xPos = CGFloat(Double("115")!)
                            
                            var cevapharf: SKLabelNode!
                            
                            for i in 0..<randomharf.count {
                                let cevapdizi = randomharf[i]
                                
                                let cevapdolukutu = SKSpriteNode(imageNamed: "cevapdolukutu.png")
                                cevapdolukutu.position = CGPoint(x: xPos, y: self.size.height / 2.2)
                                cevapdolukutu.zPosition = 1
                                cevapdolukutu.setScale(0.25)
                                cevapdolukutu.anchorPoint = CGPoint(x: 0, y: 0)
                                xPos += 130
                                self.addChild(cevapdolukutu)
                                
                                cevapharf = SKLabelNode(fontNamed: "Avenir")
                                cevapharf.text = cevapdizi
                                cevapharf.fontSize = 70
                                cevapharf.zPosition = 2
                                cevapharf.fontColor = UIColor.white
                                cevapharf.verticalAlignmentMode = .center
                                cevapharf.horizontalAlignmentMode = .center
                                cevapharf.position = CGPoint(x: cevapdolukutu.frame.midX, y: cevapdolukutu.frame.midY)
                                self.addChild(cevapharf)
                            }
      // ------------------------------------------------------------------------------------------------------------
      
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
                            
                        /*    var soru: SKLabelNode!

                            soru = SKLabelNode(fontNamed: "Avenir")
                            soru.text = secilensoru
                            soru.zPosition = 2
                            soru.fontColor = UIColor.white
                            soru.verticalAlignmentMode = .center
                            soru.horizontalAlignmentMode = .center
                            soru.position = CGPoint(x: self.frame.midX, y: soruarkaplan.frame.midY)
                            self.addChild(soru)
 */
 
                            let soru = UILabel()
                             soru.text = secilensoru
                             soru.textAlignment = .center
                             soru.frame = CGRect( x: 0, y:self.size.height / 1.5, width: 750 , height: 130)
                             soru.layer.zPosition = 3
                             soru.font = UIFont(name: "Avenir Light", size: 10)
                             self.view!.addSubview(soru)
                            print(soru.text!)
                            
                            
                            
                        }
                        
                    }
                }
        }
        
    } // soruislemleri() SON
    

  
 
}
