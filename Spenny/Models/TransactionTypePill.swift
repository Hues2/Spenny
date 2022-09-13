//
//  TransactionTypePill.swift
//  Spenny
//
//  Created by Greg Ross on 13/09/2022.
//

import SwiftUI

struct TransactionTypePill: View {
    let transactionType: TransactionType
    
    var body: some View {
        HStack{
            Image(systemName: transactionType.iconName)
            Text(transactionType.title)
                .fontWeight(.bold)
        }
        .font(.headline)
        .foregroundColor(.white)
        .padding()
        .background(
            Color(hex: transactionType.colorHex)
        )
        .cornerRadius(25)
    }
}

struct TransactionTypePill_Previews: PreviewProvider {
    static var transactionType = TransactionType(iconName: "house.fill", title: "Rent", colorHex: "#00C17C")
    static var previews: some View {
        TransactionTypePill(transactionType: transactionType)
    }
}
