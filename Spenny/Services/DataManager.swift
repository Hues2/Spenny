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
    
    @Published var showModal: Bool = false
    @Published var isNewUser: Bool = true
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
                guard let spennyEntity = returnedSpennyEntity, let self = self else { print("\n [DATA MANAGER] --> Returned spenny data was nil. \n"); return }
                
                // The was a saved spenny entity in core data, so now it populates everything with that data
                print("\n Caught published spenny entity. Populating values now. \n")
                
                
                // This is to dismiss the modal
                DispatchQueue.main.async {
                    withAnimation {
                        self.spennyEntity = spennyEntity
                        self.monthlyIncome = spennyEntity.monthlyIncome
                        self.savingsGoal = spennyEntity.savingsGoal
                        self.transactions = spennyEntity.transactions?.allObjects as! [TransactionEntity]
                        self.isNewUser = false
                        self.showModal = false
                    }
                }
                
                
            }
            .store(in: &cancellables)

    }
    
    
    //MARK: - Add Spenny Data
    func addSpennyData() {
        guard let monthlyIncome = monthlyIncome, let savingsGoal = savingsGoal else { print("\n Monthly Goal and/or Savings Goal is/are empty \n"); return }
        let spennyEntity = SpennyEntity(context: coreDataManager.container.viewContext)
        spennyEntity.monthlyIncome = monthlyIncome
        spennyEntity.savingsGoal = savingsGoal
        spennyEntity.transactions = NSSet(array: self.transactions)
        coreDataManager.applyChanges()
    }
    
    
    
    // MARK: Add Direct Debit | Transaction
    func addTransaction(transaction: TransactionEntity){
        if isNewUser{
            transactions.append(transaction)
        } else {
            spennyEntity?.transactions?.adding(transaction)
            coreDataManager.applyChanges()
        }
        
    }
    
    
    
}
