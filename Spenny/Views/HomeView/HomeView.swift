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
    
    
    init(dataManager: DataManager){
        self._vm = StateObject(wrappedValue: HomeViewModel(dataManager: dataManager))
    }
    
    var body: some View {
        NavigationView {
            if vm.showInitialProgressView{

                // MARK: Initial ProgressView
                loadingView

            } else{
                
                if vm.dataManager.spennyEntity == nil{
                    getStarted
                    .background(Color.backgroundColor.ignoresSafeArea())
                } else{
                    TrackView(dataManager: vm.dataManager)
                }
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

            //MARK: - Logo
            logo
            
            //MARK: - Get Started Button
            getStartedButton
                        
            Spacer()
            
        }
        .onTapGesture {
            withAnimation {
                vm.dataManager.isAddingTransaction = false
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
        if !vm.dataManager.isAddingTransaction{
            Button {
                withAnimation(.spring()) {
                    vm.dataManager.isAddingTransaction = true
                }
                
            } label: {
                Text("Get Started")
                    .fontWeight(.bold)
                    .withSpennyButtonLabelStyle()
            }
            .transition(.scale)
            .animation(.easeInOut, value: vm.dataManager.isAddingTransaction)
            .buttonStyle(SpennyButtonStyle())
        }
    }
    
    
}
