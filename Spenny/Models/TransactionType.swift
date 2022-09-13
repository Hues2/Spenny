//
//  TransactionType.swift
//  Spenny
//
//  Created by Greg Ross on 13/09/2022.
//

import Foundation
import SwiftUI


struct TransactionType: Codable, Identifiable, Equatable{
    var id: UUID = UUID()
    var iconName: String
    var title: String
    var colorHex: String
}
