//
//  TransactionRow.swift
//  Spenny
//
//  Created by Greg Ross on 14/09/2022.
//

import SwiftUI

struct TransactionRow: View {
    @State var transaction: Transaction
    
    var body: some View {
        GroupBox{
            HStack{
                
                VStack{
                    
                    //MARK: - Transaction Type Pill
                    TransactionTypePill(transactionType: transaction.transactionType, selectedTransactionType: $transaction.transactionType, isSelectable: false)
                        .frame(width: 50)
                    
                    Text(transaction.isDirectDebit ? "Direct Debit" : "Transaction")
                        .font(.caption)
                        .fontWeight(.light)
                        .foregroundColor(.accentColor)
                }
                .frame(width: 75)
                
                
                Spacer()
                
                //MARK: - Transaction Date
                Text(transaction.date)
                    .font(.headline)
                    .fontWeight(.light)
                    .frame(width: 75)
                
                
                Spacer()
                
                //MARK: - Transaction Title
                Text(transaction.title)
                    .font(.headline)
                    .fontWeight(.light)
                    .lineLimit(1)
                    .frame(width: 80)
                
                Spacer()
                
                
                //MARK: - Transaction Amount
                Text("£\(transaction.amount.toFormattedString(format: "%.2f"))")
                    .font(.headline)
                    .fontWeight(.medium)
                    .foregroundColor(transaction.amount == 0.0 ? .gray : (transaction.amount > 0 ? .green : .red))
                    .frame(width: 75)
                    .frame(maxWidth: 125)
                    .layoutPriority(1)
            }
        }
        .frame(maxWidth: .infinity)
        .groupBoxStyle(ColoredGroupBox())
    }
}



