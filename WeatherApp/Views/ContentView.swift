//
//  ContentView.swift
//  WeatherApp
//
//  Created by Jayamal shanuka Hettiarachchi on 2022-05-13.
//

import SwiftUI

struct ContentView: View {
    @StateObject var locationManager = LocationManager()
    var weatherManager = WeatherManager()
    @State var weather: ResponseBodyByLocation?
    
    var body: some View {
        VStack {
            
            if let location = locationManager.location{
                if let weather = weather {
                    WeatherView(weather: weather)
                } else {
                    LoadingView().task {
                        do {
                            weather = try await weatherManager.getCurrentWeather(latitude: location.latitude, longitude: location.longitude)
                        } catch {
                            print("Error getting weather data: \(error)")
                        }
                    }
                }
            } else {
                if locationManager.isLoading {
                    LoadingView()
                } else {
                    WelcomeView().environmentObject(locationManager)
                }
            }
            
        }
        .background(
            LinearGradient(gradient: Gradient(colors: [.init(hex: 0x47BFDF), .init(hex: 0x4A91FF)]), startPoint: .top, endPoint: .bottom)
        )
        //.preferredColorScheme(.dark)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
