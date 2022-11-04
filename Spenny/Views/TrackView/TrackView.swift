//
//  TrackView.swift
//  Spenny
//
//  Created by Greg Ross on 17/09/2022.
//

import SwiftUI

struct TrackView: View {
    
    @StateObject private var vm: TrackViewModel
    
    
    @State private var xOffset: CGFloat = 0
    @State private var yOffset: CGFloat = 0
    @State private var isDragging: Bool = false
    @State private var alignment: Alignment = .bottomTrailing
        
    
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
        .toolbar{
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
//                    withAnimation(.spring()) {
//                        vm.dataManager.showModal = true
//                    }
                } label: {
                    Image(systemName: "line.3.horizontal")
                        .foregroundColor(.accentColor)
                }

            }
        }
        .withTrackViewModifiers()
        .overlay(alignment: alignment) {
            Button {
                withAnimation(.spring()) {
                    vm.dataManager.showModal = true
                }
            } label: {
                ZStack{
                    Circle()
                        .fill(Color.accentColor)
                        .frame(width: 50, height: 50)
                        .padding(10)
                        .shadow(color: .black.opacity(0.5), radius: 5)
                    
                    Image(systemName: "plus")
                        .foregroundColor(.white)
                        
                }
                .onTapGesture {
                    withAnimation(.spring()) {
                        vm.dataManager.showModal = true
                    }
                }
                .offset(x: xOffset, y: yOffset)
                .scaleEffect(isDragging ? 1.2 : 1)
                .gesture(longTapGesture)
            }

            
            
            
            

            
            
        }

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
    
    private var longTapGesture: SequenceGesture<_EndedGesture<LongPressGesture>, _EndedGesture<_ChangedGesture<DragGesture>>> {
        let longPress = LongPressGesture()
            .onEnded { value in
                isDragging = true
            }
        
        let drag = DragGesture()
            .onChanged { value in
                withAnimation {
                    xOffset = value.translation.width
                    yOffset = value.translation.height
                }
                print("\n \(value.translation.width) \n")

            }
            .onEnded { value in
                var positiveValue = value.translation.width
                if positiveValue < 0 { positiveValue = positiveValue * (-1) }
                
                if positiveValue >= UIScreen.main.bounds.width / 2.9{
                    withAnimation {
                        alignment = (alignment == .bottomLeading ? .bottomTrailing : .bottomLeading)
                        xOffset = 0
                        yOffset = 0
                    }
                } else {
                    withAnimation {
                        xOffset = 0
                        yOffset = 0
                    }
                }
                
                
                isDragging = false
            }
        
        let combined = longPress.sequenced(before: drag)
        
        return combined
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
