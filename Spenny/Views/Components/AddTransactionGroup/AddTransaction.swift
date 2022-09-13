//
//  AddTransaction.swift
//  Spenny
//
//  Created by Greg Ross on 13/09/2022.
//

import SwiftUI

struct AddTransaction: View {
    
    @StateObject var vm: AddTransactionViewModel
    @Binding var isAddingDirectDebit: Bool
    let isDirectDebit: Bool
    

    init(dataManager: DataManager, isAddingDirectDebit: Binding<Bool>, isDirectDebit: Bool) {
        self._vm = StateObject(wrappedValue: AddTransactionViewModel(dataManager: dataManager))
        self._isAddingDirectDebit = isAddingDirectDebit
        self.isDirectDebit = isDirectDebit
    }

    
    var body: some View {
        GroupBox{
            VStack(alignment: .leading, spacing: 5) {
                Text("\(isDirectDebit ? "Add Direct Debit" : "Add Transaction"):")
                    .font(.caption)
                    .fontWeight(.semibold)
                    .foregroundColor(.accentColor)
                TextField("E.g. Car Insurance", text: $vm.transaction.title)
                
                Divider()
                
                TextField("E.g. £313.18", text: $vm.transaction.amount)
                    .keyboardType(.decimalPad)
                
                // MARK: Transaction Types
                transactionTypeScrollView
                
                //MARK: - Add Direct Debit Button
                addDirectDebitButton
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
                ForEach(ListOfTransactionTypes.transactionTypes){ transactionType in
                    TransactionTypePill(transactionType: transactionType, selectedTransactionType: $vm.selectedTransactionType)
                }
            }
        }
    }
    
    @ViewBuilder private var addDirectDebitButton: some View{
            Button {
                print("\n Add direct debit button pressed \n")
            } label: {
                Text("Add")
                    .withSpennyButtonLabelStyle()
            }
    }
    
}
