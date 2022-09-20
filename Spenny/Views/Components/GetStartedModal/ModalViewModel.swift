//
//  ModalViewModel.swift
//  Spenny
//
//  Created by Greg Ross on 12/09/2022.
//

import Foundation
import SwiftUI
import Combine

class ModalViewModel: ObservableObject{
    
    @Published var transactions: [TransactionEntity] = []
    
    @Published var monthlyIncomeIsValid: Bool = false
    @Published var savingsGoalIsValid: Bool = false
    
    
    var dataManager: DataManager
    
    private var cancellables = Set<AnyCancellable>()
    
    init(dataManager: DataManager){
        self.dataManager = dataManager
        addSubscribers()
    }
 
    
    
    func addSubscribers(){
        dataManager.$monthlyIncome
            .sink { [weak self] returnedIncome in
                guard let self = self else { return }
                // Validation of monthly income
                self.validateAmount(returnedAmount: returnedIncome, amountIsValid: &self.monthlyIncomeIsValid)
            }
            .store(in: &cancellables)
        
        
        dataManager.$savingsGoal
            .sink { [weak self] returnedSavingsGoal in
                guard let self = self else { return }
                // Validation of monthly income
                self.validateAmount(returnedAmount: returnedSavingsGoal, amountIsValid: &self.savingsGoalIsValid)
            }
            .store(in: &cancellables)
        
        
        dataManager.$transactions
            .sink { [weak self] returnedTransactions in
                self?.transactions = returnedTransactions
            }
            .store(in: &cancellables)
    }
    
    
    private func validateAmount(returnedAmount: Double?, amountIsValid: inout Bool){
        guard let amount = returnedAmount, amount > 0 else { amountIsValid = false; return}
        amountIsValid = true
    }
    
    //MARK: - Functionality
    func dismissModal(){
        withAnimation(.easeInOut) {
            dataManager.showModal.toggle()
        }
    }
    
    
}
