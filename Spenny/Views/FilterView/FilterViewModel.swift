//
//  FilterViewModel.swift
//  Spenny
//
//  Created by Greg Ross on 06/11/2022.
//

import Foundation
import SwiftUI


class FilterViewModel: ObservableObject{
    
    var transactions: Binding<[TransactionEntity]>
        
    init(transactions: Binding<[TransactionEntity]>) {
        self.transactions = transactions
    }
    
    
    
    
}
