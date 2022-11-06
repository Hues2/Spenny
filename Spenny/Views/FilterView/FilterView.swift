//
//  FilterView.swift
//  Spenny
//
//  Created by Greg Ross on 06/11/2022.
//

import SwiftUI

struct FilterView: View {
    
    @StateObject var vm: FilterViewModel
    
    init(filter: Binding<Filter?>) {
        self._vm = StateObject(wrappedValue: FilterViewModel(filter: filter))
    }
    
    
    var body: some View {
        VStack{
            Text("Filter View")
                .onTapGesture {
                    vm.filterByDirectDebit()
                }
        }
    }
}

