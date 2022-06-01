//
//  WeatherManager.swift
//  WeatherApp
//
//  Created by Jayamal shanuka Hettiarachchi on 2022-05-13.
//

import Foundation
import CoreLocation

class WeatherManager {
    func getCurrentWeather(latitude: CLLocationDegrees, longitude: CLLocationDegrees) async throws -> ResponseBodyByLocation {
        guard let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?lat=\(latitude)&lon=\(longitude)&appid=\("41b9385fa456a464a5ce7855a6ae50a1")&units=metric") else {fatalError("Missing URL")}
        
        let urlRequest = URLRequest(url: url)
        
        let (data, response) = try await URLSession.shared.data(for: urlRequest)
        
        guard (response as? HTTPURLResponse)?.statusCode == 200 else { fatalError("Error fetching weather data")}
        
        let decodedData = try JSONDecoder().decode(ResponseBodyByLocation.self, from: data)
        
        return decodedData
    }
    
    func getCurrentWeatherByCity(city: String) async throws -> ResponseBodyByLocation {
        guard let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?q=\(city)&appid=\("41b9385fa456a464a5ce7855a6ae50a1")&units=metric") else {fatalError("Missing URL")}
        
        let urlRequest = URLRequest(url: url)
        
        let (data, response) = try await URLSession.shared.data(for: urlRequest)
        
        guard (response as? HTTPURLResponse)?.statusCode == 200 else { fatalError("Error fetching weather data")}
        
        let decodedData = try JSONDecoder().decode(ResponseBodyByLocation.self, from: data)
        
        return decodedData
    }
    
    func getForecastWeather(longitude: Double, latitude: Double) async throws -> ForecastResponseBody {
        guard let url = URL(string: "https://api.openweathermap.org/data/2.5/forecast?lat=\(latitude)&lon=\(longitude)&appid=41b9385fa456a464a5ce7855a6ae50a1&units=metric") else {fatalError("Missing URL")}

        let urlRequest = URLRequest(url: url)

        let (data, response) = try await URLSession.shared.data(for: urlRequest)

        guard (response as? HTTPURLResponse)?.statusCode == 200 else { fatalError("Error fetching weather data")}

        let decodedData = try JSONDecoder().decode(ForecastResponseBody.self, from: data)

        return decodedData
    }
    
    func getForecastWeatherForDays(latitude: Double, longtitude: Double, unit: String) async throws -> DailyForecast {
        guard let url = URL(string: "https://api.openweathermap.org/data/2.5/onecall?lat=\(latitude)&lon=\(longtitude)&exclude=hourly,minutely,alerts&appid=41b9385fa456a464a5ce7855a6ae50a1&units=\(unit)") else {fatalError("Missing URL")}

        let urlRequest = URLRequest(url: url)

        let (data, response) = try await URLSession.shared.data(for: urlRequest)

        guard (response as? HTTPURLResponse)?.statusCode == 200 else { fatalError("Error fetching weather data")}

        let decodedData = try JSONDecoder().decode(DailyForecast.self, from: data)

        // print(decodedData)
        return decodedData
    }

    
    
    
}
