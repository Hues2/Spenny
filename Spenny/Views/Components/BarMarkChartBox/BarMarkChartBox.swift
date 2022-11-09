//
//  BarMarkChartBox.swift
//  Spenny
//
//  Created by Greg Ross on 08/11/2022.
//

import SwiftUI
import Charts

struct BarMarkChartBox: View{
    
    let chartObjects: [ChartObject]
    
    @Binding var animate: Bool
    
    var body: some View{
        
        GroupBox{
            Chart{
                ForEach(chartObjects){ chartObject in
                    withAnimation {
                        BarMark(x: .value("Date", chartObject.date), y: .value("Amount", animate ? chartObject.amountRemaining : 0))
                            .foregroundStyle(chartObject.amountRemaining < 0 ? .red : .green)
                            .cornerRadius(4)

                    }
                }
            }
            .animation(.spring(), value: animate)
            
        }
        .clipped()
        .shadow(color: .black.opacity(0.6), radius: 3, x: 0, y: 0)
        .frame(maxWidth: .infinity)
        .groupBoxStyle(ColoredGroupBox(frameHeight: 290))
        .padding(.horizontal)
        
    }
    
    
}
