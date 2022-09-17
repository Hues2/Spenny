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
    }
    
    var body: some View {
        
        VStack{
            Spacer()
            
            //MARK: - Transactions
            transactions
        }
        
        
    }
}


extension TrackView{
    
    private var transactions: some View{
        VStack{
            //MARK: - List Header
            listHeader
            
            //MARK: - Transactions List
            List(vm.dataManager.transactions){ transaction in
                TransactionRow(transaction: transaction)
            }
            
        }
        
    }
    
    private var listHeader: some View{
        HStack{
            Text("")
                .font(.caption)
                .fontWeight(.ultraLight)
                .foregroundColor(.gray)
                .frame(width: 75)
            
            
            Spacer()
            
            //MARK: - Transaction Date
            Text("Date")
                .font(.caption)
                .fontWeight(.ultraLight)
                .foregroundColor(.gray)
                .frame(width: 70)
            
            
            Spacer()
            
            //MARK: - Transaction Title
            Text("Title")
                .font(.caption)
                .fontWeight(.ultraLight)
                .foregroundColor(.gray)
                .lineLimit(1)
                .frame(width: 75)
            
            Spacer()
            
            //MARK: - Transaction Amount
            Text("Amount")
                .font(.caption)
                .fontWeight(.ultraLight)
                .foregroundColor(.gray)
                .frame(width: 75)
                .frame(maxWidth: 130)
                .lineLimit(1)
                .layoutPriority(1)
                .minimumScaleFactor(0.8)
        }
    }
}
