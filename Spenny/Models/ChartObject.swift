//
//  ChartObject.swift
//  Spenny
//
//  Created by Greg Ross on 08/11/2022.
//

import Foundation


struct ChartObject: Identifiable{
    let id = UUID()
    let date: Date
    let amountRemaining: Double
}
