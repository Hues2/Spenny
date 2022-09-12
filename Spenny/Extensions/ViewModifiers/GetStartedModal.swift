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
        .frame(height: UIScreen.main.bounds.height / 2)
        .frame(maxWidth: .infinity)
        .overlay(
            RoundedRectangle(cornerRadius: 30)
                .fill(Color.accentColor)
                .frame(width: 30, height: 5)
                .padding(3)
            , alignment: .top
        )
        .background(
            Color.startedModalBackgroundColor
                .cornerRadius(10)
                .ignoresSafeArea()
                .shadow(color: .black.opacity(0.3), radius: 2, x: 0, y: -2)
        )
        .offset(x: 0, y: showModal ? offset : .zero)
        .gesture(
            DragGesture()
                .onChanged({ gesture in
                    offset = gesture.translation.height
                    print("\n \(offset) \n")
                    
                })
                .onEnded({ gesture in
                    if gesture.translation.height > 150{
                        dismissModal()
                    }
                })
        )
        
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
            
            Button {
                dismissModal()
            } label: {
                Image(systemName: "x.circle")
                    .font(.title2)
                    .foregroundColor(.accentColor)
                    .padding()
            }
            .buttonStyle(SpennyButtonStyle())

        }
    }
    
}


extension View{
    func withGetStartedModal(showModal: Binding<Bool>) -> some View{
        modifier(GetStartedModalViewModifier(showModal: showModal))
    }
}


