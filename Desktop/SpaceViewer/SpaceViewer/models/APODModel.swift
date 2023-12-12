//
//  APODModel.swift
//  SpaceViewer
//
//  Created by etudiant on 19/10/2023.
//

    struct APOD: Codable, Identifiable {
        var id: String { date }
        let date: String
        let explanation: String
        let title: String
        let url: String
    }
