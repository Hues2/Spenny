//
//  HomeView.swift
//  Spenny
//
//  Created by Greg Ross on 11/09/2022.
//

import SwiftUI
import UIKit

struct HomeView: View {
        
    var body: some View {
        NavigationView {
            VStack{
                //MARK: - Header
                header
                
                
                
                Spacer()
            }
            .navigationTitle("Spenny")
            .navigationBarTitleDisplayMode(.inline)
            

        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}


extension HomeView{
    
    private var header: some View{
        GroupBox {
            VStack(alignment: .center, spacing: 15){
                
                //MARK: - Remaining Amount
                remainingAmount
                
                //MARK: - Add Savings Goal Button
                savingsGoal
            }
        }
        .padding()
    }
    
    
    
    private var savingsGoal: some View{
        // If there is no savings goal, then show the button
            Button {
                print("\n Show modal to add savings goal \n")
            } label: {
                HStack(spacing: 2){
                    Image(systemName: "plus.circle")
                    Text("Savings Goal")
                }
                .font(.caption)
                .foregroundColor(.accentColor)
            }
    }
    
    private var remainingAmount: some View{
        HStack{
            Spacer()
            Text("£306.51")
                .font(.largeTitle)
                .fontWeight(.black)
                .foregroundColor(.accentColor)
            Spacer()
        }
        .padding()
    }
}


struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
