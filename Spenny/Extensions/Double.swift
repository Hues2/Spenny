//
//  Double.swift
//  Spenny
//
//  Created by Greg Ross on 14/09/2022.
//

import Foundation


extension Double{
    func toFormattedString(format: String) -> String{
        return "£" + String(format: format, self).replacingOccurrences(of: "-", with: "")
    }
    
    func withPoundSign(format: String) -> String{
        return "£" + String(format: format, self)
    }
}
