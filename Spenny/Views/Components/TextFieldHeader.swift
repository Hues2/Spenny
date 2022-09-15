//
//  TextFieldHeader.swift
//  Spenny
//
//  Created by Greg Ross on 15/09/2022.
//

import SwiftUI

struct TextFieldHeader: View {
    
    let title: String
    let isValid: Bool
    let font: Font
    
    var body: some View {
        HStack{
            Text("\(title):")
                .font(font)
                .fontWeight(.semibold)
                .foregroundColor(.accentColor)
            
            Spacer()
            
            Image(systemName: isValid ? "checkmark.circle" : "xmark.circle")
                .font(.caption)
                .foregroundColor(isValid ? .green : .red)
        }
    }
}
