//
//  MainTabView.swift
//  WeatherApp
//
//  Created by Jayamal shanuka Hettiarachchi on 2022-05-21.
//

import SwiftUI

struct MainTabView: View {
    @State var weather: ResponseBodyByLocation
    
    
    
    var body: some View {
        TabView {

            if let weather = weather{
                DailyForecastView(weatherLocation: weather)
                    .tabItem {
                        Label("Daily", systemImage: "calendar")
                    }.navigationBarTitle(Text(""), displayMode: .inline)
                    
            }
            

            if let weather = weather{
                ForecastView(weatherLocation: weather)
                    .tabItem {
                        Label("Hourly", systemImage: "calendar.badge.clock")
                    }.navigationBarTitle(Text(""), displayMode: .inline)
            }

        }.onAppear {
            if #available(iOS 15.0, *) {
                let appearance = UITabBarAppearance()
                UITabBar.appearance().scrollEdgeAppearance = appearance
            }
        }
        
    }
}

struct MainTabView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView(weather: previewWeather)
    }
}
