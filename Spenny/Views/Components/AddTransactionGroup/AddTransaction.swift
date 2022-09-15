//
//  AddTransaction.swift
//  Spenny
//
//  Created by Greg Ross on 13/09/2022.
//

import SwiftUI

struct AddTransaction: View {

    @StateObject private var vm: AddTransactionViewModel
    @Namespace var namespace
    @State var dismissKeyboardDrag: CGFloat = .zero
    
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
        .onTapGesture {
            UIApplication.shared.dismissKeyboard()
        }
        .groupBoxStyle(ColoredGroupBox())
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
        VStack(alignment: .center){
            HStack{
                standardTransactionOption
                
                Spacer()
                
                directDebitOption
            }
        }
        .padding(.top, 40)
    }
    
    private var standardTransactionOption: some View{
        Text("Standard Transaction")
            .font(.body)
            .fontWeight(.bold)
            .foregroundColor(vm.isDirectDebit ? .accentColor : .white)
            .opacity(vm.isDirectDebit ? 0.3 : 1)
            .padding(.vertical, 5)
            .padding(.horizontal, 10)
            .background(
                ZStack{
                    if !vm.isDirectDebit{
                        RoundedRectangle(cornerRadius: 15)
                            .fill(
                                LinearGradient(gradient: Gradient(colors: [.mint, .teal, .cyan, .blue]), startPoint: .leading, endPoint: .trailing)
                            )
                            .matchedGeometryEffect(id: "optionBackground", in: namespace)
                    }
                }
                
            )
            .cornerRadius(15)
            .onTapGesture {
                withAnimation {
                    vm.isDirectDebit = false
                }
            }
    }
    
    private var directDebitOption: some View{
        Text("Direct Debit")
            .font(.body)
            .fontWeight(.bold)
            .foregroundColor(vm.isDirectDebit ? .white : .accentColor)
            .opacity(vm.isDirectDebit ? 1 : 0.3)
            .padding(.vertical, 5)
            .padding(.horizontal, 10)
            .background(
                ZStack{

                    if vm.isDirectDebit{
                        RoundedRectangle(cornerRadius: 15)
                            .fill(
                                LinearGradient(gradient: Gradient(colors: [.mint, .teal, .cyan, .blue]), startPoint: .leading, endPoint: .trailing)
                            )
                            .matchedGeometryEffect(id: "optionBackground", in: namespace)
                    }
                }
            )
            .cornerRadius(15)
            .onTapGesture {
                withAnimation(.spring()) {
                    vm.isDirectDebit = true
                }
            }
    }
    
    private var textFields: some View{
        VStack{
            
            // MARK: Title TextField
            VStack(alignment: .leading){
                
                TextFieldHeader(title: "Transaction Title:", isValid: vm.titleIsValid, font: .subheadline)
                
                TextField("Transaction Title", text: $vm.title, prompt: Text("E.g. Car Insurance"))
                    .onTapGesture {}
                    .lineLimit(1)
                
                Divider()
            }
            
            
            // MARK: Amount TextField
            VStack(alignment: .leading){
                
                TextFieldHeader(title: "Transaction Amount:", isValid: vm.amountIsValid, font: .subheadline)
                
                TextField("E.g. £313.18", value: $vm.amount, format: .number)
                    .onTapGesture {}
                    .lineLimit(1)
                    .keyboardType(.decimalPad)
                
                Divider()
            }
            .padding(.top, 10)
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
                .datePickerStyle(.compact)
                .labelsHidden()
        }
        
        .padding(.top, 10)
    }
    
    private var transactionTypeScrollView: some View{
        VStack(alignment: .leading){
            Text("Transaction Type:")
                .font(.subheadline)
                .fontWeight(.semibold)
                .foregroundColor(.accentColor)
            
            ScrollView(.horizontal ,showsIndicators: false) {
                HStack{
                    ForEach(ListOfTransactionTypes.transactionTypes){ transactionType in
                        TransactionTypePill(transactionType: transactionType, selectedTransactionType: $vm.selectedTransactionType, isSelectable: true)
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
