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
    
    var body: some View{
        VStack{
            HStack{
                Spacer()
                Image(systemName: "x.circle")
                    .foregroundColor(.accentColor)
                    .onTapGesture {
                        withAnimation(.easeInOut) {
                            showModal.toggle()
                        }
                    }
                    .padding()
            }
            Spacer()
        }
        .frame(height: UIScreen.main.bounds.height / 2)
        .frame(maxWidth: .infinity)
        .background(
            
                .cornerRadius(10)
                .ignoresSafeArea()
        )
    }
}


extension View{
    func withGetStartedModal(showModal: Binding<Bool>) -> some View{
        modifier(GetStartedModalViewModifier(showModal: showModal))
    }
}


