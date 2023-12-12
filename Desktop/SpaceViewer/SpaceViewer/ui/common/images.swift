//
//  images.swift
//  SpaceViewer
//
//  Created by etudiant on 19/10/2023.
//

import SwiftUI
struct LongPressImageView: View {
    var imageURL: String
    var action: () -> Void
    
    var body: some View {
        AsyncImage(url: URL(string: imageURL)) { phase in
            switch phase {
            case .success(let image):
                image.resizable().scaledToFit()
            case .failure(_):
                Image(systemName: "photo")
                    .resizable()
                    .scaledToFit()
            case .empty:
                ProgressView()
            @unknown default:
                EmptyView()
            }
        }
        .gesture(
            LongPressGesture(minimumDuration: 0.5).onEnded { _ in
                action()
            }
        )
    }
}
