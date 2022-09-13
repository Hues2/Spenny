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
        
        VStack(alignment: .center, spacing: 0){
            // MARK: Button Row
            buttonRow
                .padding(.bottom, 5)
                
                
            
            ScrollView{
            //MARK: Monthly Income Field
            monthlyIncomeField
                .padding(.bottom, 5)
            
            //MARK: Savings Goal Field
            savingsGoal
            
            //MARK: Optional Direct Debits Field
            
            
            // MARK: Save Info Button
            saveToCoreDataButton
            
            Spacer()
            }
        }
        .addModalModifiers(showModal: $showModal, offset: $offset, dismissModal: dismissModal)
        
        
    }
    
}


extension GetStartedModal{
    //MARK: Views
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
        .contentShape(Rectangle())
    }
    
    private var monthlyIncomeField: some View{
        ModalTextField(title: "Monthly Income", placeholder: "£1250.00", amount: $vm.monthlyIncome)
    }
    
    private var savingsGoal: some View{
        ModalTextField(title: "Savings Goal", placeholder: "£90.00", amount: $vm.savingsGoal)
    }
    
    private var directDebits: some View{
        
    }
    
    private var saveToCoreDataButton: some View{
        Button {
            print("\n Should check if the entered data is valid, and if it is, save it to core data \n")
        } label: {
            Text("Save")
                .fontWeight(.bold)
                .withSpennyButtonLabelStyle()
        }
        .buttonStyle(SpennyButtonStyle() )

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


