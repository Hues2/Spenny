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
    }
    
    
    var body: some View {
        VStack(alignment: .center, spacing: 15){
            
            //MARK: - Page Title
            HStack{
                Text("Select Filters:")
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(.accentColor)
                
                Spacer()
            }
            .padding(.bottom, 20)
            
            //MARK: - Transaction Type Filter
            transactionTypeFilter
            Divider()
            
            //MARK: - Pay In/Out Filter
            inOutTypeFilter
            Divider()
            
            transactionTypeScrollView
            Divider()
            
            Spacer()
            
            applyFiltersButton

            
        }
        .padding()
    }
}


extension FilterView{
    
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
                        FilterTransactionTypePill(typeTitle: transactionType.typeTitle, iconName: transactionType.iconName ?? "", hexColor: transactionType.hexColor, isHighlited: vm.paymentReasonIsSelected(iconName: transactionType.iconName ?? ""))
                            .onTapGesture {
                                vm.pillTapped(iconName: transactionType.iconName ?? "")
                            }
                    }
                }
            }
        }
        .padding(.top, 20)
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

