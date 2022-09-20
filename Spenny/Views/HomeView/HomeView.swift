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
            VStack{
                if vm.showInitialProgressView{
                    
                    // MARK: Initial ProgressView
                    loadingView
                    
                } else{
                    
                    if vm.dataManager.spennyEntity == nil{
                        getStarted
                    } else{
                        TrackView(dataManager: vm.dataManager)
                    }
                }
            }
            .background(Color.backgroundColor.ignoresSafeArea())
            
            
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
                vm.dataManager.showModal = false
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
        if !vm.dataManager.showModal{
            Button {
                withAnimation(.spring()) {
                    vm.dataManager.showModal = true
                }
                
            } label: {
                Text("Get Started")
                    .fontWeight(.bold)
                    .withSpennyButtonLabelStyle()
            }
            .transition(.scale)
            .animation(.easeInOut, value: vm.dataManager.showModal)
            .buttonStyle(SpennyButtonStyle())
        }
    }
    
    
}
