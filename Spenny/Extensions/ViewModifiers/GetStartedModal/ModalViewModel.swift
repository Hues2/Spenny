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
    
    
    let dataManager: DataManager
    
    init(dataManager: DataManager){
        self.dataManager = dataManager
    }
    
    
    
}
