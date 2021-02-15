//
//  ViewController.swift
//  Slot Machine
//
//  Created by Juliana de Carvalho on 2021-01-30.
//  Copyright © 2021 Juliana de Carvalho. All rights reserved.
//  Student 1: Abdeali Mody - Student Id: 301085484
//  Student 2: Juliana de Carvalho - Student Id: 301137060

import UIKit

class ViewController: UIViewController, UIApplicationDelegate{

 
    @IBOutlet var currentJackpotLabel: UILabel!
    @IBOutlet var currentBetLabel: UILabel!
    @IBOutlet var currentCreditLabel: UILabel!
    @IBOutlet var spinBtnLabel: UILabel!
    @IBOutlet var messageLabel: UILabel!
    
    @IBOutlet var image1: UIImageView!
    @IBOutlet var image2: UIImageView!
    @IBOutlet var image3: UIImageView!
    @IBOutlet var image4: UIImageView!
    @IBOutlet var image5: UIImageView!
    @IBOutlet var image6: UIImageView!
    @IBOutlet var image7: UIImageView!
    @IBOutlet var image8: UIImageView!
    @IBOutlet var image9: UIImageView!
   
    @IBOutlet var spinBtn: UIImageView!
    @IBOutlet var minusFive: UIImageView!
    @IBOutlet var plusFive: UIImageView!
    @IBOutlet var minusTwentyFive: UIImageView!
    @IBOutlet var plusTwentyFive: UIImageView!
    @IBOutlet var minusFifty: UIImageView!
    @IBOutlet var plusFifty: UIImageView!
    
    var strawberrys = 0
    var bananas = 0
    var oranges = 0
    var kiwis = 0
    var coconuts = 0
    var peaches = 0
    var bells = 0
    var winningAmount = 0
    
    var currentBet = 0 {
        didSet {
            currentBetLabel.text = "$\(currentBet)"
        }
    }
    var currentCredit = 500 {
        didSet {
            currentCreditLabel.text = "$\(currentCredit)"
        }
    }
    var currentJackpot = 100000 {
        didSet {
            currentJackpotLabel.text = "$\(currentJackpot)"
        }
    }
    var message = "" {
        didSet {
            messageLabel.text = message
        }
    }
    
    let arrayFruits = ["bell","strawberry", "peach", "kiwi", "orange", "coconut", "banana"]
   

