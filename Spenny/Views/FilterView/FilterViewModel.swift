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
    @Published var listOfPaymentReasons: [String] = []
        
    private var showFiltersSheet: Binding<Bool>
    
        
    init(filter: Binding<Filter>, showSheet: Binding<Bool>) {
        self.filter = filter
        self.showFiltersSheet = showSheet
        self.transactionType = filter.wrappedValue.transactionType
        self.inOutType = filter.wrappedValue.inOutType
        self.listOfPaymentReasons = filter.wrappedValue.listOfPaymentReasons
    }
    
    
    
    //MARK: - Apply Filters
    func applyFilters(){
        
        self.filter.wrappedValue.transactionType = self.transactionType
        self.filter.wrappedValue.inOutType = self.inOutType
        self.filter.wrappedValue.listOfPaymentReasons = self.listOfPaymentReasons
        
        withAnimation {
            self.showFiltersSheet.wrappedValue = false
        }
    }
    
    
    // MARK: Transaction Type Pill Is Selected
    func paymentReasonIsSelected(iconName: String) -> Bool{
        return listOfPaymentReasons.contains(iconName)
    }
    
    
    // MARK: TransactionPill Tapped Action
    func pillTapped(iconName: String){
        if listOfPaymentReasons.contains(iconName){
            let index = listOfPaymentReasons.firstIndex(of: iconName)
            guard let index else { return }
            listOfPaymentReasons.remove(at: index)
        }
        else{
            listOfPaymentReasons.append(iconName)
        }
    }
    
 
}
