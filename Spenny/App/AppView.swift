//
//  AppView.swift
//  Spenny
//
//  Created by Greg Ross on 11/09/2022.
//

import SwiftUI

struct AppView: View {
    @StateObject var dataManager = DataManager()
    
    
    init(){
        // correct the transparency bug for Tab bars
        let tabBarAppearance = UITabBarAppearance()
        tabBarAppearance.configureWithOpaqueBackground()
        tabBarAppearance.backgroundColor = UIColor(Color.backgroundColor)
        UITabBar.appearance().scrollEdgeAppearance = tabBarAppearance
        // correct the transparency bug for Navigation bars
//        let navigationBarAppearance = UINavigationBarAppearance()
//        navigationBarAppearance.configureWithOpaqueBackground()
//        UINavigationBar.appearance().scrollEdgeAppearance = navigationBarAppearance
    }
    
    var body: some View {
        TabView {
            HomeView(dataManager: dataManager)
                .tabItem {
                    Label {
                        Text("Track")
                    } icon: {
                        Image(systemName: "dollarsign.square.fill")
                    }
                    
                }
        }
        .background(
            Color.backgroundColor.ignoresSafeArea()
        )
        .withGetStartedModal(dataManager: dataManager, isNewUser: $dataManager.isNewUser)
    }
}
