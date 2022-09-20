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
    
    var body: some View {
        VStack(spacing: 5){
            
            Text(text)
                .font(.footnote)
                .foregroundColor(.gray)
            
            Text("\(amount.toFormattedString(format: "%.2f"))")
                .font(.subheadline)
                .foregroundColor(.accentColor)
        }
    }
}
