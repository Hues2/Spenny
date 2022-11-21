//
//  SavedMonthsViewModel.swift
//  Spenny
//
//  Created by Greg Ross on 20/11/2022.
//

import Foundation
import Combine



class SavedMonthsViewModel: ObservableObject{
    
    @Published var savedSpennyEntities : [SpennyEntity?]
    
    var dataManager: DataManager
    
    
    private var cancellables = Set<AnyCancellable>()
    
    init(dataManager: DataManager) {
        self.dataManager = dataManager
        self.savedSpennyEntities = dataManager.savedSpennyEntities
        addSubscribers()
    }
    
    //MARK: - Add Subscribers
    private func addSubscribers(){
        self.dataManager.$savedSpennyEntities
            .sink { [weak self] returnedSavedSpennyEntities in
                guard let self else { return }
                self.savedSpennyEntities = returnedSavedSpennyEntities
            }
            .store(in: &cancellables)
    }
    
}
