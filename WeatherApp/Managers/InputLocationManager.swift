//
//  InputLocationManager.swift
//  WeatherApp
//
//  Created by Jayamal shanuka Hettiarachchi on 2022-05-21.
//

import Foundation
import SwiftUI

class InputValidation {
    
   
    func getGeoValidation(location: String) async throws -> Int {
        
        var count = 0
        
        guard let url = URL(string: "https://api.openweathermap.org/geo/1.0/direct?q=\(location)&limit=5&&appid=41b9385fa456a464a5ce7855a6ae50a1") else { fatalError("Missing API URL to collect results, check url and arguments before trying again.") }
        
        let urlRequest = URLRequest(url: url)
        
        let (data, response) = try await URLSession.shared.data(for: urlRequest)
        
        guard (response as? HTTPURLResponse)?.statusCode == 200 else { fatalError("Error occured while fetching weather data") }
        
        let decodedData = try JSONDecoder().decode([LocationSet].self, from: data)
        
        for item in decodedData {
            if item.name.lowercased() == location.lowercased() {
                count = count+1
            }
        }
        
        return count

    }
    
    
}
