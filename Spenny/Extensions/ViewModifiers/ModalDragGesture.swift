//
//  ModalDragGesture.swift
//  Spenny
//
//  Created by Greg Ross on 12/09/2022.
//

import Foundation
import SwiftUI


struct ModalDragGestureViewModifier: ViewModifier{
    @Binding var offset: CGFloat
    let dismissModal: () -> Void
    
    func body(content: Content) -> some View {
        content
            .gesture(
                DragGesture()
                    .onChanged({ gesture in
                        if gesture.translation.height > 0{
                            withAnimation {
                                offset = gesture.translation.height
                            }
                        }
                    })
                    .onEnded({ gesture in
                        if gesture.translation.height > 250{
                            dismissModal()
                        } else{
                            withAnimation {
                                offset = .zero
                            }
                        }
                    })
            )
    }
}


extension View{
    func addModalDragGesture(offset: Binding<CGFloat>, dismissModal: @escaping () -> Void) -> some View{
        modifier(ModalDragGestureViewModifier(offset: offset, dismissModal: dismissModal))
    }
}
