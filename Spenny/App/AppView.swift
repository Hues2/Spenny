//
//  AppView.swift
//  Spenny
//
//  Created by Greg Ross on 11/09/2022.
//

import SwiftUI

struct AppView: View {
    @StateObject var dataManager: DataManager
    
    init(isEditingMonth: Binding<Bool>){
        self._dataManager = StateObject(wrappedValue: DataManager(coreDataManager: CoreDataManager(), isEditingMonth: isEditingMonth))
        
        // correct the transparency bug for Tab bars
        let tabBarAppearance = UITabBarAppearance()
        tabBarAppearance.configureWithOpaqueBackground()
        tabBarAppearance.backgroundColor = UIColor(Color.backgroundColor)
        UITabBar.appearance().scrollEdgeAppearance = tabBarAppearance

    }
    
    var body: some View {
        TabView {
            // MARK: Home View
            HomeView(dataManager: dataManager)
                .tabItem {
                    Label {
                        Text("Track")
                    } icon: {
                        Image(systemName: "dollarsign.square.fill")
                    }
                    
                }
            
            // MARK: Saved Months
            SavedMonthsView(dataManager: dataManager)
                .tabItem {
                    Label{
                        Text("Saved")
                    } icon: {
                        Image(systemName: "list.dash")
                    }
                }
        }
        .background(
            Color.backgroundColor.ignoresSafeArea()
        )
        .withGetStartedModal(dataManager: dataManager, isNewUser: $dataManager.isNewUser)
    }
}
