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
    @Published var inOutType: FilterOptions.InOutTypeFilter = .all
    
    private var showFiltersSheet: Binding<Bool>
        
        
    init(filter: Binding<Filter>, showSheet: Binding<Bool>) {
        self.filter = filter
        self.showFiltersSheet = showSheet
        self.transactionType = filter.wrappedValue.transactionType
        self.inOutType = filter.wrappedValue.inOutType
        
    }
    
    
    //MARK: - Apply Filters
    func applyFilters(){
        
        self.filter.wrappedValue.transactionType = self.transactionType
        self.filter.wrappedValue.inOutType = self.inOutType
        
        withAnimation {
            self.showFiltersSheet.wrappedValue = false
        }
        
    }
    
 
}
