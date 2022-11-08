//
//  TrackView.swift
//  Spenny
//
//  Created by Greg Ross on 17/09/2022.
//

import SwiftUI

struct TrackView: View {
    
    @StateObject var vm: TrackViewModel
    
    /// Floating button movement
    @AppStorage("buttonIsRightAlignment") private var buttonIsRightAlignment = true
    @State private var xOffset: CGFloat = 0
    @State private var yOffset: CGFloat = 0
    @State private var isDragging: Bool = false
    private var alignment: Alignment{
        return (buttonIsRightAlignment ? .bottomTrailing : .bottomLeading)
    }
    
    /// List header title movement
    @Namespace private var namespace
    @State var shouldAnimate: Bool = false
        
    
    init(dataManager: DataManager) {
        self._vm = StateObject(wrappedValue: TrackViewModel(dataManager: dataManager))
        UITableView.appearance().backgroundColor = UIColor.clear
        UITableViewCell.appearance().layoutMargins = UIEdgeInsets(top: 0, left: 0, bottom: 7.5, right: 0)
    }
    
    var body: some View {
        
        VStack{
            
                //MARK: - Info Box
                infoBox
                
                Spacer()
                
                //MARK: - Transactions
                transactions

        }
        .sheet(isPresented: $vm.showFiltersSheet, content: {
            FilterView(filter: $vm.filter, showSheet: $vm.showFiltersSheet)
                .presentationDetents([.large])
                .presentationDragIndicator(.visible)
        })
        .toolbar{
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    /// Show settings sheet
                    withAnimation {
                        vm.showFiltersSheet.toggle()
                    }
                    
                } label: {
                    Image(systemName: "slider.vertical.3")
                        .foregroundColor(.accentColor)
                        .rotationEffect(Angle(degrees: 90))
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
                .defersSystemGestures(on: .all)
            }

        }

    }
}


extension TrackView{
    
    private var infoBoxHeader: some View{
        HStack{
            
            InfoBoxHeader(text: "Monthly Income:", amount: vm.monthlyIncome, isFooter: false, isPercent: false)

            Spacer()
            
            InfoBoxHeader(text: "Savings Goal:", amount: vm.savingsGoal, isFooter: false, isPercent: false)
            
        }
    }
    
    private var infoBoxCenter: some View{
        HStack{
            Spacer()
            
            InfoBoxCenter(progress: vm.infoBoxCenterPercent, remaining: vm.remainingAmount)
                .frame(width: 150, height: 150)
            
//            VStack(spacing: 0){
//                Text("Remaining:")
//                    .font(.caption)
//                    .foregroundColor(.gray)
//
//                Rectangle()
//                    .fill(LinearGradient(gradient: Gradient(colors: [.mint, .teal, .cyan, .blue]), startPoint: .leading, endPoint: .trailing))
//                    .mask {
//                        Text(vm.remainingAmount.toFormattedString(format: "%.2f"))
//                            .font(.largeTitle)
//                            .fontWeight(.black)
//                    }
//                    .frame(maxWidth: 200, maxHeight: 50)
//            }
            
                       
            Spacer()
        }
    }
    
    private var infoBoxFooter: some View{
        HStack{
            
            InfoBoxHeader(text: "Transactions:", amount: vm.currentTransactionsAmount, isFooter: true, isPercent: false)

            Spacer()
            
            InfoBoxHeader(text: "% of Goal:", amount: vm.percentageOfSavingsSoFar, isFooter: true, isPercent: true)
            
        }
    }
    
    private var infoBox: some View{
        GroupBox{
            VStack{
                infoBoxHeader
                
                infoBoxCenter
                    .padding(.top, 2.5)
                    .padding(.bottom, 2.5)
                
                infoBoxFooter
            }
        }
        .frame(maxWidth: .infinity)
        .groupBoxStyle(ColoredGroupBox())
        .padding()
    }
    
    private var listHeaders: some View{
        HStack{
            listHeader(title: "Type", sortingType: .category)
            
            Spacer()
            
            //MARK: - Transaction Date
            listHeader(title: "Date", sortingType: .date)
            
            Spacer()
            
            //MARK: - Transaction Title
            listHeader(title: "Title", sortingType: .title)
            
            Spacer()
            
            //MARK: - Transaction Amount
            listHeader(title: "Amount", sortingType: .amount)
            
        }
        .padding(.horizontal)
    }
    
    private func listHeader(title: String, sortingType: TrackViewModel.ListHeaderTitleType) -> some View{
        VStack{
            HStack{
                Text(title)
                    .font(.caption)
                    .fontWeight(.light)
                    .foregroundColor(.gray)
                    
                    .onTapGesture {
                        HapticFeedbackGenerator.shared.impact(style: .light)
                        withAnimation {
                            shouldAnimate.toggle()
                            vm.selectedSortingType = sortingType
                        }
                    }
                
                if vm.isShowingSortIcon && sortingType == vm.selectedSortingType{
                    Image(systemName: "arrow.up.arrow.down")
                        .font(.caption)
                        .fontWeight(.light)
                        .foregroundColor(.accentColor)
                        .rotationEffect(shouldAnimate ? Angle(degrees: 180) : Angle(degrees: 0))
                        .transition(.scale)
                    
                }
            }
            .frame(width: 70)
            
            ZStack{
                
                if vm.selectedSortingType == sortingType{
                    RoundedRectangle(cornerRadius: 10)
                        .fill(LinearGradient(gradient: Gradient(colors: [.mint, .teal, .cyan, .blue]), startPoint: .leading, endPoint: .trailing))
                        .matchedGeometryEffect(id: "header", in: namespace)
                }
            }
            .frame(width: 70, height: 3)
            
        }
    }
    
    private var transactions: some View{
        VStack(spacing: 5){
            if !vm.filteredTransactions.isEmpty{
                //MARK: - List Header
                listHeaders
                
                //MARK: - Transactions List
                List {
                    ForEach(vm.filteredTransactions) { transaction  in
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
        let longPress = LongPressGesture(minimumDuration: 0.3)
            .onEnded { value in
                isDragging = true
                HapticFeedbackGenerator.shared.impact(style: .medium)
            }
        
        let drag = DragGesture()
            .onChanged { value in
                withAnimation {
                    xOffset = value.translation.width
                    yOffset = value.translation.height
                }

            }
            .onEnded { value in
                var positiveValue = value.translation.width
                if positiveValue < 0 { positiveValue = positiveValue * (-1) }
                
                if positiveValue >= UIScreen.main.bounds.width / 2.9{
                    withAnimation {
                        buttonIsRightAlignment = (buttonIsRightAlignment ? false : true)
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
