//
//  GetStartedModal.swift
//  Spenny
//
//  Created by Greg Ross on 12/09/2022.
//

import SwiftUI


struct GetStartedModalViewModifier: ViewModifier{
    @Binding var showModal: Bool
    
    func body(content: Content) -> some View {
        ZStack(alignment: .bottom){
            content
                .zIndex(0)
            
            if showModal{
                GetStartedModal(showModal: $showModal)
                    .zIndex(1)
                    .transition(.move(edge: .bottom))
                    .animation(.spring(), value: showModal)
            }
        }
    }
}


struct GetStartedModal: View{
    @Binding var showModal: Bool
    @State private var offset = CGFloat.zero
    
    var body: some View{
        VStack{
            // MARK: Button Row
            buttonRow
            
            Spacer()
        }
        .addModalModifiers(showModal: $showModal, offset: $offset, dismissModal: dismissModal)
    }
    
    func dismissModal(){
        withAnimation(.easeInOut) {
            showModal.toggle()
        }
    }
}


extension GetStartedModal{
    
    private var buttonRow: some View{
        HStack{
            
            Spacer()
            
            Circle()
                .fill(RadialGradient(gradient: Gradient(colors: [.mint, .teal, .cyan, .blue]), center: .center, startRadius: 5, endRadius: 15))
                .frame(width: 25, height: 25)
                .mask {
                    Button {
                        dismissModal()
                    } label: {
                        Image(systemName: "x.circle")
                            .font(.title2)
                            
                    }
                    .buttonStyle(SpennyButtonStyle())
                }
                .padding(5)
            
            

        }
    }
    
    
}

extension View{
    func withGetStartedModal(showModal: Binding<Bool>) -> some View{
        modifier(GetStartedModalViewModifier(showModal: showModal))
    }
}


