//
//  ForecastResponseModel.swift
//  WeatherApp
//
//  Created by Jayamal shanuka Hettiarachchi on 2022-05-20.
//

import Foundation

struct ForecastResponseBody: Decodable {
    var cod: String
    var list: [forecastList]
    
    
    struct forecastList: Decodable {
        var main: ForecastMainResponse
        var weather: [ForecastWeatherResponse]
        var clouds: ForecastCloudResponse
        var dt: Double
    }
    
    struct ForecastMainResponse:Decodable{
        var temp: Double
        var temp_min: Double
        var temp_max: Double
        var humidity: Double
        var pressure: Double
    }
    
    struct ForecastWeatherResponse:Decodable{
        var id: Double
        var main: String
        var description: String
        
    }
    
    struct ForecastCloudResponse:Decodable{
        var all: Double
    }
    
    
}
