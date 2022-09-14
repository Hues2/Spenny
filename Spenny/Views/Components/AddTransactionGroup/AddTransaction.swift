//
//  AddTransaction.swift
//  Spenny
//
//  Created by Greg Ross on 13/09/2022.
//

import SwiftUI

struct AddTransaction: View {

    @StateObject private var vm: AddTransactionViewModel
    
    init(dataManager: DataManager, isAddingTransaction: Binding<Bool>) {
        self._vm = StateObject(wrappedValue: AddTransactionViewModel(dataManager: dataManager, isAddingTransaction: isAddingTransaction))
    }
    
    
    var body: some View {
        GroupBox{
            
            VStack(alignment: .leading, spacing: 5) {
                
                // MARK: Add Transaction Header
                header
                
                // MARK: Is Direct Debit Toggle
                isDirectDebitToggle
                
                // MARK: TextFields
                textFields
                
                // MARK: Date Picker
                datePicker
                
                
                // MARK: Transaction Types
                transactionTypeScrollView
                
                // MARK: Add Transaction Button
                addTransactionButton

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
            Text("Add Transaction:")
                .font(.title3)
                .fontWeight(.semibold)
                .foregroundColor(.accentColor)
            
            Spacer()
            
            HStack(spacing: 15){
                
                Button {
                    vm.cancelTransaction()
                } label: {
                    Image(systemName: "xmark")
                        .font(.title3)
                        .foregroundColor(.red)
                }
            }
        }
    }
    
    private var isDirectDebitToggle: some View{
        HStack{
            Text("Direct Debit:")
                .font(.subheadline)
                .fontWeight(.semibold)
                .foregroundColor(.accentColor)
            
            Toggle(isOn: $vm.isDirectDebit) {
                Text("")
            }
        }
        .padding(.top, 50)
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
        .padding(.top, 20)
    }
    
    private var datePicker: some View{
        VStack(alignment: .leading){
            Text("Transaction Date:")
                .font(.subheadline)
                .fontWeight(.semibold)
                .foregroundColor(.accentColor)
            
            DatePicker("", selection: $vm.date, displayedComponents: [.date])
                .datePickerStyle(.wheel)
                .labelsHidden()
        }
        
        .padding(.top, 10)
    }
    
    private var transactionTypeScrollView: some View{
        VStack(alignment: .leading){
            Text("Transaction Date:")
                .font(.subheadline)
                .fontWeight(.semibold)
                .foregroundColor(.accentColor)
            
            ScrollView(.horizontal ,showsIndicators: false) {
                HStack{
                    ForEach(ListOfTransactionTypes.transactionTypes){ transactionType in
                        TransactionTypePill(transactionType: transactionType, selectedTransactionType: $vm.selectedTransactionType)
                    }
                }
            }
        }
        .padding(.top, 20)
    }
    
    @ViewBuilder private var addTransactionButton: some View{
        if vm.transactionIsValid(){
            Button {
                vm.addTransaction()
            } label: {
                Text("Add")
                    .fontWeight(.bold)
                    .withSpennyButtonLabelStyle()
            }
            .buttonStyle(SpennyButtonStyle())
            .padding(.top, 10)
        }
       
    }
    
}
