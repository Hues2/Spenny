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
    
    var amountString: String{
        return amount.withPoundSign(format: "%.2f")
    }
    
    var body: some View {
        VStack(spacing: 5){
            
            Text(text)
                .font(.footnote)
                .foregroundColor(.gray)
            
            Text("\(amount.withPoundSign(format: "%.2f"))")
                .font(.subheadline)
                .foregroundColor(amountString.firstIndex(of: "-") == nil ? .green : .red)
        }
    }
}
