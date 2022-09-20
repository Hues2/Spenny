//
//  TrackViewModel.swift
//  Spenny
//
//  Created by Greg Ross on 17/09/2022.
//

import Foundation
import Combine



class TrackViewModel: ObservableObject{
    
    @Published var monthlyIncome: Double = 0.0
    @Published var savingsGoal: Double = 0.0
    @Published var transactions: [TransactionEntity] = []
    

    var dataManager: DataManager
    
    var transactionsTotal: Double{
        let values = transactions.map({$0.amount})
        return values.reduce(0, +)
    }
    
    var remainingAmount: Double{
        return (monthlyIncome) + transactionsTotal
    }
    
    
    private var cancellables = Set<AnyCancellable>()
    
    init(dataManager: DataManager) {
        self.dataManager = dataManager
        addSubscribers()
    }
    
    
    
    
    private func addSubscribers(){
        dataManager.$transactions
            .sink { [weak self] (returnedTransactions) in
                self?.transactions = returnedTransactions
            }
            .store(in: &cancellables)
        
        dataManager.$monthlyIncome
            .sink { [weak self] returnedIncome in
                guard let returnedIncome = returnedIncome else { return }
                self?.monthlyIncome = returnedIncome
            }
            .store(in: &cancellables)
        
        dataManager.$savingsGoal
            .sink { [weak self] returnedSavings in
                guard let returnedSavings = returnedSavings else { return }
                self?.savingsGoal = returnedSavings
            }
            .store(in: &cancellables)
    }
    
    
    func deleteTransaction(index: IndexSet){
        transactions.remove(atOffsets: index)
        dataManager.spennyEntity?.transactions = NSSet(array: transactions)
        dataManager.applyChanges()
    }
    
}
