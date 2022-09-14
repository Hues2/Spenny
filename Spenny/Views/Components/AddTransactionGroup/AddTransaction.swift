//
//  AddTransaction.swift
//  Spenny
//
//  Created by Greg Ross on 13/09/2022.
//

import SwiftUI

struct AddTransaction: View {
    
    @StateObject private var vm: AddTransactionViewModel
    let isDirectDebit: Bool
    
    
    init(dataManager: DataManager, isAddingDirectDebit: Binding<Bool>, isDirectDebit: Bool) {
        self._vm = StateObject(wrappedValue: AddTransactionViewModel(dataManager: dataManager, isDirectDebit: isDirectDebit, isAddingTransaction: isAddingDirectDebit))
        self.isDirectDebit = isDirectDebit
    }
    
    
    var body: some View {
        GroupBox{
            
            VStack(alignment: .leading, spacing: 5) {
                
                // MARK: Add Transaction Header
                header
                
                // MARK: TextFields
                textFields
                
                // MARK: Transaction Types
                transactionTypeScrollView

            }
            
        }
        .frame(maxWidth: .infinity)
        .clipped()
        .shadow(color: .black.opacity(0.3), radius: 2, x: 0, y: 0)
        .padding()
        
    }
}



extension AddTransaction{
    
    private var header: some View{
        HStack{
            Text("\(isDirectDebit ? "Add Direct Debit" : "Add Transaction"):")
                .font(.caption)
                .fontWeight(.semibold)
                .foregroundColor(.accentColor)
            
            Spacer()
            
            HStack(spacing: 15){
                
                Button {
                    vm.cancelTransaction()
                } label: {
                    Image(systemName: "trash.square.fill")
                        .font(.title)
                        .foregroundColor(.red)
                }
                
                if vm.transactionIsValid(){
                    Button {
                        vm.addTransaction()
                    } label: {
                        Image(systemName: "checkmark.square.fill")
                            .font(.title)
                            .foregroundColor(.green)
                    }
                }
            }
        }
    }
    
    private var textFields: some View{
        VStack{
            TextField("E.g. Car Insurance", text: $vm.transaction.title)
                .lineLimit(1)
            
            Divider()
            
            TextField("E.g. £313.18", value: $vm.amount, format: .number)
                .lineLimit(1)
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
        if vm.transactionIsValid(){
            Button {
                vm.addTransaction()
            } label: {
                Text("Add")
                    .withSpennyButtonLabelStyle()
            }
        }
    }
    
}
