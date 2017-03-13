//
//  Calculator.swift
//  TipCalculator
//
//  Created by Kaushik Thekkekere 

import Foundation

class Calculator: NSObject {
    
    func calculateTipAmount(billAmount:NSNumber,tipPercentage:NSNumber) -> NSNumber {
        let percentageTipAmount:NSNumber = NSNumber(value:(billAmount.floatValue * tipPercentage.floatValue)/100)

        return percentageTipAmount;
    }
    
    func totalAmount(billAmount:NSNumber,tipAmount:NSNumber) -> NSNumber {
        return NSNumber(value:billAmount.floatValue+tipAmount.floatValue);
    }
    
    func splitAmount(totalAmount:NSNumber,splitBy:NSNumber) -> NSNumber {
        return NSNumber(value:totalAmount.floatValue/splitBy.floatValue);
    }
    
}
