//
//  AppView.swift
//  Spenny
//
//  Created by Greg Ross on 11/09/2022.
//

import SwiftUI

struct AppView: View {
    @StateObject var dataManager = DataManager()
    
    // This showModal is here, as the modal has to go over the tab bar
    @State var showModal: Bool = false
    
    var body: some View {
        TabView {
            HomeView(showModal: $showModal)
                .tabItem {
                    Label {
                        Text("Track")
                    } icon: {
                        Image(systemName: "dollarsign.square.fill")
                    }

                }
        }
        .withGetStartedModal(showModal: $showModal)
    }
}
