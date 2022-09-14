//
//  DataManager.swift
//  Spenny
//
//  Created by Greg Ross on 12/09/2022.
//

import Foundation
import Combine


class DataManager: ObservableObject{
    
    @Published var spennyData: SpennyData? = nil
    
    @Published var monthlyIncome: String = ""
    @Published var savingsGoal: String = ""
    @Published var directDebits: [Transaction] = []
    @Published var transactions: [Transaction] = []

    init(){
        
    }
    
    
    
    // MARK: Add Direct Debit | Transaction
    func addTransaction(transaction: Transaction){
        if transaction.isDirectDebit{
            directDebits.append(transaction)
            print("\n [DATA MANAGER] --> Direct Debit added! Direct Debits list: \(directDebits) \n")
        } else {
            transactions.append(transaction)
            print("\n [DATA MANAGER] --> Transaction added! Direct Debits list: \(transactions) \n")
        }
        
    }
    
    
    
}
