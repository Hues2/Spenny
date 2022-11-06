//
//  FilterViewModel.swift
//  Spenny
//
//  Created by Greg Ross on 06/11/2022.
//

import Foundation
import SwiftUI
import Combine


class FilterViewModel: ObservableObject{
    
    @Published var filter: Binding<Filter?>
        
    
    private var cancellables = Set<AnyCancellable>()
    
    init(filter: Binding<Filter?>) {
        self.filter = filter
        addSubscribers()
    }
    
    
    func addSubscribers(){
        self.$filter
            .sink { returnedFilter in
                print("\n Filter updated here too \n")
            }
            .store(in: &cancellables)
    }
    
    
    
    func filterByDirectDebit(){
        if let _ = self.filter.wrappedValue{
            self.filter.wrappedValue = nil
        } else {
            self.filter.wrappedValue = Filter(isDirectDebit: true)
        }
        
    }
    
    
    
    
}
