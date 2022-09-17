//
//  TrackViewModel.swift
//  Spenny
//
//  Created by Greg Ross on 17/09/2022.
//

import Foundation


class TrackViewModel: ObservableObject{
    
    
    
    var dataManager: DataManager
    
    init(dataManager: DataManager) {
        self.dataManager = dataManager
    }
    
    
}
