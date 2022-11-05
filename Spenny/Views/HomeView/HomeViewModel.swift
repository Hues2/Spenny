//
//  HomeViewModel.swift
//  Spenny
//
//  Created by Greg Ross on 11/09/2022.
//

import Foundation
import SwiftUI
import Combine

class HomeViewModel: ObservableObject{
    
    @Published var showInitialProgressView: Bool = true
    
    
    let dataManager : DataManager
    
    private var cancellables = Set<AnyCancellable>()
    
    init(dataManager: DataManager){
        self.dataManager = dataManager
        addSubbscribers()
        self.dataManager.coreDataManager.getSpennyData()
    }
    
    
    //MARK: - Add Subscribers
    private func addSubbscribers() {
        
        dataManager.spennyEntityPublisher
            .sink { [weak self] _ in
                self?.showInitialProgressView = false
            }
            .store(in: &cancellables)
        
        
    }
    
    
}
