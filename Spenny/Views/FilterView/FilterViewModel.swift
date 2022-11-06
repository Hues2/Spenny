//
//  FilterViewModel.swift
//  Spenny
//
//  Created by Greg Ross on 06/11/2022.
//

import Foundation
import SwiftUI


class FilterViewModel: ObservableObject{
    
    @Published var filter: Binding<Filter>
    
    //MARK: - Filter Options
    @Published var transactionType: FilterOptions.TransactionTypeFilter = .all
    
    private var showFiltersSheet: Binding<Bool>
        
        
    init(filter: Binding<Filter>, showSheet: Binding<Bool>) {
        self.filter = filter
        self.transactionType = filter.wrappedValue.transactionType
        self.showFiltersSheet = showSheet
    }
    
    
    //MARK: - Apply Filters
    func applyFilters(){
        
        self.filter.wrappedValue.transactionType = self.transactionType
        
        withAnimation {
            self.showFiltersSheet.wrappedValue = false
        }
        
    }
    
    
    
    
    
}
