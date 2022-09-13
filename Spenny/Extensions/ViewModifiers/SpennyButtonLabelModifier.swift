//
//  SpennyButtonLabelModifier.swift
//  Spenny
//
//  Created by Greg Ross on 13/09/2022.
//

import Foundation
import SwiftUI


struct SpennyButtonLabelModifier: ViewModifier{
    func body(content: Content) -> some View {
        content
            .font(.headline)
            .foregroundColor(.white)
            .padding()
            .frame(maxWidth: .infinity)
            .background(
                LinearGradient(gradient: Gradient(colors: [.mint, .teal, .cyan, .blue]), startPoint: .leading, endPoint: .trailing)
            )
            .cornerRadius(15)
            .shadow(color: .black.opacity(0.3), radius: 2, x: 0, y: 0)
            .padding()
    }
}


extension Text{
    func withSpennyButtonLabelStyle() -> some View{
        modifier(SpennyButtonLabelModifier())
    }
}
