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
    
    @Published var monthlyIncome: Double? = nil
    @Published var savingsGoal: Double? = nil
    @Published var transactions: [Transaction] = []
    
    @Published var isLoadingOrSavingData: Bool = false
    
    
    private let coreDataManager = CoreDataManager()
    
    private var cancellables = Set<AnyCancellable>()
    
    init(){
        addSubscribers()
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
            } receiveValue: { [weak self] returnedSpennyData in
                guard let spennyData = returnedSpennyData else { print("\n [DATA MANAGER] --> Returned spenny data was nil. \n"); return }
                self?.spennyData = spennyData
            }
            .store(in: &cancellables )

    }
    
    
    func addSpennyData(){
        guard let monthlyIncome = monthlyIncome, let savingsGoal = savingsGoal else { print("\n Monthly Goal and/or Savings Goal is/are empty \n"); return }
        var spennyData = SpennyData(monthlyIncome: monthlyIncome, savingsGoal: savingsGoal, transactions: transactions)
        coreDataManager.addSpennyData(spennyData: spennyData)
    }
    
    
    
    // MARK: Add Direct Debit | Transaction
    func addTransaction(transaction: Transaction){
            transactions.append(transaction)
    }
    
    
    
}
