//
//  AddTransactionViewModel.swift
//  Spenny
//
//  Created by Greg Ross on 13/09/2022.
//

import Foundation
import Combine

class AddTransactionViewModel: ObservableObject{
    
    @Published var transaction: Transaction = Transaction(title: "", amount: 0.00, date: "TEST DATE", transactionType: TransactionType(iconName: "", title: "", colorHex: ""), isDirectDebit: false)
    @Published var selectedTransactionType: TransactionType = TransactionType(iconName: "", title: "", colorHex: "")
    @Published var amount: Double? = nil
    private var isDirectDebit: Bool
    
    
    
    
    private var dataManager: DataManager
    
    init(dataManager: DataManager, isDirectDebit: Bool){
        self.dataManager = dataManager
        self.isDirectDebit = isDirectDebit// For the transaction type, as long as there is an icon, there will definitely be a title and hexColor too
    }
    
    
    
    
    
    // MARK: Add Transaction
    func addTransaction(){
        guard let amount = amount else { return }
        
        // Configure the transaction with the correct values
        transaction.amount = amount
        transaction.transactionType = selectedTransactionType
        transaction.isDirectDebit = isDirectDebit
        
        // For the transaction type, as long as there is an icon, there will definitely be a title and hexColor too
        guard !transaction.title.isEmpty && !transaction.date.isEmpty && !selectedTransactionType.iconName.isEmpty else { return }
        
        
        DispatchQueue.main.async {
            self.dataManager.addTransaction(transaction: self.transaction)
            self.resetValues()
        }
    }
    
    private func resetValues(){
        transaction = Transaction(title: "", amount: 0.00, date: "TEST DATE", transactionType: TransactionType(iconName: "", title: "", colorHex: ""), isDirectDebit: false)
        selectedTransactionType = TransactionType(iconName: "", title: "", colorHex: "")
        amount = nil
        isDirectDebit = false
    }
}
