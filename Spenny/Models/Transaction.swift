//
//  Transaction.swift
//  Spenny
//
//  Created by Greg Ross on 13/09/2022.
//

import Foundation
import SwiftUI

struct Transaction: Codable, Identifiable{
    var id: UUID = UUID()
    var title: String = ""
    var amount: Double
    var date: String = ""
    var transactionType: TransactionType
    var isDirectDebit: Bool = false
    
}
