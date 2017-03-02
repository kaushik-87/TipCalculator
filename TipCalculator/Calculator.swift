//
//  Calculator.swift
//  TipCalculator
//
//  Created by Kaushik Thekkekere 

import Foundation

class Calculator: NSObject {
    
    func calculateTipAmount(billAmount:NSNumber,tipPercentage:NSNumber) -> NSNumber {
        let percentageTipAmount:NSNumber = NSNumber(value:(billAmount.floatValue * tipPercentage.floatValue)/100)
//        let tipAmount = billAmount+percentageAmount;
//        NSLog("Bill = %.2f tip =%.2f and Total Value %.2f",billAmount,tipPercentage, tipAmount);
        return percentageTipAmount;
    }
    
    func totalAmount(billAmount:NSNumber,tipAmount:NSNumber) -> NSNumber {
        return NSNumber(value:billAmount.floatValue+tipAmount.floatValue);
    }
    
    
}
