//
//  MainTabView.swift
//  SpaceViewer
//
//  Created by etudiant on 19/10/2023.
//

import SwiftUI
struct MainTabView: View {
    @State private var searchText = ""
    
    var body: some View {
        TabView {
            HomePage()
                .tabItem {
                    Label("Home", systemImage: "house.fill")
                        .foregroundColor(.white)
                }

            ProfilePage()
                .tabItem {
                    Image(systemName: "person.fill")
                        .foregroundColor(.white)
                        .colorMultiply(.white) 
                    Text("Profile")
                }
        }
        .accentColor(.white)
    }
}
