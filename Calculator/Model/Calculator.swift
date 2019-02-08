//
//  Calculator.swift
//  Calculator
//
//  Created by Wojciech Karaś on 04/01/2019.
//  Copyright © 2019 Wojciech Karaś. All rights reserved.
//

import Foundation

class Calculator {
    
    private var currentValue: Double?
    private var currentCalculatorMethod: String?
    
    func clearAll() -> String{
        currentValue = nil
        currentCalculatorMethod = nil
        return "0"
    }
    
    func calculate(value: Double, calculatorMethod: String) -> Double? {
        
        if let currentValue = currentValue, let currentCalculatorMethod = currentCalculatorMethod{
            switch currentCalculatorMethod{
            case "÷":
                self.currentValue = value != 0 ? currentValue / value : 0
            case "×":
                self.currentValue = currentValue * value
            case "-":
                self.currentValue = currentValue - value
            case "+":
                self.currentValue = currentValue + value
            default:
                break
            }
            self.currentCalculatorMethod = calculatorMethod
            return self.currentValue
            
        }else{
            self.currentValue = Double(value)
            self.currentCalculatorMethod = calculatorMethod
        }
        
        return nil
    }
    
    func calculatePercent(value: Double) -> Double{
        if let currentValue = currentValue{
            return currentValue * (value / 100)
        }else{
            return value / 100
        }
    }
    
}
