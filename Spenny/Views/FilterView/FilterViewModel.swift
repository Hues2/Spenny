//
//  FilterViewModel.swift
//  Spenny
//
//  Created by Greg Ross on 06/11/2022.
//

import Foundation
import SwiftUI


class FilterViewModel: ObservableObject{
    
    @Published var filter: Binding<Filter?>
    
    @Published var transactionType: TransactionTypeFilter = .all
        
        
    init(filter: Binding<Filter?>) {
        self.filter = filter
    }
    
    
    //MARK: - Apply Filters
    func applyFilters(){
        
        
        
    }
    
    
    
    enum TransactionTypeFilter{
        case directDebit, standardTransaction, all
    }
    
}
