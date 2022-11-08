//
//  CustomGroupBoxStyle.swift
//  Spenny
//
//  Created by Greg Ross on 15/09/2022.
//

import Foundation
import SwiftUI


struct ColoredGroupBox: GroupBoxStyle {
    let frameHeight: CGFloat?
    func makeBody(configuration: Configuration) -> some View {
        if let frameHeight {
            configuration.content
                .padding()
                .frame(height: frameHeight)
                .background(RoundedRectangle(cornerRadius: 8, style: .continuous)
                    .fill(Color.groupBoxBackgroundColor)) // Set your color here!!
                
        } else{
            configuration.content
                .padding()
                .background(RoundedRectangle(cornerRadius: 8, style: .continuous)
                    .fill(Color.groupBoxBackgroundColor)) // Set your color here!!
        }
        
        
    }
}
