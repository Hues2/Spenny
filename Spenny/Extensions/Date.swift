//
//  Date.swift
//  Spenny
//
//  Created by Greg Ross on 20/09/2022.
//

import Foundation


extension Date{
    //MARK: - Date To String
    func toString() -> String{
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.dateFormat = "dd/MM/yy"
        return formatter.string(from: self)
    }
}
