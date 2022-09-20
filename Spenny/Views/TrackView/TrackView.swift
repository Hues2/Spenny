//
//  TrackView.swift
//  Spenny
//
//  Created by Greg Ross on 17/09/2022.
//

import SwiftUI

struct TrackView: View {
    
    @StateObject private var vm: TrackViewModel
    
    init(dataManager: DataManager) {
        self._vm = StateObject(wrappedValue: TrackViewModel(dataManager: dataManager))
        UITableView.appearance().backgroundColor = UIColor.clear
    }
    
    var body: some View {
        
        VStack{
            
            //MARK: - Info Box
            infoBox
            
            Spacer()
            
            //MARK: - Transactions
            transactions
        }
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
        
        
    }
}


extension TrackView{
    
    private var infoBoxHeader: some View{
        HStack{
            
            VStack(spacing: 5){
                
                Text("Monthly Income:")
                    .font(.caption)
                    .foregroundColor(.gray)
                
                Text("\(vm.dataManager.monthlyIncome?.toFormattedString(format: "%.2f") ?? "")")
                    .font(.caption)
                    .foregroundColor(.gray)
                
            }
            
            Spacer()
            
            VStack(spacing: 5){
                Text("Savings Goal")
                    .font(.caption)
                    .foregroundColor(.gray)
                
                Text("\(vm.dataManager.savingsGoal?.toFormattedString(format: "%.2f") ?? "")")
                    .font(.caption)
                    .foregroundColor(.gray)
            }
            
        }
    }
    
    private var infoBoxCenter: some View{
        HStack{
            Spacer()
            
            Rectangle()
                .fill(LinearGradient(gradient: Gradient(colors: [.mint, .teal, .cyan, .blue]), startPoint: .leading, endPoint: .trailing))
                .mask {
                    Text(vm.remainingAmount.toFormattedString(format: "%.2f"))
                        .font(.title)
                        .fontWeight(.black)
                }
                .frame(maxWidth: 150, maxHeight: 100)
            
            
            Spacer()
        }
    }
    
    private var infoBox: some View{
        GroupBox{
            VStack{
                infoBoxHeader
                
                infoBoxCenter
            }
        }
        .frame(maxWidth: .infinity)
        .groupBoxStyle(ColoredGroupBox())
        .padding()
    }
    
    private var transactions: some View{
        VStack(spacing: 5){
            //MARK: - List Header
            listHeader
            
                //MARK: - Transactions List
            List(vm.transactions){ transaction in
                TransactionRow(transaction: transaction)
                    .listRowBackground(Color.backgroundColor.ignoresSafeArea())
                    .listRowSeparator(.hidden)
                    .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 10, trailing: 0))
                    
            }
            .listStyle(.plain)
            .scrollContentBackground(.hidden)
            .padding(.horizontal)
            .onChange(of: vm.dataManager.transactions) { newValue in
                print("\n Transactions changed \n")
            }
        }
    }
    
    private var listHeader: some View{
        HStack{
            Text("")
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
    
}
