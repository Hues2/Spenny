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
    @Published var date = Date()
    @Published var isDirectDebit: Bool = false
    @Published var isIncome: Bool = false
    
    @Published var transactionType = TransactionType(iconName:"", typeTitle: "", hexColor: "")
    
    @Binding var isAddingTransaction: Bool
    @Published var titleIsValid: Bool = false
    @Published var amountIsValid: Bool = false
    let isNewUser: Bool
    
    
    
    var dataManager: DataManager
    
    private var cancellables = Set<AnyCancellable>()
    
    init(dataManager: DataManager, isAddingTransaction: Binding<Bool>, isNewUser: Bool){
        self.dataManager = dataManager
        self._isAddingTransaction = isAddingTransaction
        self.isNewUser = isNewUser
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
        guard let _ = amount, let iconName = transactionType.iconName, !title.isEmpty && !iconName.isEmpty  else { return  false}
        return true
    }
    
    
    
    // MARK: Add Transaction
    func addTransaction(){
        guard let amount = amount, transactionIsValid() else { return }
        
        let transaction = TransactionEntity(context: dataManager.coreDataManager.container.viewContext)
        
        // Configure the transaction with the correct values
        transaction.title = title
        transaction.amount = (self.isIncome ? amount : -amount)
        transaction.date = dateString()
        transaction.isDirectDebit = isDirectDebit
        transaction.typeTitle = transactionType.typeTitle
        transaction.iconName = transactionType.iconName
        transaction.hexColor = transactionType.hexColor
        transaction.id = UUID()
        transaction.spennyEntity = dataManager.spennyEntity
        
        
        
        DispatchQueue.main.async {
            self.dataManager.addTransaction(transaction: transaction)
            self.resetValues()
        }
    }
    
    
    // MARK: Cancel Transaction
    func cancelTransaction(){
        resetValues()
    }
        
    
    //MARK: - Reset Values
    private func resetValues(){
        title = ""
        amount = nil
        transactionType.iconName = ""
        date = Date()
        isDirectDebit = false
        withAnimation {
            isAddingTransaction = false
        }
        
    }
    
    //MARK: - Date To String
    private func dateString() -> String{
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.dateFormat = "dd/MM/yy"
        return formatter.string(from: self.date)
    }
    
}
