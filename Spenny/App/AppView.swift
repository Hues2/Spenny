//
//  AppView.swift
//  Spenny
//
//  Created by Greg Ross on 11/09/2022.
//

import SwiftUI

struct AppView: View {
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

struct AppView_Previews: PreviewProvider {
    static var previews: some View {
        AppView()
    }
}
