//
//  Transaction.swift
//  Spenny
//
//  Created by Greg Ross on 13/09/2022.
//

import Foundation
import SwiftUI

struct Transaction: Codable{
    let title: String
    let value: Double
    let date: String
    let icon: String
    let transaction: TransactionType
    
}
