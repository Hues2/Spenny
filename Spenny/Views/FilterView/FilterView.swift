//
//  FilterView.swift
//  Spenny
//
//  Created by Greg Ross on 06/11/2022.
//

import SwiftUI

struct FilterView: View {
    
    @StateObject var vm: FilterViewModel
    
    @Namespace private var namespace
    
    init(filter: Binding<Filter>, showSheet: Binding<Bool>) {
        self._vm = StateObject(wrappedValue: FilterViewModel(filter: filter, showSheet: showSheet))
        UITableView.appearance().backgroundColor = .green
    }
    
    
    var body: some View {
        
        List{
            // MARK: Payment occurrence
            section1
            
            // MARK: Pay In/Out
            section2
            
            // MARK: Transaction Type
            section3
        }
        .listStyle(.insetGrouped)
        
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .cornerRadius(10)
        .padding(.horizontal, 10)
        .padding(.vertical, 20)
        
        .shadow(color: .black.opacity(0.4), radius: 3, x: 0, y: 0)
        
        Spacer()
        
        applyFiltersButton
 
    }
}


extension FilterView{
    
    private var section1: some View{
        Section {
            VStack{
                transactionTypeFilter
                Divider()
            }
        } header: {
            Text("Payment Occurrence:")
        }
        .listRowBackground(Color.clear)
        .listRowInsets(EdgeInsets(top: 15, leading: 5, bottom: 5, trailing: 5))
    }
    
    private var section2: some View{
        Section {
            VStack{
                inOutTypeFilter
                Divider()
            }
        } header: {
            Text("Paid In/Out:")
        }
        .listRowBackground(Color.clear)
        .listRowInsets(EdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5))
    }
    
    private var section3: some View{
        Section {
            VStack(spacing: 5){
                HStack{
                    Text("Select:")
                        .font(.footnote)
                        .fontWeight(.semibold)
                        .foregroundColor(.accentColor)

                    transactionTypeScrollView
                }
                .padding(.vertical, 5)

                HStack{
                    Text("Active:")
                        .font(.footnote)
                        .fontWeight(.semibold)
                        .foregroundColor(.accentColor)

                    activeTransactionTypeScrollView
                }
                .padding(.vertical, 5)
                
                Divider()
            }
        } header: {
            Text("Transaction Type:")
        }
        .listRowBackground(Color.clear)
        .listRowInsets(EdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5))
    }
    
    private var transactionTypeFilter: some View{
        
        HStack{
            
            transactionType(title: "Both", type: .all)
            
            Spacer()
            
            transactionType(title: "Direct Debit", type: .directDebit)
            
            Spacer()
            
            transactionType(title: "Standard", type: .standardTransaction)
            
        }
    }
    
    private func transactionType(title: String, type: FilterOptions.TransactionTypeFilter) -> some View{
        ZStack{
            if vm.transactionType == type{
                RoundedRectangle(cornerRadius: 15)
                    .fill(
                        LinearGradient(gradient: Gradient(colors: [.mint, .teal, .cyan, .blue]), startPoint: .leading, endPoint: .trailing)
                    )
                    .cornerRadius(15)
                    .matchedGeometryEffect(id: "transactionType", in: namespace)
                    .frame(maxWidth: 120)
            }
            
            Text(title)
                .font(.body)
                .fontWeight(.bold)
                .foregroundColor(vm.transactionType == type ? .white : .accentColor)
                .opacity(vm.transactionType == type ? 1 : 0.4)
                .padding(.vertical, 5)
        }
        .frame(height: 40)
        .frame(maxWidth: 120)
        .onTapGesture {
            withAnimation {
                vm.transactionType = type
            }
        }
    }
    
    private var inOutTypeFilter: some View{
        
        HStack{
            
            inOutType(title: "Both", type: .all)
            
            Spacer()
            
            inOutType(title: "Income", type: .payIn)
            
            Spacer()
            
            inOutType(title: "Outgoing", type: .payOut)
            
        }
    }
    
    private func inOutType(title: String, type: FilterOptions.InOutTypeFilter) -> some View{
        ZStack{
            if vm.inOutType == type{
                RoundedRectangle(cornerRadius: 15)
                    .fill(
                        LinearGradient(gradient: Gradient(colors: [.mint, .teal, .cyan, .blue]), startPoint: .leading, endPoint: .trailing)
                    )
                    .cornerRadius(15)
                    .matchedGeometryEffect(id: "inOutFilter", in: namespace)
                    .frame(maxWidth: 120)
            }
            
            Text(title)
                .font(.body)
                .fontWeight(.bold)
                .foregroundColor(vm.inOutType == type ? .white : .accentColor)
                .opacity(vm.inOutType == type ? 1 : 0.4)
                .padding(.vertical, 5)
        }
        .frame(height: 40)
        .frame(maxWidth: 120)
        .onTapGesture {
            withAnimation {
                vm.inOutType = type
            }
        }
    }
    
    private var transactionTypeScrollView: some View{
        VStack(alignment: .leading){
            ScrollView(.horizontal ,showsIndicators: false) {
                HStack{
                    ForEach(ListOfTransactionTypes.transactionTypes){ transactionType in
                        if !vm.paymentReasonIsSelected(iconName: transactionType.iconName ?? ""){
                            
                            FilterTransactionTypePill(typeTitle: transactionType.typeTitle, iconName: transactionType.iconName ?? "", hexColor: transactionType.hexColor, isSelected: vm.paymentReasonIsSelected(iconName: transactionType.iconName ?? ""), namespace: namespace)
                                .onTapGesture {
                                    withAnimation{
                                        vm.pillTapped(iconName: transactionType.iconName ?? "")
                                    }
                                }
                        }
                    }
                }
            }
            .cornerRadius(30)
        }
    }
    
    private var activeTransactionTypeScrollView: some View{
        VStack(alignment: .leading){
            ScrollView(.horizontal ,showsIndicators: false) {
                HStack{
                    ForEach(ListOfTransactionTypes.transactionTypes){ transactionType in
                        if vm.paymentReasonIsSelected(iconName: transactionType.iconName ?? ""){
                            
                            FilterTransactionTypePill(typeTitle: transactionType.typeTitle, iconName: transactionType.iconName ?? "", hexColor: transactionType.hexColor, isSelected: vm.paymentReasonIsSelected(iconName: transactionType.iconName ?? ""), namespace: namespace)
                                .onTapGesture {
                                    withAnimation {
                                        vm.pillTapped(iconName: transactionType.iconName ?? "")
                                    }
                                }
                        }
                        
                    }
                }
            }
            .cornerRadius(30)
        }
    }
    
        
    private var applyFiltersButton: some View{
        Button {
            withAnimation {
                vm.applyFilters()
            }
        } label: {
            Text("Apply")
                .fontWeight(.bold)
                .withSpennyButtonLabelStyle()
        }
        .buttonStyle(SpennyButtonStyle())
        .padding(.top, 10)

    }
    
}

