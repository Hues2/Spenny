//
//  TransactionRow.swift
//  Spenny
//
//  Created by Greg Ross on 14/09/2022.
//

import SwiftUI

struct TransactionRow: View {
    let transaction: Transaction
    
    var body: some View {
        GroupBox{
            Text("Transaction Row")
        }
        .frame(maxWidth: .infinity)
    }
}

