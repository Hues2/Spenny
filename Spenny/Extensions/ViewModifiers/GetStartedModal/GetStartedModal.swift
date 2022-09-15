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
    @State var isAddingTransaction: Bool = false
    
    init(dataManager: DataManager, showModal: Binding<Bool>){
        self._vm = StateObject(wrappedValue: ModalViewModel(dataManager: dataManager))
        self._showModal = showModal
    }
    
    var body: some View{
        
        VStack(alignment: .center, spacing: 0){
            // MARK: Button Row
            buttonRow
                .padding(.bottom, 5)
            
            ScrollView(showsIndicators: false){
                
                ScrollViewReader{ proxy in
                    
                    //MARK: Monthly Income Field
                    monthlyIncomeField
                    
                    //MARK: Savings Goal Field
                    savingsGoalField
                        .padding(.bottom, 20)
                    
                    // MARK: List Of Added Direct Debits
                    listOfTransactions
                    
                    // MARK: Add Direct Debit Button Text
                    addDirectDebitText
                    
                    //MARK: Optional Direct Debits Field
                    addTransactionsField
                        .id("proxy_addTransactionsField")
                    
                    // MARK: Save Info Button
                    saveToCoreDataButton
                        .onChange(of: isAddingTransaction) { newValue in
                            withAnimation(.spring()) {
                                proxy.scrollTo("proxy_addTransactionsField")
                            }
                        }
                }
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
        ModalTextField(title: "Monthly Income", placeholder: "£1250.00", amount: $vm.dataManager.monthlyIncome, isValidAmount: $vm.monthlyIncomeIsValid)
            .clipped()
    }
    
    private var savingsGoalField: some View{
        ModalTextField(title: "Savings Goal", placeholder: "£90.00", amount: $vm.dataManager.savingsGoal, isValidAmount: $vm.savingsGoalIsValid)
            .clipped()
    }
    
    private var listOfTransactions: some View{
        VStack{
            
            if !vm.dataManager.transactions.isEmpty{
                HStack{
                    Text("Transactions:")
                        .font(.title3)
                        .fontWeight(.semibold)
                        .foregroundColor(.accentColor)
                    
                    Spacer()
                }
                .padding(.horizontal)
            }
            
            ForEach(vm.dataManager.transactions){ transaction in
//            ForEach(ListOfTransactionTypes.listofFakeTransactions){ transaction in
                TransactionRow(transaction: transaction)
                    .transition(.move(edge: .leading))
                    .frame(maxWidth: .infinity)
                    .padding(.horizontal)
            }
        }
    }
    
    @ViewBuilder private var addDirectDebitText: some View{
        if !isAddingTransaction{
            HStack(spacing: 3){
                Image(systemName: "plus.circle")
                Text("Add a transaction")
                    .fontWeight(.light)
                Spacer()
            }
            .font(.subheadline)
            .foregroundColor(.accentColor)
            .containerShape(Rectangle())
            .onTapGesture {
                withAnimation {
                    isAddingTransaction = true
                }
            }
            .padding(.horizontal)
        }
    }
    
    @ViewBuilder private var addTransactionsField: some View{
        if isAddingTransaction{
            AddTransaction(dataManager: vm.dataManager, isAddingTransaction: $isAddingTransaction)
                .zIndex(1)
                .transition(.asymmetric(insertion: .move(edge: .leading), removal: .move(edge: .trailing)))
        }
    }
    
    @ViewBuilder private var saveToCoreDataButton: some View{
        if !isAddingTransaction{
            Button {
                print("\n Should check if the entered data is valid, and if it is, save it to core data \n")
            } label: {
                Text("Save")
                    .fontWeight(.bold)
                    .withSpennyButtonLabelStyle()
            }
            .transition(.asymmetric(insertion: .move(edge: .leading), removal: .move(edge: .trailing)))
            .buttonStyle(SpennyButtonStyle())
            .padding(.top, 10)
        }
        
        
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

