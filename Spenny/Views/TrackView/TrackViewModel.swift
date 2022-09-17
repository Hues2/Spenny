//
//  TrackViewModel.swift
//  Spenny
//
//  Created by Greg Ross on 17/09/2022.
//

import Foundation


class TrackViewModel: ObservableObject{

    var dataManager: DataManager
    
    var transactionsTotal: Double{
        let values = dataManager.transactions.map({$0.amount})
        return values.reduce(0, +)
    }
    
    var remainingAmount: Double{
        return (dataManager.monthlyIncome ?? 0) + transactionsTotal
    }
    
    
    init(dataManager: DataManager) {
        self.dataManager = dataManager
    }
    
    
}
