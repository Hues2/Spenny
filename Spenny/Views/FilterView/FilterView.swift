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
    
    init(filter: Binding<Filter?>) {
        self._vm = StateObject(wrappedValue: FilterViewModel(filter: filter))
    }
    
    
    var body: some View {
        VStack(alignment: .center){
            
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
    
    private func transactionType(title: String, type: FilterViewModel.TransactionTypeFilter) -> some View{
        ZStack{
            if vm.transactionType == type{
                RoundedRectangle(cornerRadius: 15)
                    .fill(
                        LinearGradient(gradient: Gradient(colors: [.mint, .teal, .cyan, .blue]), startPoint: .leading, endPoint: .trailing)
                    )
                    .cornerRadius(15)
                    .matchedGeometryEffect(id: "option1Background", in: namespace)
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

