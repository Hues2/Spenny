//
//  LineChartBox.swift
//  Spenny
//
//  Created by Greg Ross on 08/11/2022.
//

import Foundation
import SwiftUI
import Charts



struct LineChartBox: View{
    
    let chartObjects: [ChartObject]
    
    var body: some View{
        
        GroupBox{
            Chart{
                ForEach(chartObjects){ chartObject in
                    withAnimation {
                        LineMark(x: .value("Date", chartObject.date), y: .value("Amount", chartObject.amountRemaining))
                    }
                }
            }
            
        }
        .clipped()
        .shadow(color: .black.opacity(0.6), radius: 3, x: 0, y: 0)
        .frame(maxWidth: .infinity)
        .groupBoxStyle(ColoredGroupBox(frameHeight: 290))
        .padding(.horizontal)
        
    }
    
    
}
