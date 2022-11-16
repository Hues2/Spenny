//
//  InfoBoxHeader.swift
//  Spenny
//
//  Created by Greg Ross on 20/09/2022.
//

import SwiftUI

struct InfoBoxHeader: View {
    let text: String
    let amount: Double
    
    let isFooter: Bool
    let isPercent: Bool
    
    var amountString: String{
        return amount.withPoundSign(format: "%.2f")
    }
    
    var body: some View {
        VStack(spacing: 5){
            
            Text(text)
                .font(.footnote)
                .foregroundColor(.gray)
            
            if isFooter{
                if isPercent{
                    Text(amount.withPercentage(format: "%.2f"))
                        .font(.subheadline)
                        .foregroundColor(amountString.firstIndex(of: "-") == nil ? (amount >= 100 ? (amount < 120 ? .orange : .green) : .red) : .red)
                } else{
                    Text("\(amount.withPoundSign(format: "%.2f"))")
                        .font(.subheadline)
                        .foregroundColor(amountString.firstIndex(of: "-") == nil ? .green : .red)
                }
                
            } else{
                Text("\(amount.withPoundSign(format: "%.2f"))")
                    .font(.subheadline)
                    .foregroundColor(.accentColor)
            }
            
        }
        .frame(width: 105)
    }
}
