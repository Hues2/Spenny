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
    @Binding var amount: String
    
    var body: some View {
        GroupBox{
            VStack(alignment: .leading, spacing: 10) {
                Text("\(title):")
                    .font(.title3)
                    .fontWeight(.semibold)
                    .foregroundColor(.accentColor)
                TextField("E.g. \(placeholder)", text: $amount)
                    .keyboardType(.decimalPad)
                    .onTapGesture {}
            }
        }
        .frame(maxWidth: .infinity)
        .padding()
        .clipped()
        .shadow(color: .black.opacity(0.3), radius: 2, x: 0, y: 0)
    }
}

struct ModalTextField_Previews: PreviewProvider {
    static var previews: some View {
        ModalTextField(title: "Montlhy Income", placeholder: "£99.00", amount: .constant(""))
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
