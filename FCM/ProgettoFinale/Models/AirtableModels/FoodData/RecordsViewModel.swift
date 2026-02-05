//
//  RecordsViewModel.swift
//  Airtable
//
//  Created by Giusy Di Paola on 02/01/25.
//


import Foundation // Provides essential tools for network requests and JSON handling.
import Observation // Used to observe changes in the view model and update the UI automatically.


@Observable // This makes the class observable so SwiftUI can react to changes in its properties.
class RecordsViewModel {
    var records: [Record] = [] // A list to store fetched records from Airtable.
    
    private let foodDataTableURL = "https://api.airtable.com/v0/appqEjD69spsgV8hE/tblBKegW21IrRoD1D"
    private let apiKey = "Bearer patsiRnzgEQnESq8h.78aea7e64b9b793e8b9f14947d3e3b207167e614ba092ee849212f13ec0b09d6"
    
    // Function to fetch records from Airtable.
    func fetchRecords() {
        guard let url = URL(string: foodDataTableURL) else { return } // Ensure the URL is valid.

        var request = URLRequest(url: url) // Create a URL request object.
        request.setValue(apiKey, forHTTPHeaderField: "Authorization") // Add the API key to the request headers.
        request.setValue("application/json", forHTTPHeaderField: "Content-Type") // Specify the content type as JSON.
        request.httpMethod = "GET" // Set the HTTP method to GET.

        // Perform the network request.
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error { // Handle any errors that occur.
                print("Error fetching records: \(error.localizedDescription)")
                return
            }

            if let data = data { // Ensure we have data to work with.
                do {
                    let response = try JSONDecoder().decode(AirtableResponse.self, from: data) // Decode the JSON into our model.
                    DispatchQueue.main.async {
                        self.records = response.records // Update the records property on the main thread.
                    }
                } catch {
                    print("Error decoding response: \(error.localizedDescription)") // Handle decoding errors.
                }
            }
        }.resume() // Start the network task.
    }
}
