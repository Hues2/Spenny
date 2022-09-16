//
//  TransactionTypePill.swift
//  Spenny
//
//  Created by Greg Ross on 13/09/2022.
//

import SwiftUI

struct TransactionTypePill: View {
    let typeTitle: String
    let iconName: String
    let hexColor: String
    @Binding var transactionType: TransactionType
    
    let isSelectable: Bool
    
    var body: some View {
        HStack{
            if !isSelectable{
                Image(systemName: iconName)
                    .resizable()
                    .frame(width: 20, height: 20)
                    .padding(2.5)
            }
            
            if isSelectable{
                Image(systemName: iconName)
                
                Text(typeTitle)
                    .fontWeight(.bold)
            }
        }
        .font(.headline)
        .foregroundColor(.white)
        .padding(.vertical, 5)
        .padding(.horizontal, isSelectable ? 10 : 5)
        .background(
            Color(hex: hexColor)
        )
        .cornerRadius(30)
        .shadow(color: (.black.opacity(0.3)), radius: 3)
        .overlay(
            RoundedRectangle(cornerRadius: 30)
                .stroke(((iconName == transactionType.iconName) && isSelectable) ? Color.primary : .clear, lineWidth: 2)
        )
        .padding(2)
        .onTapGesture {
            withAnimation {
                if isSelectable{
                    transactionType.iconName = iconName
                    transactionType.typeTitle = typeTitle
                    transactionType.hexColor = hexColor
                }
            }
        }
    }
}
