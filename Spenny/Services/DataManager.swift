//
//  DataManager.swift
//  Spenny
//
//  Created by Greg Ross on 12/09/2022.
//

import Foundation
import Combine
import SwiftUI


class DataManager: ObservableObject{
    
    @Published var spennyData: SpennyData? = nil
    
    @Published var monthlyIncome: String = ""
    @Published var savingsGoal: String = ""
    @Published var transactions: [Transaction] = []
    
    init(){
        
    }
    
    
    
    // MARK: Add Direct Debit | Transaction
    func addTransaction(transaction: Transaction){
        withAnimation {
            transactions.append(transaction)
        }
    }
    
    
    
}
