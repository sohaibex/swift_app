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
                    Image(systemName: "house.fill")
                    Text("Home")
                }
            
            SearchView(searchText: $searchText)
                .tabItem {
                    Image(systemName: "magnifyingglass")
                    Text("Search")
                }
            
            // ... Add other sections as needed
        }
    }
}

struct SearchView: View {
    @Binding var searchText: String
    
    var body: some View {
        VStack {
            SearchBar(text: $searchText)
            // Use 'searchText' to filter or fetch your data
            Spacer()
        }
    }
}

struct SearchBar: View {
    @Binding var text: String
    
    var body: some View {
        HStack {
            TextField("Search...", text: $text)
                .padding(7)
                .background(Color(.systemGray6))
                .cornerRadius(8)
                .padding(.horizontal, 10)
        }
    }
}
