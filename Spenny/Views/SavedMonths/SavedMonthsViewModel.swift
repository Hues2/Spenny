//
//  SavedMonthsViewModel.swift
//  Spenny
//
//  Created by Greg Ross on 20/11/2022.
//

import Foundation
import Combine



class SavedMonthsViewModel: ObservableObject{
    
    @Published var savedSpennyEntities = [SpennyEntity]()
    
    var dataManager: DataManager
    
    
    private var cancellables = Set<AnyCancellable>()
    
    init(dataManager: DataManager) {
        self.dataManager = dataManager
        addSubscribers()
    }
    
    //MARK: - Add Subscribers
    private func addSubscribers(){
        self.dataManager.$savedSpennyEntities
            .sink { completion in
                switch completion{
                case .failure(let error):
                    print("\n \(error.localizedDescription) \n")
                    
                case .finished:
                    break
                }
            } receiveValue: { [weak self] returnedSavedSpennyEntities in
                guard let self else { return }
                guard let returnedSavedSpennyEntities else { return }
                
                
            }

    }
    
}
