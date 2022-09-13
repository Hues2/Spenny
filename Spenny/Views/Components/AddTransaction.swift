//
//  AddTransaction.swift
//  Spenny
//
//  Created by Greg Ross on 13/09/2022.
//

import SwiftUI

struct AddTransaction: View {

    
    @State var transaction: Transaction = Transaction(title: "", amount: "", date: "Insert Date", transactionType: TransactionType(iconName: "", title: "", colorHex: ""), isDirectDebit: true)
    @Binding var directDebit: Transaction
    @Binding var selectedTransactionType: TransactionType
    let addDirectDebit: ((@escaping () -> ()) -> ())
    
    @Binding var isAddingDirectDebit: Bool
    
    let modalViewModel: ModalViewModel

    
    var body: some View {
        GroupBox{
            VStack(alignment: .leading, spacing: 5) {
                Text("\(transaction.isDirectDebit ? "Add Direct Debit" : "Add Transaction"):")
                    .font(.caption)
                    .fontWeight(.semibold)
                    .foregroundColor(.accentColor)
                TextField("E.g. Car Insurance", text: $transaction.title)
                
                Divider()
                
                TextField("E.g. £313.18", text: $transaction.amount)
                    .keyboardType(.decimalPad)
            }
            
            // MARK: Transaction Types
            transactionTypeScrollView
            
            //MARK: - Add Direct Debit Button
            addDirectDebitButton
            
            
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
                ForEach(ListOfTransactionTypes.transactionTypes){ transactionType in
                    TransactionTypePill(transactionType: transactionType, selectedTransactionType: $selectedTransactionType)
                }
            }
        }
    }
    
    @ViewBuilder private var addDirectDebitButton: some View{
        if !transaction.title.isEmpty && !transaction.amount.isEmpty && !transaction.date.isEmpty && !selectedTransactionType.title.isEmpty && !selectedTransactionType.iconName.isEmpty
            && !selectedTransactionType.colorHex.isEmpty {
            
            Button {
                
                transaction.transactionType = selectedTransactionType
                directDebit = transaction
                
                addDirectDebit{
                    // Reset the transaction, incase the user wants to add another direct debit
                    
                    self.transaction = Transaction(title: "", amount: "", date: "Insert Date", transactionType: TransactionType(iconName: "", title: "", colorHex: ""), isDirectDebit: true)
                    directDebit = transaction
                    selectedTransactionType = transaction.transactionType
                    
                    withAnimation {
                        isAddingDirectDebit = false
                    }
                    
                }
            } label: {
                Text("Add")
                    .withSpennyButtonLabelStyle()
            }
        }
        
    }
    
}
