//
//  annimations.swift
//  SpaceViewer
//
//  Created by etudiant on 19/10/2023.
//

import SwiftUI
struct AnimatedAsyncImage: View {
    var imageURL: String
    
    @State private var imageIsLoaded = false
    
    var body: some View {
        AsyncImage(url: URL(string: imageURL)) { phase in
            switch phase {
            case .success(let image):
                image.resizable()
                     .scaledToFit()
                     .onAppear {
                         withAnimation {
                             imageIsLoaded = true
                         }
                     }
                     .scaleEffect(imageIsLoaded ? 1 : 0.9)
                     .opacity(imageIsLoaded ? 1 : 0.7)
            case .failure(_):
                Image(systemName: "photo")
                    .resizable()
                    .scaledToFit()
            case .empty:
                ProgressView().progressViewStyle(CircularProgressViewStyle(tint: .white))
            @unknown default:
                EmptyView()
            }
        }
    }
}
