//
//  InfoBoxCenter.swift
//  Spenny
//
//  Created by Greg Ross on 08/11/2022.
//

import SwiftUI

struct InfoBoxCenter: View {
    
    var progress: Double
    var remaining: Double
    
    var color: Color{
        if progress < 0.9{
            return .green
        } else {
            return .red
        }
    }
    
    var body: some View {
        ZStack{
            
            Circle()
                .stroke(color.opacity(0.2), lineWidth: 15)
            
            Circle()
                .trim(from: progress, to: 1)
                .stroke(color.opacity(0.8), style: StrokeStyle(lineWidth: 15, lineCap: .round))
                .rotationEffect(Angle(degrees: 90))
                .animation(.easeInOut, value: progress)
                .rotation3DEffect(.degrees(180), axis: (x: 1, y: 0, z: 0))
                .shadow(color: color.opacity(0.4), radius: 3, x: 0, y: 0)
                .shadow(color: color.opacity(0.4), radius: 3, x: 0, y: 0)
            
        }
        .overlay(alignment: .center) {
            Rectangle()
                .fill(LinearGradient(gradient: Gradient(colors: [.mint, .teal, .cyan, .blue]), startPoint: .leading, endPoint: .trailing))
                .mask {
                    Text(remaining.toFormattedString(format: "%.2f"))
                        .font(.title2)
                        .fontWeight(.black)
                }
                .frame(maxWidth: 100, maxHeight: 100)
        }
    }
}
