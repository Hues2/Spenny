//
//  SpennyData.swift
//  Spenny
//
//  Created by Greg Ross on 12/09/2022.
//

import Foundation

struct SpennyData: Codable, Identifiable{
    var id: UUID = UUID()
    var monthlyIncome: Double
    var savingsGoal: Double
    var transactions: [Transaction]
}
