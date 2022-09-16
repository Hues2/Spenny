//
//  TransactionRow.swift
//  Spenny
//
//  Created by Greg Ross on 14/09/2022.
//

import SwiftUI

struct TransactionRow: View {
    @State var transaction: TransactionEntity
    @State var transactionType = TransactionType(iconName: "", typeTitle: "", hexColor: "")
    
    var body: some View {
        GroupBox{
            HStack{
                
                VStack{
                    
                    //MARK: - Transaction Type Pill
                    TransactionTypePill(typeTitle: transaction.typeTitle ?? "", iconName: transaction.iconName ?? "", hexColor: transaction.hexColor ?? "", transactionType: $transactionType, isSelectable: false)
                        .frame(width: 50)
                    
                    Text(transaction.isDirectDebit ? "Direct Debit" : "Transaction")
                        .font(.caption)
                        .fontWeight(.light)
                        .foregroundColor(.accentColor)
                }
                .frame(width: 75)
                
                
                Spacer()
                
                //MARK: - Transaction Date
                Text(transaction.date ?? "")
                    .font(.headline)
                    .fontWeight(.light)
                    .frame(width: 70)
                
                
                Spacer()
                
                //MARK: - Transaction Title
                Text(transaction.title ?? "")
                    .font(.headline)
                    .fontWeight(.light)
                    .lineLimit(1)
                    .frame(width: 75)
                
                Spacer()
                
                //MARK: - Transaction Amount
                Text("\((transaction.amount < 0) ? "-" : "")£\(transaction.amount.toFormattedString(format: "%.2f"))")
                    .font(.headline)
                    .fontWeight(.medium)
                    .foregroundColor(transaction.amount == 0.0 ? .gray : (transaction.amount > 0 ? .green : .red))
                    .frame(width: 75)
                    .frame(maxWidth: 130)
                    .lineLimit(1)
                    .layoutPriority(1)
                    .minimumScaleFactor(0.8)
            }
        }
        .frame(maxWidth: .infinity)
        .groupBoxStyle(ColoredGroupBox())
    }
}



