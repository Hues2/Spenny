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
                
                TextFieldHeader(title: title, isValid: isValidAmount, font: .title3)
                
                TextField("E.g. \(placeholder)", value: $amount, format: .number)
                    .keyboardType(.decimalPad)
                    .onTapGesture {}
            }
        }
        .frame(maxWidth: .infinity)
        .padding(.horizontal)
        .clipped()
        .shadow(color: .black.opacity(0.3), radius: 2, x: 0, y: 0)
        .groupBoxStyle(ColoredGroupBox(frameHeight: nil))
    }
}
