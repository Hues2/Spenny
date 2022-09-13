//
//  AddTransactionViewModel.swift
//  Spenny
//
//  Created by Greg Ross on 13/09/2022.
//

import Foundation
import Combine

class AddTransactionViewModel: ObservableObject{
    @Published var transaction: Transaction = Transaction(title: "", amount: "", date: "", transactionType: TransactionType(iconName: "", title: "", colorHex: ""), isDirectDebit: false)
    @Published var selectedTransactionType: TransactionType = TransactionType(iconName: "", title: "", colorHex: "")
    
    var dataManager: DataManager
    
    init(dataManager: DataManager){
        self.dataManager = dataManager
    }
    
    
}
