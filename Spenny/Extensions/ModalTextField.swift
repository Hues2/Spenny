//
//  ModalTextField.swift
//  Spenny
//
//  Created by Greg Ross on 13/09/2022.
//

import SwiftUI

struct ModalTextField: View {
    let title: String
    let placeholder: String
    @Binding var amount: Double?
    @Binding var isValidAmount: Bool
    
    var body: some View {
        GroupBox{
            VStack(alignment: .leading, spacing: 10) {
                HStack{
                    Text("\(title):")
                        .font(.title3)
                        .fontWeight(.semibold)
                        .foregroundColor(.accentColor)
                    
                    Spacer()
                    
                    Image(systemName: isValidAmount ? "checkmark.circle" : "xmark.circle")
                        .font(.caption)
                        .foregroundColor(isValidAmount ? .green : .red)
                }
                
                TextField("E.g. \(placeholder)", value: $amount, format: .number)
                    .keyboardType(.decimalPad)
                    .onTapGesture {}
            }
        }
        .frame(maxWidth: .infinity)
        .padding(.horizontal)
        .clipped()
        .shadow(color: .black.opacity(0.3), radius: 2, x: 0, y: 0)
    }
}
