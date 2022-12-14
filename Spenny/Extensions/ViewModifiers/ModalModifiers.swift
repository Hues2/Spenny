//
//  ModalModifiers.swift
//  Spenny
//
//  Created by Greg Ross on 12/09/2022.
//

import Foundation
import SwiftUI

struct ModalModifiers: ViewModifier{
    @Binding var showModal: Bool
    @Binding var offset: CGFloat
    let dismissModal: () -> Void
    @State var dismissKeyboardDrag: CGFloat = .zero
    
    func body(content: Content) -> some View {
        content
            .frame(maxWidth: .infinity)
            .background(
                Color.backgroundColor
                .cornerRadius(10)
                .edgesIgnoringSafeArea([.bottom])
                .shadow(color: .black.opacity(0.3), radius: 2, x: 0, y: -2)
            )
            .overlay(
                RoundedRectangle(cornerRadius: 30)
                    .fill(LinearGradient(gradient: Gradient(colors: [.mint, .teal, .cyan, .blue]), startPoint: .leading, endPoint: .trailing))
                    .frame(width: 30, height: 5)
                    .padding(3)
                , alignment: .top
            )
            .padding(.top, 15)
            .onTapGesture {
                UIApplication.shared.dismissKeyboard()
            }
            .offset(x: 0, y: showModal ? offset : .zero)
            .addModalDragGesture(offset: $offset, dismissModal: dismissModal)
    }
}


extension View{
    func addModalModifiers(showModal: Binding<Bool>, offset: Binding<CGFloat>, dismissModal: @escaping () -> Void) -> some View{
        modifier(ModalModifiers(showModal: showModal, offset: offset, dismissModal: dismissModal))
    }
}
