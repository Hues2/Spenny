//
//  Double.swift
//  Spenny
//
//  Created by Greg Ross on 14/09/2022.
//

import Foundation


extension Double{
    func toFormattedString(format: String) -> String{
        let formatter = NumberFormatter()
        formatter.locale = Locale.current
        formatter.numberStyle = .currency
        if let formattedNumber = formatter.string(from: self as NSNumber){
            return formattedNumber
        } else {
            return String(format: format, self)
        }
        
    }
    
    func withPoundSign(format: String) -> String{
        let formatter = NumberFormatter()
        formatter.locale = Locale.current
        formatter.numberStyle = .currency
        if let formattedNumber = formatter.string(from: self as NSNumber){
            return formattedNumber
        } else {
            return String(format: format, self)
        }
    }
    
    func withPercentage(format: String) -> String{
        let formatter = NumberFormatter()
        formatter.locale = Locale.current
        formatter.numberStyle = .percent
        if let formattedNumber = formatter.string(from: self as NSNumber){
            return formattedNumber
        } else {
            return String(format: format, self) + "%"
        }
    }
}
