//
//  SpennyButtonStyle.swift
//  Spenny
//
//  Created by Greg Ross on 12/09/2022.
//

import SwiftUI

struct SpennyButtonStyle: ButtonStyle{
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.85 : 1)
            .opacity(configuration.isPressed ? 0.85 : 1)
    }
}
