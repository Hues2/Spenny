//
//  HomeView.swift
//  Spenny
//
//  Created by Greg Ross on 11/09/2022.
//

import SwiftUI
import UIKit

struct HomeView: View {
    
    @StateObject var vm = HomeViewModel()
        
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
                print("\n Get started pressed! \n")
            } label: {
                Text("Get Started")
                    .font(.headline)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .padding()
                    .background(
                        Color.teal
                    )
                    .cornerRadius(15)
            }
            .buttonStyle(SpennyButtonStyle())

            
            Spacer()
        }
    }

    
}


struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
