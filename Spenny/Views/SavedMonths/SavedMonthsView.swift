//
//  SavedMonthsView.swift
//  Spenny
//
//  Created by Greg Ross on 20/11/2022.
//

import SwiftUI


struct SavedMonthsView: View {
    
    @StateObject private var vm: SavedMonthsViewModel
    
    init(dataManager: DataManager){
        self._vm = StateObject(wrappedValue: SavedMonthsViewModel(dataManager: dataManager))
    }
    
    var body: some View {
        VStack{
            Text("\(vm.savedSpennyEntities.count)")
        }
    }
}
