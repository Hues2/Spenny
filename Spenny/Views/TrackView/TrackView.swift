//
//  TrackView.swift
//  Spenny
//
//  Created by Greg Ross on 17/09/2022.
//

import SwiftUI

struct TrackView: View {
    
    @StateObject private var vm: TrackViewModel
    
    @State var isEditingInfoBox: Bool = false
    @Namespace var namespace
    
    
    init(dataManager: DataManager) {
        self._vm = StateObject(wrappedValue: TrackViewModel(dataManager: dataManager))
        UITableView.appearance().backgroundColor = UIColor.clear
    }
    
    var body: some View {
        
        VStack{
            
            if !isEditingInfoBox{
                //MARK: - Info Box
                infoBox
                    .onTapGesture {
                        withAnimation {
                            isEditingInfoBox = true
                        }
                        
                    }
                    .matchedGeometryEffect(id: "hi", in: namespace)
                
                Spacer()
                
                //MARK: - Transactions
                transactions
                
            } else{
                
                
                ZStack{
                    transactions
                    
                    Color.black.opacity(0.3).ignoresSafeArea()
                        .onTapGesture {
                            withAnimation {
                                isEditingInfoBox = false
                            }
                            
                        }
                    
                    VStack{
                        Spacer()
                        
                        infoBox
                            .matchedGeometryEffect(id: "hi", in: namespace)
                        
                        Spacer()
                    }
                    
                }
                
            }
            
            
        }
        .toolbar{
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    withAnimation(.spring()) {
                        vm.dataManager.showModal = true
                    }
                } label: {
                    Image(systemName: "plus")
                        .foregroundColor(.accentColor)
                }

            }
        }
        .withTrackViewModifiers()
        
        
        
    }
}


extension TrackView{
    
    private var infoBoxHeader: some View{
        HStack{
            
            InfoBoxHeader(text: "Monthly Income:", amount: vm.monthlyIncome)

            Spacer()
            
            InfoBoxHeader(text: "Savings Goal:", amount: vm.savingsGoal)
            
        }
    }
    
    private var infoBoxCenter: some View{
        HStack{
            Spacer()
            
            VStack(spacing: 5){
                Text("Remaining:")
                    .font(.caption)
                    .foregroundColor(.gray)
                
                Rectangle()
                    .fill(LinearGradient(gradient: Gradient(colors: [.mint, .teal, .cyan, .blue]), startPoint: .leading, endPoint: .trailing))
                    .mask {
                        Text(vm.remainingAmount.toFormattedString(format: "%.2f"))
                            .font(.title)
                            .fontWeight(.black)
                    }
                    .frame(maxWidth: 150, maxHeight: 50)
            }
            
           
            
            
            Spacer()
        }
    }
    
    private var infoBox: some View{
        GroupBox{
            VStack{
                infoBoxHeader
                
                infoBoxCenter
                    .padding(.top, 10)
            }
        }
        .frame(maxWidth: .infinity)
        .groupBoxStyle(ColoredGroupBox())
        .padding()
    }
    
    private var listHeader: some View{
        HStack{
            Text("Type")
                .font(.caption)
                .fontWeight(.light)
                .foregroundColor(.gray)
                .frame(width: 75)
            
            
            Spacer()
            
            //MARK: - Transaction Date
            Text("Date")
                .font(.caption)
                .fontWeight(.light)
                .foregroundColor(.gray)
                .frame(width: 70)
            
            
            Spacer()
            
            //MARK: - Transaction Title
            Text("Title")
                .font(.caption)
                .fontWeight(.light)
                .foregroundColor(.gray)
                .frame(width: 75)
            
            Spacer()
            
            //MARK: - Transaction Amount
            Text("Amount")
                .font(.caption)
                .fontWeight(.light)
                .foregroundColor(.gray)
                .frame(width: 75)
        }
        .padding(.horizontal)
    }
    
    private var transactions: some View{
        VStack(spacing: 5){
            if !vm.transactions.isEmpty{
                //MARK: - List Header
                listHeader
                
                //MARK: - Transactions List
                List {
                    ForEach(vm.transactions) { transaction  in
                        TransactionRow(transaction: transaction)
                            .listRowBackground(Color.backgroundColor.ignoresSafeArea())
                            .listRowSeparator(.hidden)
                            .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 7.5, trailing: 0))
                    }
                    .onDelete { indexSet in
                        vm.deleteTransaction(index: indexSet)
                    }
                    
                }
                .listStyle(.plain)
                .scrollContentBackground(.hidden)
                .padding(.horizontal)
                
            } else {
                Spacer()
                
                Text("YOU HAVE NO TRANSACTIONS")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .foregroundColor(.gray)
                Spacer()
            }
        }
    }
    
}


struct TrackViewModifiers: ViewModifier{
    
    func body(content: Content) -> some View {
        content
            .background(Color.backgroundColor.ignoresSafeArea())
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Rectangle()
                        .fill(LinearGradient(gradient: Gradient(colors: [.mint, .teal, .cyan, .blue]), startPoint: .leading, endPoint: .trailing))
                        .frame(width: 100, height: 50)
                        .mask {
                            Text("SPENNY")
                                .font(.title3)
                                .fontWeight(.black)
                        }
                }
                
                
            }
    }
}

extension View{
    func withTrackViewModifiers() -> some View{
        modifier(TrackViewModifiers())
    }
}
