//
//  HapticFeedbackGenerator.swift
//  Spenny
//
//  Created by Greg Ross on 21/09/2022.
//

import Foundation
import SwiftUI

class HapticFeedbackGenerator{
    static let shared = HapticFeedbackGenerator()
    
    private init(){}
    
    func notification(type: UINotificationFeedbackGenerator.FeedbackType){
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(type)
    }
    
    func impact(style: UIImpactFeedbackGenerator.FeedbackStyle){
        let generator = UIImpactFeedbackGenerator(style: style)
        generator.impactOccurred()
    }
}
