//
//  SavedMonthsViewModel.swift
//  Spenny
//
//  Created by Greg Ross on 20/11/2022.
//

import Foundation
import Combine
import SwiftUI



class SavedMonthsViewModel: ObservableObject{
    
    @Published var savedSpennyEntities : [SpennyEntity?]
    
    var validSavedEntities: [SpennyEntity]{
        return savedSpennyEntities.compactMap({$0})
    }
    
    var dataManager: DataManager
    
    
    private var cancellables = Set<AnyCancellable>()
    
    init(dataManager: DataManager) {
        self.dataManager = dataManager
        self.savedSpennyEntities = dataManager.savedSpennyEntities
        addSubscribers()
    }
    
    //MARK: - Add Subscribers
    private func addSubscribers(){
        self.dataManager.$savedSpennyEntities
            .sink { [weak self] returnedSavedSpennyEntities in
                guard let self else { return }
                self.savedSpennyEntities = returnedSavedSpennyEntities
            }
            .store(in: &cancellables)
    }
    
    
    // MARK: Get Section Header
    func getDates(entity: SpennyEntity) -> String{
        
        guard let transactions = entity.transactions?.allObjects as? [TransactionEntity] else {
            return "Dates Unknown"
        }
        
        let earliestDate = transactions.sorted(by: {$0.date ?? Date() < $1.date ?? Date()}).first?.date
        let latestDate = transactions.sorted(by: {$0.date ?? Date() < $1.date ?? Date()}).last?.date
            
        if let earliestDate, let latestDate{
            return "\(earliestDate.toString()) - \(latestDate.toString())"
        }
        else if let earliestDate {
            return "\(earliestDate.toString())"
        }
        
        else if let latestDate{
            return "\(latestDate.toString())"
        }
        
        else{
            return "Unknown Dates"
        }
    }

    
    func getAmountSaved(entity: SpennyEntity) -> Double{
        guard let transactions = entity.transactions?.allObjects as? [TransactionEntity] else {
            return 0
        }
        
        let values = transactions.map({$0.amount})
        let total = values.reduce(0, +)
        let amountLeft = entity.monthlyIncome + total
        return amountLeft
        
    }
}
