//
//  HomeViewModel.swift
//  Spenny
//
//  Created by Greg Ross on 11/09/2022.
//

import Foundation
import SwiftUI

class HomeViewModel: ObservableObject{
    
    @Published var showInitialProgressView: Bool = true
    
    init(){
        // Get the remaining amount from core data
        
        
        // This replicates the fetching of the data from core data
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.showInitialProgressView = false
        }
    }
    
    
}


/*
 - Get the remaining amount for the month from core data
 */
