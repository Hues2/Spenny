//
//  SpennyData.swift
//  Spenny
//
//  Created by Greg Ross on 12/09/2022.
//

import Foundation

struct SpennyData: Codable{
    var monthlyIncome: Double
    var savingsGoal: Double
    var directDebits: [Transaction]
    var transactions: [Transaction]
}
