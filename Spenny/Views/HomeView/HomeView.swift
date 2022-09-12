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
    
    
    init(showModal: Binding<Bool>){
        self._vm = StateObject(wrappedValue: HomeViewModel(showModal: showModal))
    }
        
    var body: some View {
        NavigationView {
            if vm.showInitialProgressView{
                
                // MARK: Initial ProgressView
                loadingView
                
            } else{
                
                /*
                 Check if the data is nil
                 if vm.data != nil{
                 } else{
                    getStarted
                 }
                 */
                getStarted
                
            }
            
            

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
            
            Text("SPENNY")
                .font(.largeTitle)
                .fontWeight(.black)
                .foregroundColor(.accentColor)
            
            Button {
                withAnimation(.spring()) {
                    vm.showModal = true
                }
                
                
            } label: {
                Text("Get Started")
                    .font(.headline)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(
                        LinearGradient(gradient: Gradient(colors: [.teal, .cyan, .blue]), startPoint: .leading, endPoint: .trailing)
                    )
                    .cornerRadius(15)
                    .shadow(color: .black.opacity(0.3), radius: 2, x: 0, y: 0)
                    .padding()
            }
            .buttonStyle(SpennyButtonStyle())
            
            Spacer()
        }
    }

    
}
