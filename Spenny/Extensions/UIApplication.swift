//
//  UIApplication.swift
//  Spenny
//
//  Created by Greg Ross on 12/09/2022.
//

import Foundation
import UIKit


extension UIApplication{
    func dismissKeyboard(){
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
