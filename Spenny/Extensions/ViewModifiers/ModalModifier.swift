//
//  ModalModifier.swift
//  Spenny
//
//  Created by Greg Ross on 20/09/2022.
//

import Foundation
import SwiftUI


struct GetStartedModalViewModifier: ViewModifier{
    var dataManager: DataManager
    @Binding var isNewUser: Bool
    
    func body(content: Content) -> some View {
        ZStack(alignment: .bottom){
            content
                .zIndex(0)
            
            if dataManager.showModal{
                if isNewUser{
                    GetStartedModal(dataManager: dataManager)
                        .zIndex(1)
                        .transition(.move(edge: .bottom))
                        .animation(.spring(), value: dataManager.showModal)
                } else {
                    AddTransactionModal(dataManager: dataManager)
                        .zIndex(1)
                        .transition(.move(edge: .bottom))
                        .animation(.spring(), value: dataManager.showModal)
                }
                
                
                
            }
        }
    }
}


extension View{
    func withGetStartedModal(dataManager: DataManager, isNewUser: Binding<Bool>) -> some View{
        modifier(GetStartedModalViewModifier(dataManager: dataManager, isNewUser: isNewUser))
    }
}
