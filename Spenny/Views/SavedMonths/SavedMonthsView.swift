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
        List{
            ForEach(vm.validSavedEntities, id: \.id){ entity in
                Section{
                    GroupBox{
                        HStack{
                            
                            Spacer()
                            
                            VStack(spacing: 15){
                                Text("Monthly Income:")
                                    .font(.caption)
                                    .foregroundColor(Color.accentColor)
                                Text("\(entity.monthlyIncome.withPoundSign(format: "%.2f"))")
                            }
                            .frame(width: 100)
                            
                            Spacer()
                            
                            
                            VStack(spacing: 15){
                                Text("Savings Goal:")
                                    .font(.caption)
                                    .foregroundColor(Color.accentColor)
                                Text("\(entity.savingsGoal.withPoundSign(format: "%.2f"))")
                            }
                            .frame(width: 100)
                            
                            Spacer()
                            
                            VStack(spacing: 15){
                                Text("Amount Saved:")
                                    .font(.caption)
                                    .foregroundColor(Color.accentColor)
                                Text("\(vm.getAmountSaved(entity: entity).withPoundSign(format: "%.2f"))")
                                    .foregroundColor(entity.savingsGoal == vm.getAmountSaved(entity: entity) ? Color.orange : (entity.savingsGoal < vm.getAmountSaved(entity: entity) ? Color.green : Color.red))
                            }
                            .frame(width: 100)
                            
                            Spacer()
                            
                        }
                        .frame(maxWidth: .infinity)
                    }
                    .groupBoxStyle(ColoredGroupBox(frameHeight: nil))
                    .listRowSeparator(.hidden)
                    .listRowBackground(Color.clear)
                } header: {
                    Text("\(vm.getDates(entity: entity))")
                }
            }
        }
        .listStyle(.insetGrouped)
        .scrollContentBackground(.hidden)
        .withTrackViewModifiers()
    }
}



extension SavedMonthsView{
    
    private func infoBoxHeader(monthlyIncome: Double, savingsGoal: Double) -> some View{
        HStack{
            
            InfoBoxHeader(text: "Monthly Income:", amount: monthlyIncome, isFooter: false, isPercent: false)

            Spacer()
            
            InfoBoxHeader(text: "Savings Goal:", amount: savingsGoal, isFooter: false, isPercent: false)
            
        }
    }
    
    private func infoBoxCenter(infoBoxCenterPercent: Double, remainingAmount: Double) -> some View{
        HStack{
            Spacer()
            
            InfoBoxCenter(progress: infoBoxCenterPercent, remaining: remainingAmount)
                .frame(width: 150, height: 150)
                       
            Spacer()
        }
    }
    
    private func infoBoxFooter(currentTransactionsAmount: Double, percentageOfSavingsSoFar: Double) -> some View{
        HStack{
            
            InfoBoxHeader(text: "Transactions:", amount: currentTransactionsAmount, isFooter: true, isPercent: false)

            Spacer()
            
            InfoBoxHeader(text: "% of Goal:", amount: percentageOfSavingsSoFar, isFooter: true, isPercent: true)
            
        }
    }
    
    private func infoBox(monthlyIncome: Double, savingsGoal: Double, infoBoxCenterPercent: Double, remainingAmount: Double, currentTransactionsAmount: Double, percentageOfSavingsSoFar: Double) -> some View{
        GroupBox{
            VStack{
                infoBoxHeader(monthlyIncome: monthlyIncome, savingsGoal: savingsGoal)
                
                infoBoxCenter(infoBoxCenterPercent: infoBoxCenterPercent, remainingAmount: remainingAmount)
                    .padding(.top, 2.5)
                    .padding(.bottom, 2.5)
                
                infoBoxFooter(currentTransactionsAmount: currentTransactionsAmount, percentageOfSavingsSoFar: percentageOfSavingsSoFar)
            }
        }
        .clipped()
        .shadow(color: .black.opacity(0.6), radius: 3, x: 0, y: 0)
        .frame(maxWidth: .infinity)
        .frame(height: 290)
        .groupBoxStyle(ColoredGroupBox(frameHeight: 290))
        
        .padding(.horizontal)
    }
}
