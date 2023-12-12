//
//  buttons.swift
//  SpaceViewer
//
//  Created by etudiant on 19/10/2023.
//

import SwiftUI

struct HapticButton: View {
    var label: String
    var action: () -> Void
    
    var body: some View {
        Button(action: {
            let generator = UIImpactFeedbackGenerator(style: .medium)
            generator.impactOccurred()
            action()
        }) {
            Text(label)
        }
    }
}
