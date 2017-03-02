//
//  CustomSlider.swift
//  TipCalculator
//
//  Created by Kaushik Thekkekere 

import Foundation
import UIKit

class CustomSlide: UISlider {
    
    @IBInspectable var trackHeight: CGFloat = 10
    
    override func trackRect(forBounds bounds: CGRect) -> CGRect {
        return CGRect(origin: bounds.origin, size: CGSize(width:bounds.width, height:trackHeight))
        
        
    }
}
