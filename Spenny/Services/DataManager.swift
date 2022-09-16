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
    
    @Published var spennyEntity: SpennyEntity? = nil
    
    @Published var monthlyIncome: Double? = nil
    @Published var savingsGoal: Double? = nil
    @Published var transactions: [TransactionEntity] = []
    
    @Published var isLoadingOrSavingData: Bool = false
    
    
    let coreDataManager: CoreDataManager
    
    private var cancellables = Set<AnyCancellable>()
    
    init(){
        coreDataManager = CoreDataManager()
        addSubscribers()
        coreDataManager.getSpennyData()
    }
    
    
    // MARK: Add Subscribers
    private func addSubscribers(){
        print("\n Adding subs \n")
        coreDataManager.spennyDataPublisher
            .sink { completion in
                switch completion{
                case .finished:
                    break
                case .failure(let error):
                    print("\n [DATA MANAGER] --> Error in spennyDataPubliher. Error: \(error.localizedDescription) \n")
                }
            } receiveValue: { [weak self] returnedSpennyEntity in
                guard let spennyEntity = returnedSpennyEntity else { print("\n [DATA MANAGER] --> Returned spenny data was nil. \n"); return }
                print("\n Got spenny data on launch \n")
                self?.spennyEntity = spennyEntity
                self?.monthlyIncome = spennyEntity.monthlyIncome
            }
            .store(in: &cancellables)

    }
    
    
    func addSpennyData() {
        guard let monthlyIncome = monthlyIncome, let savingsGoal = savingsGoal else { print("\n Monthly Goal and/or Savings Goal is/are empty \n"); return }
        spennyEntity?.monthlyIncome = monthlyIncome
        spennyEntity?.savingsGoal = savingsGoal
        coreDataManager.applyChanges()
    }
    
    
    
    // MARK: Add Direct Debit | Transaction
    func addTransaction(transaction: TransactionEntity){
            transactions.append(transaction)
    }
    
    
    
}
