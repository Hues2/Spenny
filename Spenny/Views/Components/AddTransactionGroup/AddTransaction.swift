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
                
                //MARK: - Is Income Toggle
                isIncomeToggle
                
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
    
    private var isIncomeToggle: some View{
        VStack(alignment: .center){
            HStack{
                payInOption
                
                Spacer()
                
                payOutOption
            }
            Divider()
        }
        .padding(.top, 40)
    }
    
    private var payInOption: some View{
        ZStack{
            
            if vm.isIncome{
                RoundedRectangle(cornerRadius: 15)
                    .fill(
                        LinearGradient(gradient: Gradient(colors: [.mint, .teal, .cyan, .blue]), startPoint: .leading, endPoint: .trailing)
                    )
                    .cornerRadius(15)
                    .matchedGeometryEffect(id: "option1Background", in: namespace)
            }
            Text("Pay In")
                .font(.body)
                .fontWeight(.bold)
                .foregroundColor(vm.isIncome ? .white : .accentColor)
                .opacity(vm.isIncome ? 1 : 0.4)
                .padding(.vertical, 5)
                .padding(.horizontal, 10)
        }
        .frame(width: 100)
        .onTapGesture {
            withAnimation(.spring()) {
                vm.isIncome = true
            }
        }
    }
    
    private var payOutOption: some View{
        ZStack{
            if !vm.isIncome{
                RoundedRectangle(cornerRadius: 15)
                    .fill(
                        LinearGradient(gradient: Gradient(colors: [.mint, .teal, .cyan, .blue]), startPoint: .leading, endPoint: .trailing)
                    )
                    .cornerRadius(15)
                    .matchedGeometryEffect(id: "option1Background", in: namespace)
            }
            
            Text("Pay Out")
                .font(.body)
                .fontWeight(.bold)
                .foregroundColor(vm.isIncome ? .accentColor : .white)
                .opacity(vm.isIncome ? 0.4 : 1)
                .padding(.vertical, 5)
                .padding(.horizontal, 10)
        }
        .frame(width: 100)
        .onTapGesture {
            withAnimation(.spring()) {
                vm.isIncome = false
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
            
            Divider()
        }
        .padding(.top, 15)
    }
    
    private var standardTransactionOption: some View{
        ZStack{
            if !vm.isDirectDebit{
                RoundedRectangle(cornerRadius: 15)
                    .fill(
                        LinearGradient(gradient: Gradient(colors: [.mint, .teal, .cyan, .blue]), startPoint: .leading, endPoint: .trailing)
                    )
                    .cornerRadius(15)
                    .matchedGeometryEffect(id: "option2Background", in: namespace)
            }
            
            Text("Standard Transaction")
                .font(.body)
                .fontWeight(.bold)
                .foregroundColor(vm.isDirectDebit ? .accentColor : .white)
                .opacity(vm.isDirectDebit ? 0.4 : 1)
                .padding(.vertical, 5)
                .padding(.horizontal, 10)
        }
        .frame(width: 150)
            .onTapGesture {
                withAnimation(.spring()) {
                    vm.isDirectDebit = false
                }
            }
            
    }
    
    private var directDebitOption: some View{
        ZStack{
            if vm.isDirectDebit{
                RoundedRectangle(cornerRadius: 15)
                    .fill(
                        LinearGradient(gradient: Gradient(colors: [.mint, .teal, .cyan, .blue]), startPoint: .leading, endPoint: .trailing)
                    )
                    .cornerRadius(15)
                    .matchedGeometryEffect(id: "option2Background", in: namespace)
            }
            
            Text("Direct Debit")
                .font(.body)
                .fontWeight(.bold)
                .foregroundColor(vm.isDirectDebit ? .white : .accentColor)
                .opacity(vm.isDirectDebit ? 1 : 0.4)
                .padding(.vertical, 5)
                .padding(.horizontal, 10)
        }
        .frame(width: 150)
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
                
                TextFieldHeader(title: vm.isDirectDebit ? "Direct Debit Title" : "Transaction Title", isValid: vm.titleIsValid, font: .subheadline)
                    .animation(.none, value: vm.isDirectDebit)
                
                TextField("Transaction Title", text: $vm.title, prompt: Text("E.g. Car Insurance"))
                    .onTapGesture {}
                    .lineLimit(1)
                
                Divider()
            }
            
            
            // MARK: Amount TextField
            VStack(alignment: .leading){
                
                TextFieldHeader(title: vm.isDirectDebit ? "Direct Debit Amount" : "Transaction Amount", isValid: vm.amountIsValid, font: .subheadline)
                    .animation(.none, value: vm.isDirectDebit)
                
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
            Text(vm.isDirectDebit ? "Direct Debit Date" : "Transaction Date:")
                .font(.subheadline)
                .fontWeight(.semibold)
                .foregroundColor(.accentColor)
                .animation(.none, value: vm.isDirectDebit)
            
            DatePicker("", selection: $vm.date, displayedComponents: [.date])
                .datePickerStyle(.compact)
                .labelsHidden()
            
            Divider()
        }
        
        .padding(.top, 10)
    }
    
    private var transactionTypeScrollView: some View{
        VStack(alignment: .leading){
            Text(vm.isDirectDebit ? "Direct Debit Type" : "Transaction Type:")
                .font(.subheadline)
                .fontWeight(.semibold)
                .foregroundColor(.accentColor)
                .animation(.none, value: vm.isDirectDebit)
            
            ScrollView(.horizontal ,showsIndicators: false) {
                HStack{
                    ForEach(ListOfTransactionTypes.transactionTypes){ transactionType in
                        TransactionTypePill(typeTitle: transactionType.typeTitle, iconName: transactionType.iconName ?? "", hexColor: transactionType.hexColor, transactionType: $vm.transactionType, isSelectable: true)
                    }
                }
            }
        }
        .padding(.top, 20)
    }
    
    @ViewBuilder private var addTransactionButton: some View{
        Button {
            vm.addTransaction()
        } label: {
            Text("Add")
                .fontWeight(.bold)
                .withSpennyButtonLabelStyle()
                .opacity(vm.transactionIsValid() ? 1 : 0.3)
        }
        .buttonStyle(SpennyButtonStyle())
        .padding(.top, 10)
        .scaleEffect(vm.transactionIsValid() ? 1 : 0.7)
        .animation(.spring(), value: vm.transactionIsValid())
        .disabled(!vm.transactionIsValid())
        
    }
    
}