    @IBAction func btnReset(_ sender: UIButton) {
         currentCredit = 500
         currentJackpot = 100000
         message = "Play Now!!!"
         changeImages(changeAll: true)
         resetBet()
         disableSpinBtn()
    }
    
    
    @IBAction func btnExit(_ sender: UIButton) {
        UIControl().sendAction(#selector(NSXPCConnection.suspend), to: UIApplication.shared, for: nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        disableSpinBtn()

        let tapSpin = UITapGestureRecognizer(target: self, action: #selector(self.spinBtn(_:)))
        spinBtn.addGestureRecognizer(tapSpin)
        
        let tapMinusFive = UITapGestureRecognizer(target: self, action: #selector(self.minusFiveBtn(_:)))
        minusFive.addGestureRecognizer(tapMinusFive)
        
        let tapPlusFive = UITapGestureRecognizer(target: self, action: #selector(self.plusFiveBtn(_:)))
        plusFive.addGestureRecognizer(tapPlusFive)
        
        let tapMinusTwentyFive = UITapGestureRecognizer(target: self, action: #selector(self.minusTwentyFiveBtn(_:)))
        minusTwentyFive.addGestureRecognizer(tapMinusTwentyFive)
        
        let tapPlusTwentyFive = UITapGestureRecognizer(target: self, action: #selector(self.plusTwentyFiveBtn(_:)))
        plusTwentyFive.addGestureRecognizer(tapPlusTwentyFive)
        
        let tapMinusFifty = UITapGestureRecognizer(target: self, action: #selector(self.minusFiftyBtn(_:)))
        minusFifty.addGestureRecognizer(tapMinusFifty)
        
        let tapPlusFifty = UITapGestureRecognizer(target: self, action: #selector(self.plusFiftyBtn(_:)))
        plusFifty.addGestureRecognizer(tapPlusFifty)
    }
    
    @objc func spinBtn(_ sender: UITapGestureRecognizer? = nil){
        
        if (currentBet == 0)
        {
           disableSpinBtn()
        }
        else if (currentCredit < currentBet)
        {
          disableSpinBtn()
        }
        else
        {
          spinReels()
          determineWinnings()
          resetCounts()
          resetBet()
          disableSpinBtn()
        }
    }
    
        
    func spinReels()
    {

        var betLine = [" ", " ", " "]
        var outCome = [0, 0, 0]

        for spin in 0...2
        {
            outCome[spin] = Int(floor((Double.random(in: 0...1) * 63) + 1))
            switch (outCome[spin])
            {
            case  _checkRange(value: outCome[spin], lowerBounds: 1, upperBounds: 27):
                    betLine[spin] = "banana"
                     bananas += 1
                    break
            case  _checkRange(value: outCome[spin], lowerBounds: 28, upperBounds: 37):
                    betLine[spin] = "coconut"
                     coconuts += 1
                    break
            case  _checkRange(value: outCome[spin], lowerBounds: 38, upperBounds: 46):
                    betLine[spin] = "orange"
                     oranges += 1
                    break
            case  _checkRange(value: outCome[spin], lowerBounds: 47, upperBounds: 54):
                    betLine[spin] = "kiwi"
                     kiwis += 1
                    break
            case  _checkRange(value: outCome[spin], lowerBounds: 55, upperBounds: 59):
                    betLine[spin] = "peach"
                     peaches += 1
                    break
            case  _checkRange(value: outCome[spin], lowerBounds: 60, upperBounds: 62):
                    betLine[spin] = "strawberry"
                     strawberrys += 1
                    break
            case  _checkRange(value: outCome[spin], lowerBounds: 63, upperBounds: 63):
                    betLine[spin] = "bell"
                    bells += 1
            break
            default:
                print ("Default")
            }
        }
        print(betLine)
        
        changeImages(changeAll: false)
        
        //BET LINE
        image4.image = UIImage(named: betLine[0])
        image5.image = UIImage(named: betLine[1])
        image6.image = UIImage(named: betLine[2])

    }

    //This function calculates the player's winnings.
    func determineWinnings()
    {
        message = "YOU WIN!!!"
        
        if (bells == 3){
           winningAmount = currentJackpot
            message = "JACKPOT WINNER!!!!!!!"
        }
        else if ( strawberrys == 3)
        {
            switch currentBet {
            case 5:  winningAmount = 1000
            case 25: winningAmount = 5000
            case 50: winningAmount = 25000
            default: winningAmount = 0}
        }
        else if (peaches == 3)
        {
            switch currentBet {
            case 5:  winningAmount = 750
            case 25: winningAmount = 3750
            case 50: winningAmount = 18750
            default: winningAmount = 0}
        }
        else if (kiwis == 3)
        {
            switch currentBet {
            case 5:  winningAmount = 500
            case 25: winningAmount = 2500
            case 50: winningAmount = 12500
            default: winningAmount = 0}
        }
        else if (oranges == 3)
        {
            switch currentBet {
            case 5:  winningAmount = 250
            case 25: winningAmount = 1250
            case 50: winningAmount = 6250
            default: winningAmount = 0}
        }
        else if (coconuts == 3)
        {
            switch currentBet {
            case 5:  winningAmount = 150
            case 25: winningAmount = 750
            case 50: winningAmount = 3750
            default: winningAmount = 0}
        }
        else if (bananas == 3)
        {
            switch currentBet {
            case 5:  winningAmount = 100
            case 25: winningAmount = 500
            case 50: winningAmount = 2500
            default: winningAmount = 0}
        }
        else
        {
            message = "Sorry, try again!!!"
            
            currentJackpot = currentJackpot + currentBet
            currentCredit = currentCredit - currentBet

            print("LOSS! :( ")
            return
        }
              
        print("WIN! :) ")
        print("Bet Amount: " + String(currentBet))
        print("Winning Amount: " + String(winningAmount))
             
        currentCredit = currentCredit + winningAmount
        currentJackpot = currentJackpot - winningAmount
    }
    
    func disableSpinBtn(){
        spinBtn.isUserInteractionEnabled = false
        spinBtn.alpha = 0.5
        spinBtnLabel.alpha = 0.5
    }
    
    func enableSpinBtn(){
        spinBtn.isUserInteractionEnabled = true
        spinBtn.alpha = 1
        spinBtnLabel.alpha = 1
    }
    
    @objc func minusFiveBtn(_ sender: UITapGestureRecognizer? = nil){
        resetBet()
        disableSpinBtn()
    }
    
    @objc func plusFiveBtn(_ sender: UITapGestureRecognizer? = nil){
        currentBet = 5
        enableBetButtons(enableBetFive: true, enableBetTwentyFive: false, enableBetFifty: false)
        enableSpinBtn()
    }
    
    @objc func minusTwentyFiveBtn(_ sender: UITapGestureRecognizer? = nil){
        resetBet()
        disableSpinBtn()
     }
     
    @objc func plusTwentyFiveBtn(_ sender: UITapGestureRecognizer? = nil){
        currentBet = 25
        enableBetButtons(enableBetFive: false, enableBetTwentyFive: true, enableBetFifty: false)
        enableSpinBtn()
     }
  
    @objc func minusFiftyBtn(_ sender: UITapGestureRecognizer? = nil){
        resetBet()
        disableSpinBtn()
    }
       
    @objc func plusFiftyBtn(_ sender: UITapGestureRecognizer? = nil){
        currentBet = 50
        enableBetButtons(enableBetFive: false, enableBetTwentyFive: false, enableBetFifty: true)
        enableSpinBtn()
        
       }
    
    
    //Utility function to check if a value falls within a range of bounds
    func _checkRange(value: Int, lowerBounds: Int, upperBounds: Int)-> Int
    {
        return (value >= lowerBounds && value <= upperBounds) ? value : -1
    }
    
    func enableBetButtons(enableBetFive: Bool, enableBetTwentyFive: Bool, enableBetFifty: Bool)
    {
       minusFive.isUserInteractionEnabled = enableBetFive
       minusTwentyFive.isUserInteractionEnabled = enableBetTwentyFive
       minusFifty.isUserInteractionEnabled = enableBetFifty
        
    }
    
    func resetBet(){
        currentBet = 0
    }
    
    func changeImages(changeAll: Bool){
       //first line of images
        image1.image = UIImage(named: arrayFruits[Int.random(in: 1...5)])
       image2.image = UIImage(named: arrayFruits[Int.random(in: 1...5)])
       image3.image = UIImage(named: arrayFruits[Int.random(in: 1...5)])
       
        if (changeAll){
            //changing images from bet line when reseting
            image4.image = UIImage(named: arrayFruits[Int.random(in: 1...5)])
            image5.image = UIImage(named: arrayFruits[Int.random(in: 1...5)])
            image6.image = UIImage(named: arrayFruits[Int.random(in: 1...5)])
        }

       //third line of images
       image7.image = UIImage(named: arrayFruits[Int.random(in: 1...5)])
       image8.image = UIImage(named: arrayFruits[Int.random(in: 1...5)])
       image9.image = UIImage(named: arrayFruits[Int.random(in: 1...5)])
    }
    
    func resetCounts()
    {
         bells = 0
         strawberrys = 0
         bananas = 0
         oranges = 0
         kiwis = 0
         coconuts = 0
         peaches = 0
    }

}

