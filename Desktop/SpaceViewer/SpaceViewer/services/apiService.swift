//
//  apiService.swift
//  SpaceViewer
//
//  Created by etudiant on 19/10/2023.
//

import SwiftUI
import Combine

class APIService: ObservableObject {
    @Published var selectedDate: Date = Date()
    @Published var apod: APOD?
    @Published var apikey = "2Pqpenw70LJtj7qE3AXaN2cU0mp2tiPGhCFpRR5O"
    
    var baseURL: String {
        return "https://api.nasa.gov/planetary/apod?api_key=\(apikey)&date="
    }

    init() {
        print("APIService initialized")
        print("api_key =\(apikey)")
    }

    func fetchAPOD(for date: Date) {
        print("getting the data")
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let dateString = dateFormatter.string(from: date)
        
        if let url = URL(string: baseURL + dateString) {
            URLSession.shared.dataTask(with: url) { data, response, error in
                if let error = error {
                    print("Network Error: \(error.localizedDescription)")
                    return
                }

                if let data = data {
                    print("Received data: \(String(data: data, encoding: .utf8) ?? "No data string")") // Print the raw data
                    
                    let decoder = JSONDecoder()
                    do {
                        let apodData = try decoder.decode(APOD.self, from: data)
                        DispatchQueue.main.async {
                            self.apod = apodData
                        }
                    } catch {
                        print("Decoding Error: \(error.localizedDescription)")
                    }
                } else {
                    print("No data received from the API.")
                }
            }.resume()
        } else {
            print("Invalid URL.")
        }
    }
}
