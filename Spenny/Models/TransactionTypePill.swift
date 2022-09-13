//
//  TransactionTypePill.swift
//  Spenny
//
//  Created by Greg Ross on 13/09/2022.
//

import SwiftUI

struct TransactionTypePill: View {
    let transactionType: TransactionType
    @Binding var selectedTransactionType: TransactionType
    
    var body: some View {
        HStack{
            Image(systemName: transactionType.iconName)
            Text(transactionType.title)
                .fontWeight(.bold)
        }
        .font(.headline)
        .foregroundColor(.white)
        .padding(.vertical, 5)
        .padding(.horizontal, 10)
        .background(
            Color(hex: transactionType.colorHex)
        )
        .cornerRadius(30)
        .shadow(color: (.black.opacity(0.3)), radius: 3)
        .overlay(
            RoundedRectangle(cornerRadius: 30)
                .stroke(transactionType == selectedTransactionType ? Color.primary : .clear, lineWidth: 2)
        )
        .padding(2)
        .onTapGesture {
            withAnimation {
                selectedTransactionType = transactionType
            }
        }
    }
}
