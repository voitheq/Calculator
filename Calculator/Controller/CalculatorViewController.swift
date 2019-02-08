//
//  ViewController.swift
//  Calculator
//
//  Created by Wojciech Karaś on 04/01/2019.
//  Copyright © 2019 Wojciech Karaś. All rights reserved.
//

import UIKit

class CalculatorViewController: UIViewController {

    @IBOutlet weak var displayLabel: UILabel!
    
    var activeCalcButton: UIButton?
    var calcButtonTapped = true
    
    let calculator = Calculator()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func clearAll(_ sender: UIButton) {
        displayLabel.text = calculator.clearAll()
        setActiveCalcButton(button: nil)
        calcButtonTapped = true
    }
    
    @IBAction func numButtonTapped(_ sender: UIButton) {
        
        setActiveCalcButton(button: nil)
        
        if let value = sender.currentTitle{
            if calcButtonTapped {
                calcButtonTapped = false
                if value == "." {
                    displayLabel.text = "0" + value
                }else if value == "0" {
                    displayLabel.text = value + "."
                }else{
                    displayLabel.text = value
                }
            }else{
                guard let text = displayLabel.text else {
                    return
                }
                guard !(value == "." && text.contains(".")) else {
                    return
                }
                if text.count > 0 && text.first == "0" && !text.contains(".") && value != "." {
                    displayLabel.text = "0." + value
                    
                }else if text.count > 1 && text.hasPrefix("-0") && !text.contains(".") && value != "." {
                    displayLabel.text = "-0." + value
                    
                }else{
                    displayLabel.text = text + value
                    
                }
            }
        }
    }
    
    @IBAction func oneNumCalcButtonTapped(_ sender: UIButton) {
        if let calculatorMethod = sender.currentTitle, let text = displayLabel.text {
            switch calculatorMethod{
            case "+/-":
                if text.count > 0 {
                    if text.first != "-" {
                        if text != "0" {
                            displayLabel.text = "-" + text
                        }
                    }else{
                        displayLabel.text = String(text.dropFirst())
                    }
                }
            case "%":
                if let text = displayLabel.text, let value = Double(text) {
                    displayLabel.text = String(calculator.calculatePercent(value: value))
                }
            default:
                break
            }
        }
    }
    
    @IBAction func twoNumCalcButtonTapped(_ sender: UIButton) {
        setActiveCalcButton(button: sender)
        calcButtonTapped = true
        if let calculatorMethod = sender.currentTitle, let text = displayLabel.text, let value = Double(text) {
            if let value = calculator.calculate(value: value, calculatorMethod: calculatorMethod) {
                displayLabel.text = String(value)
                if calculatorMethod == "="{
                    let _ = calculator.clearAll()
                }
            }
        }
    }
    
    func setActiveCalcButton(button: UIButton?) {
        if let activeCalcButton = activeCalcButton {
            activeCalcButton.alpha = 1.0
        }
        if let button = button{
            if button.currentTitle != "=" {
                button.alpha = 0.8
                activeCalcButton = button
            }
        }
    }
    
}
