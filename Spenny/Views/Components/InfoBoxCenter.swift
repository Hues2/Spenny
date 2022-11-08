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
            if progress > 0.8{
                return .orange
            } else{
                return .green
            }
            
        } else {
            return .red
        }
    }
    
    @State var percentToAnimate: Double = 0
    
    var body: some View {
        ZStack{
            
            Circle()
                .stroke(color.opacity(0.15), lineWidth: 15)
            
            Circle()
                .trim(from: percentToAnimate, to: 1)
                .stroke(color.opacity(0.8), style: StrokeStyle(lineWidth: 15, lineCap: .round))
                .rotationEffect(Angle(degrees: 90))
                .animation(.easeInOut, value: progress)
                .rotation3DEffect(.degrees(180), axis: (x: 1, y: 0, z: 0))
                .shadow(color: color.opacity(0.4), radius: 3, x: 0, y: 0)
                .shadow(color: color.opacity(0.4), radius: 3, x: 0, y: 0)
            
        }
        .overlay(alignment: .center) {
            Text(remaining.toFormattedString(format: "%.2f"))
                .foregroundColor(color)
                .font(.title2)
                .fontWeight(.black)
                .lineLimit(1)
                .minimumScaleFactor(0.7)
                .frame(maxWidth: 90, maxHeight: 90)
        }
        .onAppear{
            withAnimation(.easeInOut(duration: 1)) {
                self.percentToAnimate = progress
            }
        }
        .onChange(of: self.progress) { newValue in
            withAnimation(.easeInOut(duration: 1)) {
                percentToAnimate = newValue
            }
        }
    }
}
