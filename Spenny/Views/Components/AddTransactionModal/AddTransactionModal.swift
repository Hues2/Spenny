//
//  AddTransactionModal.swift
//  Spenny
//
//  Created by Greg Ross on 20/09/2022.
//

import SwiftUI

struct AddTransactionModal: View {
    @StateObject var vm: ModalViewModel
    
    @State private var offset = CGFloat.zero
    @State var isAddingTransaction: Bool = true
    
    init(dataManager: DataManager){
        self._vm = StateObject(wrappedValue: ModalViewModel(dataManager: dataManager))
    }
    
    
    var body: some View {
        VStack(alignment: .center, spacing: 0){
            // MARK: Button Row
            buttonRow
            ScrollView{
                
                // MARK: Add Transaction Field
                addTransactionsField
            }
            
        }
        .addModalModifiers(showModal: $vm.dataManager.showModal, offset: $offset, dismissModal: vm.dismissModal)
    }
}


extension AddTransactionModal{
    
    private var buttonRow: some View{
        HStack{
            Spacer()
            
            Button {
                vm.dismissModal()
            } label: {
                Circle()
                    .fill(RadialGradient(gradient: Gradient(colors: [.mint, .teal, .cyan, .blue]), center: .center, startRadius: 5, endRadius: 15))
                    .frame(width: 25, height: 25)
                    .mask {
                        Image(systemName: "x.circle.fill")
                            .font(.title2)
                    }
            }
            .padding(.horizontal, 5)
            .padding(.top, 5)
            .padding(.bottom, 10)
        }
        .contentShape(Rectangle())
    }
    
    @ViewBuilder private var addTransactionsField: some View{
        if isAddingTransaction{
            AddTransaction(dataManager: vm.dataManager, isAddingTransaction: $isAddingTransaction, isNewUser: false)
                .zIndex(1)
                .transition(.move(edge: .bottom))
        }
    }
    
}
