//
//  AddTransactionViewModel.swift
//  Spenny
//
//  Created by Greg Ross on 13/09/2022.
//

import Foundation
import SwiftUI
import Combine

class AddTransactionViewModel: ObservableObject{
    
    @Published var transaction: Transaction = Transaction(title: "", amount: 0.00, date: "TEST DATE", transactionType: TransactionType(iconName: "", title: "", colorHex: ""), isDirectDebit: false)
    @Published var selectedTransactionType: TransactionType = TransactionType(iconName: "", title: "", colorHex: "")
    @Published var amount: Double? = nil
    @Published var isDirectDebit: Bool = false
    @Published var date = Date()
    
    @Binding var isAddingTransaction: Bool
    
    
    
    private var dataManager: DataManager
    
    init(dataManager: DataManager, isAddingTransaction: Binding<Bool>){
        self.dataManager = dataManager
        self._isAddingTransaction = isAddingTransaction
    }
    
    
    
    // MARK: Add Transaction
    func addTransaction(){
        guard let amount = amount, transactionIsValid() else { return }
        
        // Configure the transaction with the correct values
        transaction.amount = amount
        transaction.date = dateString()
        transaction.transactionType = selectedTransactionType
        transaction.isDirectDebit = isDirectDebit
        
        
        DispatchQueue.main.async {
            self.dataManager.addTransaction(transaction: self.transaction)
            self.resetValues()
        }
    }
    
    func transactionIsValid() -> Bool{
        // For the transaction type, as long as there is an icon, there will definitely be a title and hexColor too
        guard let _ = amount, !transaction.title.isEmpty && !transaction.date.isEmpty && !selectedTransactionType.iconName.isEmpty else { return  false}
        return true
    }
    
    func cancelTransaction(){
        resetValues()
    }
    
    private func resetValues(){
        transaction = Transaction(title: "", amount: 0.00, date: "TEST DATE", transactionType: TransactionType(iconName: "", title: "", colorHex: ""), isDirectDebit: false)
        selectedTransactionType = TransactionType(iconName: "", title: "", colorHex: "")
        amount = nil
        isDirectDebit = false
        withAnimation {
            isAddingTransaction = false
        }
        
    }
    
    private func dateString() -> String{
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.dateFormat = "dd/MM/yy"
        return formatter.string(from: self.date)
    }
}
