//
//  ModalViewModel.swift
//  Spenny
//
//  Created by Greg Ross on 12/09/2022.
//

import Foundation
import Combine

class ModalViewModel: ObservableObject{
    @Published var monthlyIncome: String = ""
    @Published var savingsGoal: String = ""
    @Published var directDebits: [Transaction] = []
    private let transactions: [Transaction] = [] // --> This will be empty when the user enters their data for the first time
    
    @Published var directDebit: Transaction = Transaction(title: "", amount: "", date: "", transactionType: TransactionType(iconName: "", title: "", colorHex: ""), isDirectDebit: true) // --> This transaction will be reused as different direct debits, and appended to the direct debits
    @Published var selectedTransactionType: TransactionType = TransactionType(iconName: "", title: "", colorHex: "")
    
    
    let dataManager: DataManager
    
    init(dataManager: DataManager){
        self.dataManager = dataManager
    }
    
    
    //MARK: - Add direct debit
    func addDirectDebit(completionHandler: @escaping () -> ()){
        self.directDebits.append(directDebit)
        completionHandler()
    }
    
    
    
    
    //MARK: - Save new user data
    func saveNewUserData(){
        self.dataManager.spennyData = SpennyData(monthlyIncome: 0, savingsGoal: 0, directDebits: self.directDebits, transactions: self.transactions)
    }
    
    
    
}
