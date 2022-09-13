//
//  ModalViewModel.swift
//  Spenny
//
//  Created by Greg Ross on 12/09/2022.
//

import Foundation
import Combine

class ModalViewModel: ObservableObject{
    @Published var monthlyIncome: String = ""
    @Published var savingsGoal: String = ""
    @Published var directDebits: [Transaction] = []
    private let transactions: [Transaction] = [] // --> This will be empty when the user enters their data for the first time
    
    
    let dataManager: DataManager
    
    init(dataManager: DataManager){
        self.dataManager = dataManager
    }
    
    
    
}
