//
//  FilterView.swift
//  Spenny
//
//  Created by Greg Ross on 06/11/2022.
//

import SwiftUI

struct FilterView: View {
    
    @StateObject var vm: FilterViewModel
    
    init(transactions: Binding<[TransactionEntity]>) {
        self._vm = StateObject(wrappedValue: FilterViewModel(transactions: transactions))
    }
    
    
    var body: some View {
        VStack{
            Text("Filter View")
                .onTapGesture {
                    vm.filter()
                }
        }
    }
}

