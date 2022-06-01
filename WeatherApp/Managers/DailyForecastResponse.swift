//
//  DailyForecastResponse.swift
//  WeatherApp
//
//  Created by Jayamal shanuka Hettiarachchi on 2022-05-21.
//

import Foundation

struct DailyForecast: Decodable {
    var current: CurrentForecast
    var daily: [DailyForecastSet]
    
    
    struct CurrentForecast: Decodable {
        var dt: Double
        var temp: Double
        var pressure: Double
        var humidity: Double
        var visibility: Double
        var wind_speed: Double
        var wind_deg: Double
        var weather: [TodayWeatherForecast]
    }
    
    struct DailyForecastSet: Decodable {
        var dt: Double
        var temp: TemperatureResults
        var pressure: Double
        var humidity: Double
        var wind_speed: Double
        var wind_deg: Double
        var clouds: Double
        var weather: [DailyWeatherForecast]
    }
    
    
    struct TodayWeatherForecast: Decodable {
        var id: Double
        var description: String
    }
    
    struct DailyWeatherForecast: Decodable {
        var id: Double
        var description: String
    }
    
    struct TemperatureResults: Decodable {
        var min: Double
        var max: Double
    }
    
}
