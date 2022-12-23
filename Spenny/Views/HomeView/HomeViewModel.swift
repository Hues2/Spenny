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
    
    var dataManager : DataManager
    
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
                DispatchQueue.main.async {
                    self?.showInitialProgressView = false
                }                
            }
            .store(in: &cancellables)
        
        /// This is for when the spenny entity gets set to nil, when the customer clicks on the save button in the Track View
        dataManager.$spennyEntity
            .dropFirst()
            .sink { returnedSpennyEntity in
                self.showInitialProgressView = true
                self.showInitialProgressView = false
            }
            .store(in: &cancellables)
    }
    
    
}
