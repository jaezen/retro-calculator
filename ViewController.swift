//
//  ViewController.swift
//  retro-calculator
//
//  Created by Jaezen Lim on 16/06/2016.
//  Copyright © 2016 jaezenlim. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    enum Operation: String {
        case Divide = "/"
        case Multiply = "x"
        case Subtract = "-"
        case Add = "+"
        case Empty = "Empty"
    }
    
    
    
    @IBOutlet weak var outputLbl: UILabel!

    var btnSound: AVAudioPlayer!
    
    var runningNumber = ""
    var leftValStr = ""
    var rightValStr = ""
    var currentOperation: Operation = Operation.Empty
    var result = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let path =
        NSBundle.mainBundle().pathForResource("btn", ofType: "wav")
        let soundUrl = NSURL(fileURLWithPath: path!)
    
        
        do {
            try  btnSound = AVAudioPlayer(contentsOfURL: soundUrl)
            btnSound.prepareToPlay()
        } catch let err as NSError {
            print(err.debugDescription)
        }

       
        
    
    }
    

    @IBAction func numberPressed(btn: UIButton) {
        playSound()
        
        
        runningNumber += "\(btn.tag)"
        outputLbl.text = runningNumber
        
        }
    
    @IBAction func onDividePressed(sender: AnyObject) {
        processOperation(Operation.Divide)
    }
    
    @IBAction func onMultiplyPressed(sender: AnyObject) {
        processOperation(Operation.Multiply)
    }
    
    @IBAction func onSubtractPressed(sender: AnyObject) {
        processOperation(Operation.Subtract)
    }
    
    @IBAction func onAddPressed(sender: AnyObject) {
        processOperation(Operation.Add)
    }
    
    @IBAction func onEqualsPressed(sender: AnyObject) {
        processOperation(currentOperation)
    }
    
    //it just clears out all the data fields so you can start again
    @IBAction func onClearPressed(sender: AnyObject) {
        processOperation(currentOperation)
        currentOperation = Operation.Empty
        leftValStr = ""
        rightValStr = ""
        result = ""
        outputLbl.text = ("0")
    }
    
    
    
    func processOperation(op: Operation) {
        playSound()
        
        if currentOperation != Operation.Empty {
            //Run some math
            
            
            //A user selected an operator, but then selected another operator without first entering a number 
            if runningNumber != "" {
                rightValStr = runningNumber
                runningNumber = ""
                
                if currentOperation == Operation.Multiply {
                    result = "\(Double(leftValStr)! * Double(rightValStr)!)"
                } else if currentOperation == Operation.Divide {
                    result = "\(Double(leftValStr)! / Double(rightValStr)!)"
                } else if currentOperation == Operation.Subtract {
                    result = "\(Double(leftValStr)! - Double(rightValStr)!)"
                } else if currentOperation == Operation.Add {
                    result = "\(Double(leftValStr)! + Double(rightValStr)!)"
                }
                
                
                leftValStr = result
                outputLbl.text = result
            }
            
            
            currentOperation = op
            
            
            
        } else {
            //This is the first time an operator has been pressed
            leftValStr = runningNumber
            runningNumber = ""
            currentOperation = op
        }
        
    
        
    }
    
    
    func playSound() {
        if btnSound.playing {
            btnSound.stop()
        }
        
        btnSound.play()
    }
    
    
    }




