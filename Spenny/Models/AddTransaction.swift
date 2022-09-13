//
//  AddTransaction.swift
//  Spenny
//
//  Created by Greg Ross on 13/09/2022.
//

import SwiftUI

struct AddTransaction: View {
    
//    @State var transaction: Transaction = Transaction(title: "", amount: "", date: "", icon: "", transaction: )
    var isDirectDebit: Bool
    
    
    var body: some View {
        GroupBox{
            VStack(alignment: .leading, spacing: 5) {
                Text("\(isDirectDebit ? "Add Direct Debit" : "Add Transaction"):")
                    .font(.caption)
                    .fontWeight(.semibold)
                    .foregroundColor(.accentColor)
//                TextField("E.g. Car Insurance", text: $transaction.title)
                
                Divider()
                
//                TextField("E.g. £313.18", text: $transaction.amount)
                    .keyboardType(.decimalPad)
            }
            
        }
        .frame(maxWidth: .infinity)
        .padding()
        .clipped()
        .shadow(color: .black.opacity(0.3), radius: 2, x: 0, y: 0)
    }
}



extension AddTransaction{
    
    private var transactionTypeScrollView: some View{
        ScrollView(.horizontal ,showsIndicators: false) {
            HStack{
                
            }
        }
    }
    
}
