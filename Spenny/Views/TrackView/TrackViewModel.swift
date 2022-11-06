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
    
    
    
    @Published var filter: Filter?
    @Published var filteredTransactions: [TransactionEntity] = []
    
    
    

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
        //MARK: - DataManager Transactions Subscriber
        /// This subscriber runs when a transaction is added or deleted
        dataManager.$transactions
            .sink { [weak self] (returnedTransactions) in
                guard let self else { return }
                self.transactions = returnedTransactions
                
                /// Reset the filtered list, so that it contains the correct items before filtering
                withAnimation {
                    self.filteredTransactions = self.transactions
                }
                
                /// If the filter is not nil, then filter the new list of transactions
                if let filter = self.filter{
                    withAnimation {
                        self.filterTransactions(filter: filter)
                    }
                    
                }
                
                
                if self.tempSelectedType == .none{
                    self.sortTransactions(type: .date)
                } else{
                    self.sortTransactions(type: self.selectedSortingType)
                }
            }
            .store(in: &cancellables)
        
        
        //MARK: - DataManager Monthly Income Subscriber
        dataManager.$monthlyIncome
            .sink { [weak self] returnedIncome in
                guard let returnedIncome = returnedIncome else { return }
                self?.monthlyIncome = returnedIncome
            }
            .store(in: &cancellables)
        
        
        //MARK: - DataManager Savings Goal Income Subscriber
        dataManager.$savingsGoal
            .sink { [weak self] returnedSavings in
                guard let returnedSavings = returnedSavings else { return }
                self?.savingsGoal = returnedSavings
            }
            .store(in: &cancellables)
        
        
        //MARK: - TrackViewModel SelectedSortingType Subscriber
        self.$selectedSortingType
            .sink { [weak self] newSetValue in
                guard let self else { return }
                
                if self.tempSelectedType == .none{
                    self.tempSelectedType = self.selectedSortingType
                }
                
                else if newSetValue != self.tempSelectedType{
                    self.tempSelectedType = newSetValue
                    
                    withAnimation {
                        self.isShowingSortIcon = false
                        self.sortTransactions(type: self.tempSelectedType)
                    }
                    
                } else {
                    // If the new value is the same as the temp value, then just change the order of the sorting
                    withAnimation {
                        self.isShowingSortIcon = true
                        self.transactions = self.transactions.reversed()
                        self.filteredTransactions = self.filteredTransactions.reversed()
                    }
                }
            }
            .store(in: &cancellables)
        
        
        /// This subscriber will run when a filter is selected in the filter page --> When the filter is cahnged in the filter view model, this runs
        self.$filter
            .sink { [weak self] returnedFilter in
                guard let self else { return }
                
                guard let returnedFilter else {
                    /// Returned filter was nil, so remove all the filters that have been applied
                    withAnimation {
                        self.filteredTransactions = self.transactions
                    }
                    return
                }
                
                /// The filtered list need to be reset before applying all of the new filters
                self.filteredTransactions = self.transactions
                
                withAnimation {
                    self.filterTransactions(filter: returnedFilter)
                }
 
            }
            .store(in: &cancellables)
        
    }
    
    
    //MARK: - Filter Filtered Transactions list
    func filterTransactions(filter: Filter){
        /// This checks if the user has selected direct debit or standard transaction
        if let directDebitFilter = filter.isDirectDebit {
            switch directDebitFilter{
            case false:
                self.filteredTransactions = self.filteredTransactions.filter({!$0.isDirectDebit})
                
            case true:
                self.filteredTransactions = self.filteredTransactions.filter({$0.isDirectDebit})
            }
        }
        
        /*
         TODO: Check for the other types of filters
         */
        
        
    }
    
    
    //MARK: - Delete Transaction
    func deleteTransaction(index: IndexSet){
        transactions.remove(atOffsets: index)
        filteredTransactions.remove(atOffsets: index)
        dataManager.spennyEntity?.transactions = NSSet(array: transactions)
        dataManager.applyChanges()
    }
    
    //MARK: - Sort Transactions
    func sortTransactions(type: ListHeaderTitleType){
        switch type{
            
        case .category:
            self.transactions = self.transactions.sorted(by: {$0.typeTitle ?? "" < $1.typeTitle ?? ""})
            self.filteredTransactions = self.filteredTransactions.sorted(by: {$0.typeTitle ?? "" < $1.typeTitle ?? ""})
            
        case .title:
            self.transactions = self.transactions.sorted(by: {$0.title ?? "" < $01.title ?? ""})
            self.filteredTransactions = self.filteredTransactions.sorted(by: {$0.title ?? "" < $01.title ?? ""})
            
        case .date:
            self.transactions = self.transactions.sorted(by: {$0.date ?? Date() > $1.date ?? Date() })
            self.filteredTransactions = self.filteredTransactions.sorted(by: {$0.date ?? Date() > $1.date ?? Date() })
            
        case .amount:
            self.transactions = self.transactions.sorted(by: {$0.amount > $1.amount})
            self.filteredTransactions = self.filteredTransactions.sorted(by: {$0.amount > $1.amount})
            
        case .none:
            break
            
        }
    }
    
    
    //MARK: - Filter Direct Debits
    func filterDirectDebits(){
        transactions = transactions.filter({$0.isDirectDebit})
    }
    
    
    enum ListHeaderTitleType: String{
        case category, date, title, amount, none
    }
    
    
}
