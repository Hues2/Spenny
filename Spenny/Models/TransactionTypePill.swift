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
                ZStack{
                    Circle()
                        .fill(Color(hex: hexColor))
                        .frame(width: 30, height:30)
                    Image(systemName: iconName)
                }
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


// MARK: For Filter View
struct FilterTransactionTypePill: View {
    let typeTitle: String
    let iconName: String
    let hexColor: String
        
    var isSelected: Bool = false
    
    var body: some View {
        HStack{
            Image(systemName: iconName)
            
            Text(typeTitle)
                .fontWeight(.bold)
        }
        .font(.headline)
        .foregroundColor(.white)
        .padding(.vertical, 5)
        .padding(.horizontal, 10)
        .background(
            Color(hex: hexColor)
        )
        .zIndex(5)
        .opacity(isSelected ? 1 : 0.5)
        .cornerRadius(30)
        .shadow(color: (.black.opacity(0.3)), radius: 3)
        
    }
}
