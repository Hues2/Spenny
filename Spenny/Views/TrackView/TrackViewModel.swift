//
//  TrackViewModel.swift
//  Spenny
//
//  Created by Greg Ross on 17/09/2022.
//

import Foundation
import Combine
import SwiftUI


class TrackViewModel: ObservableObject{
    
    @Published var monthlyIncome: Double = 0.0
    @Published var savingsGoal: Double = 0.0
    @Published var transactions: [TransactionEntity] = []
    
    @Published var showOptionsSheet: Bool = false
    
    @Published var selectedSortingType: ListHeaderTitleType = .date
    private var tempSelectedType: ListHeaderTitleType = .none
    @Published var isShowingSortIcon: Bool = false
    

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
                guard let self else { return }
                
                self.transactions = returnedTransactions
                
                if self.tempSelectedType == .none{
                    self.sortTransactions(type: .date)
                } else{
                    self.sortTransactions(type: self.selectedSortingType)
                }
                
                
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
        
        self.$selectedSortingType
            .sink { [weak self] newSetValue in
                guard let self else { return }
                
                if self.tempSelectedType == .none{
                    self.tempSelectedType = self.selectedSortingType
                }
                
                else if newSetValue != self.tempSelectedType{
                    // If the new value is different to the tempValue then just sort the transactions by the new selected type, and set the temp value as the new value
                    self.tempSelectedType = newSetValue
                    
                    // And now sort
                    withAnimation {
                        self.isShowingSortIcon = false
                        self.sortTransactions(type: self.tempSelectedType)
                    }
                    
                    
                } else {
                    // If the new value is the same as the temp value, then just change the order of the sorting
                    withAnimation {
                        self.isShowingSortIcon = true
                        self.transactions = self.transactions.reversed()
                    }
                }
                
                
            }
        
            .store(in: &cancellables)
    }
    
    
    func deleteTransaction(index: IndexSet){
        transactions.remove(atOffsets: index)
        dataManager.spennyEntity?.transactions = NSSet(array: transactions)
        dataManager.applyChanges()
    }
    
    
    func sortTransactions(type: ListHeaderTitleType){
        switch type{
            
        case .category:
            self.transactions = self.transactions.sorted(by: {$0.typeTitle ?? "" < $1.typeTitle ?? ""})
            
        case .title:
            self.transactions = self.transactions.sorted(by: {$0.title ?? "" < $01.title ?? ""})
            
        case .date:
            self.transactions = self.transactions.sorted(by: {$0.date ?? Date() > $1.date ?? Date() })
            
        case .amount:
            self.transactions = self.transactions.sorted(by: {$0.amount > $1.amount})
            
        case .none:
            break
            
        }
    }
    
    
    enum ListHeaderTitleType: String{
        case category, date, title, amount, none
    }
    
    
}
