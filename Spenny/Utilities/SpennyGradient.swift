//
//  SpennyGradient.swift
//  Spenny
//
//  Created by Greg Ross on 23/12/2022.
//

import Foundation
import SwiftUI

class SpennyGradient{
    
    static let shared = SpennyGradient()
    
    private init(){}
    
    let gradient = Gradient(colors: [.mint, .teal, .cyan, .blue])
}
