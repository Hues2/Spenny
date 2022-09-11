//
//  AppView.swift
//  Spenny
//
//  Created by Greg Ross on 11/09/2022.
//

import SwiftUI

struct AppView: View {
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Label {
                        Text("Home")
                    } icon: {
                        Image(systemName: "house")
                    }

                }
        }
    }
}

struct AppView_Previews: PreviewProvider {
    static var previews: some View {
        AppView()
    }
}
