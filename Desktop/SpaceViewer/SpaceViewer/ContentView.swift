//
//  ContentView.swift
//  SpaceViewer
//
//  Created by etudiant on 19/10/2023.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            HomePage()
                .accentColor(Color("StarWhite"))
        }
    }
}


#Preview {
    ContentView()
}
