//
//  SpennyApp.swift
//  Spenny
//
//  Created by Greg Ross on 11/09/2022.
//

import SwiftUI

@main
struct SpennyApp: App {
    @AppStorage("isEditingMonth") var isEditingMonth: Bool = false
    var body: some Scene {
        WindowGroup {
            AppView(isEditingMonth: $isEditingMonth)
                
        }
    }
}
