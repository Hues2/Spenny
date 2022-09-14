//
//  AddTransaction.swift
//  Spenny
//
//  Created by Greg Ross on 13/09/2022.
//

import SwiftUI

struct AddTransaction: View {
    
    @StateObject private var vm: AddTransactionViewModel
    @Binding var isAddingDirectDebit: Bool
    let isDirectDebit: Bool
    @FocusState private var isAmountFocused: Bool
    

    init(dataManager: DataManager, isAddingDirectDebit: Binding<Bool>, isDirectDebit: Bool) {
        self._vm = StateObject(wrappedValue: AddTransactionViewModel(dataManager: dataManager, isDirectDebit: isDirectDebit))
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
                
                // MARK: TextFields
                textFields
                
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
    
    private var textFields: some View{
        VStack{
            TextField("E.g. Car Insurance", text: $vm.transaction.title)
            
            Divider()
            
            TextField("E.g. £313.18", value: $vm.amount, format: .number)
                .focused($isAmountFocused)
                .keyboardType(.decimalPad)
        }
        .padding(.top, 10)
    }
    
    private var transactionTypeScrollView: some View{
        ScrollView(.horizontal ,showsIndicators: false) {
            HStack{
                ForEach(ListOfTransactionTypes.transactionTypes){ transactionType in
                    TransactionTypePill(transactionType: transactionType, selectedTransactionType: $vm.selectedTransactionType)
                }
            }
        }
        .padding(.top, 20)
    }
    
    @ViewBuilder private var addDirectDebitButton: some View{
            Button {
                isAmountFocused = false
                vm.addTransaction()
            } label: {
                Text("Add")
                    .withSpennyButtonLabelStyle()
            }
    }
    
}
