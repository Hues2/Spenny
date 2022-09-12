//
//  GetStartedModal.swift
//  Spenny
//
//  Created by Greg Ross on 12/09/2022.
//

import SwiftUI


struct GetStartedModalViewModifier: ViewModifier{
    var dataManager: DataManager
    @Binding var showModal: Bool
    
    func body(content: Content) -> some View {
        ZStack(alignment: .bottom){
            content
                .zIndex(0)
            
            if showModal{
                GetStartedModal(dataManager: dataManager, showModal: $showModal)
                    .zIndex(1)
                    .transition(.move(edge: .bottom))
                    .animation(.spring(), value: showModal)
            }
        }
    }
}


struct GetStartedModal: View{
    @StateObject var vm: ModalViewModel
    
    @Binding var showModal: Bool
    @State private var offset = CGFloat.zero
    
    init(dataManager: DataManager, showModal: Binding<Bool>){
        self._vm = StateObject(wrappedValue: ModalViewModel(dataManager: dataManager))
        self._showModal = showModal
    }
    
    var body: some View{
        VStack(alignment: .center){
            // MARK: Button Row
            buttonRow
            
            //MARK: - Monthly Income
            monthlyIncomeField
            
            //MARK: - Savings Goal
            
            
            //MARK: - Optional Direct Debits
            
            Spacer()
        }
        .addModalModifiers(showModal: $showModal, offset: $offset, dismissModal: dismissModal)
        .onTapGesture {
            UIApplication.shared.dismissKeyboard()
        }
    }
    
}


extension GetStartedModal{
    //MARK: - Views
    private var buttonRow: some View{
        HStack{
            
            Spacer()
            
            Button {
                dismissModal()
            } label: {
                Circle()
                    .fill(RadialGradient(gradient: Gradient(colors: [.mint, .teal, .cyan, .blue]), center: .center, startRadius: 5, endRadius: 15))
                    .frame(width: 25, height: 25)
                    .mask {
                        Image(systemName: "x.circle.fill")
                            .font(.title2)
                    }
            }
            .padding(5)
        }
    }
    
    private var monthlyIncomeField: some View{
        VStack(alignment: .leading, spacing: 5) {
            Text("Monthly Income:")
                .font(.caption)
                .fontWeight(.semibold)
            TextField("E.g. £1250.00", text: $vm.monthlyIncome)
                .keyboardType(.decimalPad)
        }
        .frame(maxWidth: .infinity)
        .shadow(color: .black.opacity(0.3), radius: 2, x: 0, y: 0)
        .padding()
    }
    
    
    
    //MARK: - Functionality
    private func dismissModal(){
        withAnimation(.easeInOut) {
            showModal.toggle()
        }
    }
    
}

extension View{
    func withGetStartedModal(dataManager: DataManager, showModal: Binding<Bool>) -> some View{
        modifier(GetStartedModalViewModifier(dataManager: dataManager, showModal: showModal))
    }
}


