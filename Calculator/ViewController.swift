//
//  ViewController.swift
//  Calculator
//
//  Created by Rutvij Dhotey on 8/28/16.
//  Copyright © 2016 Rutvij Dhotey. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

   
    private var brain = CalculatorBrain()
    
    @IBAction private func performOperation(sender: UIButton) {
        if userIsInTheMiddleofTying {
            brain.setOperand(displayValue)
            userIsInTheMiddleofTying = false
        }
        if let mathematicalSymbol = sender.currentTitle{
            brain.performOperation(mathematicalSymbol)
        }
        displayValue = brain.result
    }
    
    private var displayValue: Double{
        get{
            return Double(display.text!)!
        }
        set{
            display.text = String(newValue)
        }
        
    }
    @IBAction private func touchDigit(sender: UIButton) {
        let touchedDigit =  sender.currentTitle!
        if userIsInTheMiddleofTying {
        let textCurrentlyindisplay = display
            .text!
        display.text = textCurrentlyindisplay + touchedDigit
        } else {
            display.text = touchedDigit
        }
        userIsInTheMiddleofTying = true
    
    }
    private var userIsInTheMiddleofTying = false
    
    @IBOutlet private weak var display: UILabel!
}

