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
    
    var spennyEntityPublisher = PassthroughSubject<Result<SpennyEntity, Error>, Never>()
    @Published var spennyEntity: SpennyEntity? = nil
    
    @Published var monthlyIncome: Double? = nil
    @Published var savingsGoal: Double? = nil
    @Published var transactions: [TransactionEntity] = []
    
    @Published var showModal: Bool = false
    @Published var isNewUser: Bool = true
    @Published var isLoadingOrSavingData: Bool = false
    
    
    
    let coreDataManager: CoreDataProtocol
    
    private var cancellables = Set<AnyCancellable>()
    
    init(coreDataManager: CoreDataProtocol){
        self.coreDataManager = coreDataManager
        addSubscribers()
//        coreDataManager.getSpennyData()
    }
    
    
    // MARK: Add Subscribers
    private func addSubscribers(){
        coreDataManager.spennyDataPublisher
            .sink { completion in
                switch completion{
                case .finished:
                    break
                case .failure(let error):
                    print("\n [DATA MANAGER] --> Error in spennyDataPubliher. Error: \(error.localizedDescription) \n")
                }
            } receiveValue: { [weak self] returnedResult in
                guard let self else { return }
                
                switch returnedResult{
                case .failure(let error):
                    self.spennyEntityPublisher.send(.failure(error))
                    
                case .success(let spennyEntity):
                    guard let spennyEntity else {
                        self.spennyEntityPublisher.send(.failure(CustomError.spennyEntityWasNil))
                        return
                    }
                    
                    // The was a saved spenny entity in core data, so now it populates everything with that data
                                    
                    DispatchQueue.main.async { [weak self] in
                        guard let self else { return }
                        
                        withAnimation {
                            self.spennyEntity = spennyEntity
                            self.monthlyIncome = spennyEntity.monthlyIncome
                            self.savingsGoal = spennyEntity.savingsGoal
                            
                            if let transactions = spennyEntity.transactions?.allObjects as? [TransactionEntity]{
                                self.transactions = transactions
                            }
                            
                            self.isNewUser = false
                            self.showModal = false
                            self.spennyEntityPublisher.send(.success(spennyEntity))
                        }
                    }
                }
  
            }
            .store(in: &cancellables)

    }
    
    
    //MARK: - Add Spenny Data --> This is used when creating data for a new month / new user
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
    
    
    // MARK: Apply Changes In Core Data
    func applyChanges(){
        coreDataManager.applyChanges()
    }
    
    
    
}
