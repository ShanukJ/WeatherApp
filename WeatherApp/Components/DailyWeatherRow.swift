//
//  DailyWeatherRow.swift
//  WeatherApp
//
//  Created by Jayamal shanuka Hettiarachchi on 2022-05-21.
//

import SwiftUI

struct DailyWeatherRow: View {
    var logo: String
    var name: String
    var value: String
    
    var body: some View {
        HStack(spacing: 20) {
            Image(systemName: logo)
                .font(.title2)
                .frame(width: 10, height: 10)
                .padding()
                .background(Color(hue: 1.0, saturation: 0.0, brightness: 0.888))
                .cornerRadius(50)
                .foregroundColor(.black)

            
            VStack(alignment: .leading, spacing: 8) {
                Text(name)
                    .font(.caption)
                    .foregroundColor(.black)
                
                Text(value)
                    .bold()
                    .font(.title3)
                    .foregroundColor(.black)
            }
        }
    }
}

struct DailyWeatherRow_Previews: PreviewProvider {
    static var previews: some View {
        DailyWeatherRow(logo: "thermometer", name: "Feels like", value: "8°")
    }
}
