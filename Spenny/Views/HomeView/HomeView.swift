//
//  HomeView.swift
//  Spenny
//
//  Created by Greg Ross on 11/09/2022.
//

import SwiftUI
import UIKit

struct HomeView: View {
    
    @StateObject var vm: HomeViewModel
    @Binding var showModal: Bool
    
    
    init(showModal: Binding<Bool>){
        self._showModal = showModal
        self._vm = StateObject(wrappedValue: HomeViewModel(showModal: showModal))
    }
    
    var body: some View {
        NavigationView {
//            if vm.showInitialProgressView{
//
//                // MARK: Initial ProgressView
//                loadingView
//
//            } else{
                
                /*
                 Check if the data is nil
                 if vm.data != nil{
                 } else{
                 getStarted
                 }
                 */
                getStarted
                
//            }
            
            
            
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}


extension HomeView{
    
    private var loadingView: some View{
        VStack{
            Spacer()
            
            ProgressView()
                .progressViewStyle(CircularProgressViewStyle(tint: .accentColor))
            
            Spacer()
        }
    }
    
    private var getStarted: some View{
        VStack{
            
            Spacer()

            //MARK: - Logo
            logo
            
            //MARK: - Get Started Button
            getStartedButton
                        
            Spacer()
            
            // This moves the logo up, when the modal appears
//            if showModal{
//                Spacer()
//                    .frame(height: UIScreen.main.bounds.height / 1.9)
//            }
            
        }
        .onTapGesture {
            withAnimation {
                showModal = false
            }
        }
    }
    
    private var logo: some View{
        Rectangle()
            .fill(LinearGradient(gradient: Gradient(colors: [.mint, .teal, .cyan, .blue]), startPoint: .leading, endPoint: .trailing))
            .frame(height: 75)
            .frame(maxWidth: .infinity)
            .mask {
                Text("SPENNY")
                    .font(.largeTitle)
                    .fontWeight(.black)
            }
    }
    
    @ViewBuilder private var getStartedButton: some View{
        if !showModal{
            Button {
                withAnimation(.spring()) {
                    vm.showModal = true
                }
                
            } label: {
                Text("Get Started")
                    .fontWeight(.bold)
                    .withSpennyButtonLabelStyle()
            }
            .transition(.scale)
            .animation(.easeInOut, value: showModal)
            .buttonStyle(SpennyButtonStyle())
        }
    }
    
    
}
