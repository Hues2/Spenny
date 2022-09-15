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
    
    @Published var title: String = ""
    @Published var amount: Double? = nil
    @Published var selectedTransactionType: TransactionType = TransactionType(iconName: "", title: "", colorHex: "")
    @Published var date = Date()
    @Published var isDirectDebit: Bool = false
    
    @Binding var isAddingTransaction: Bool
    @Published var titleIsValid: Bool = false
    @Published var amountIsValid: Bool = false
    
    
    
    private var dataManager: DataManager
    
    private var cancellables = Set<AnyCancellable>()
    
    init(dataManager: DataManager, isAddingTransaction: Binding<Bool>){
        self.dataManager = dataManager
        self._isAddingTransaction = isAddingTransaction
        self.addSubscribers()
    }
    
    
    
    
    
    
    
    private func addSubscribers(){
        self.$title
            .sink { [weak self] returnedTitle in
                self?.validateTitle()
            }
            .store(in: &cancellables)
        
        self.$amount
            .sink { [weak self] returnedAmount in
                self?.validateAmount()
            }
            .store(in: &cancellables)
        
    }
    
    
    // MARK: Validate Title
    private func validateTitle(){
        guard !title.isEmpty else { titleIsValid = false; return }
        titleIsValid = true
    }
    
    // MARK: Validate Amount
    private func validateAmount(){
        guard let _ = amount else { self.amountIsValid = false; return }
        self.amountIsValid = true
    }
    
    // MARK: Transaction Is Valid
    func transactionIsValid() -> Bool{
        // For the transaction type, as long as there is an icon, there will definitely be a title and hexColor too
        guard let _ = amount, !title.isEmpty && !dateString().isEmpty && !selectedTransactionType.iconName.isEmpty else { return  false}
        return true
    }
    
    // MARK: Add Transaction
    func addTransaction(){
        guard let amount = amount, transactionIsValid() else { return }
        
        var transaction: Transaction = Transaction(title: "", amount: 0.0, date: "", transactionType: TransactionType(iconName: "", title: "", colorHex: ""), isDirectDebit: false)
        // Configure the transaction with the correct values
        transaction.title = title
        transaction.amount = amount
        transaction.date = dateString()
        transaction.transactionType = selectedTransactionType
        transaction.isDirectDebit = isDirectDebit
        
        
        DispatchQueue.main.async {
            self.dataManager.addTransaction(transaction: transaction)
            self.resetValues()
        }
    }
    
    // MARK: Cancel Transaction
    func cancelTransaction(){
        resetValues()
    }
        
    private func resetValues(){
        title = ""
        amount = nil
        selectedTransactionType = TransactionType(iconName: "", title: "", colorHex: "")
        date = Date()
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
