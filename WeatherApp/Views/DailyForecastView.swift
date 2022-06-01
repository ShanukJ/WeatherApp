//
//  DailyForecastView.swift
//  WeatherApp
//
//  Created by Jayamal shanuka Hettiarachchi on 2022-05-21.
//

import SwiftUI

struct DailyForecastView: View {
    var weatherManager = WeatherManager()
    @State var weather: ForecastResponseBody?
    @State var dailyWeather: DailyForecast?
    @State var weatherLocation: ResponseBodyByLocation
    
    @State var selected = 1

    func temperatureInFahrenheit(temperature: Double) -> Double {
          let fahrenheitTemperature = temperature * 9 / 5 + 32
          return fahrenheitTemperature
    }
    
    func windSpeed(speed: Double) -> Double {
          let newSpeed = speed * 2.236936
          return newSpeed
    }
    
    var body: some View {
        ZStack(alignment: .leading){
            VStack{
                
                Text(weatherLocation.name).bold().font(.title).foregroundColor(.black)
                
                Picker(selection: $selected, label: Text("Picker"), content: {
                    Text("°C").tag(1).foregroundColor(.black)
                    Text("°F").tag(2).foregroundColor(.black)
                }).pickerStyle(SegmentedPickerStyle())
                
                if selected == 1{
                    
                    VStack{
                        
                        HStack {
                            Image(systemName: "\(weatherLocation.weather[0].id.weatherIcon())").font(.system(size: 35)).foregroundColor(.black)
                            Spacer()
                            VStack(alignment: .leading, spacing: 5){
                                Text(weatherLocation.weather[0].main.capitalizingFirstLetter()).fontWeight(.bold).foregroundColor(.black)
                                Text("Today, \(Date().formatted(.dateTime.month().day().hour().minute()))").fontWeight(.light).font(.system(size: 14)).foregroundColor(.black)
                            }
                            Spacer()
                            Text("\(weatherLocation.main.temp.roundDouble() + "°")").fontWeight(.bold).font(.system(size: 25)).foregroundColor(.black)
                            Spacer()
                        }
                        
                        
                        //Fahrenheit = (Celsius* 9 / 5) + 32
                        
                        HStack {
                            DailyWeatherRow(logo: "wind", name: "Wind speed", value: (weatherLocation.wind.speed.roundDouble() + " m/s"))
                            Spacer()
                            DailyWeatherRow(logo: "humidity", name: "Humidity", value: "\(weatherLocation.main.humidity.roundDouble())%")
                        }
                        
                        
                        HStack {
                            DailyWeatherRow(logo: "arrow.left.arrow.right", name: "Wind Direction", value: (weatherLocation.wind.deg.convertWindDirection()))
                            Spacer()
                            DailyWeatherRow(logo: "cloud", name: "Clouds", value:
                                        "\(weatherLocation.clouds.all.roundDouble())%")
                        }
                        
                    }.padding().background(Color.white).cornerRadius(10, corners: [.topLeft, .topRight, .bottomLeft, .bottomRight])

                    Spacer()
                    
                        .onAppear {
                            
                            UITableView.appearance().backgroundColor = .clear
                            
                            
                            Task {
                                do {
                                    dailyWeather = try await weatherManager.getForecastWeatherForDays(latitude: weatherLocation.coord.lat, longtitude: weatherLocation.coord.lon, unit: "metric")
                                    
                                    
                                } catch {
                                    print("Error occured while fetching your weather results: \(error)")
                                }
                            }
                        }
                    
                    if let data = dailyWeather?.daily{
                        
                        List(0 ..< data.count) { index in
                            let item = data[index]
                            Group {
                                HStack {
                                    //                                item.iconImage.padding()
                                    VStack{
                                        
                                        HStack {
                                            Image(systemName: "\(item.weather[0].id.weatherIcon())").font(.system(size: 35)).foregroundColor(.black)
                                            Spacer()
                                            VStack(alignment: .leading, spacing: 5){
                                                Text(item.weather[0].description.capitalizingFirstLetter()).fontWeight(.bold).foregroundColor(.black)
                                                Text(item.dt.getDtFromUnix()).fontWeight(.light).font(.system(size: 14)).foregroundColor(.black)
                                            }
                                            Spacer()
                                            Text("\(item.temp.max.roundDouble() + "°")").fontWeight(.bold).font(.system(size: 25)).foregroundColor(.black)
                                            Spacer()
                                        }
                                        
                                        HStack {
                                            DailyWeatherRow(logo: "wind", name: "Wind speed", value: (item.wind_speed.roundDouble() + " m/s"))
                                            Spacer()
                                            DailyWeatherRow(logo: "humidity", name: "Humidity", value: "\(item.humidity.roundDouble())%")
                                        }
                                        
                                        
                                        HStack {
                                            DailyWeatherRow(logo: "arrow.left.arrow.right", name: "Wind Direction", value: (item.wind_deg.convertWindDirection()))
                                            Spacer()
                                            DailyWeatherRow(logo: "cloud", name: "Clouds", value:
                                                                "\(item.clouds.roundDouble())%")
                                        }
                                        
                                    }
                                }.padding().background(Color.white).cornerRadius(10, corners: [.topLeft, .topRight, .bottomLeft, .bottomRight])
                            }.listRowBackground(Color.clear)
                        }.listStyle(PlainListStyle()).background(Color.clear).listRowInsets(.init(top: 0, leading: 0, bottom: 0, trailing: 0)).navigationBarHidden(true)
                        
                    }
                    
                    
                }else {
                    
                    VStack{
                        
                        HStack {
                            Image(systemName: "\(weatherLocation.weather[0].id.weatherIcon())").font(.system(size: 35)).foregroundColor(.black)
                            Spacer()
                            VStack(alignment: .leading, spacing: 5){
                                Text(weatherLocation.weather[0].main.capitalizingFirstLetter()).fontWeight(.bold).foregroundColor(.black)
                                Text("Today, \(Date().formatted(.dateTime.month().day().hour().minute()))").fontWeight(.light).font(.system(size: 14)).foregroundColor(.black)
                            }
                            Spacer()
                            Text("\(temperatureInFahrenheit(temperature: weatherLocation.main.temp).roundDouble() + "°")").fontWeight(.bold).font(.system(size: 25)).foregroundColor(.black)
                            Spacer()
                        }
                        
                        HStack {
                            DailyWeatherRow(logo: "wind", name: "Wind speed", value: (windSpeed(speed: weatherLocation.wind.speed).roundDouble() + " mph"))
                            Spacer()
                            DailyWeatherRow(logo: "humidity", name: "Humidity", value: "\(weatherLocation.main.humidity.roundDouble())%")
                        }
                        
                        
                        HStack {
                            DailyWeatherRow(logo: "arrow.left.arrow.right", name: "Wind Direction", value: (weatherLocation.wind.deg.convertWindDirection()))
                            Spacer()
                            DailyWeatherRow(logo: "cloud", name: "Clouds", value:
                                        "\(weatherLocation.clouds.all.roundDouble())%")
                        }
                        
                    }.padding().background(Color.white).cornerRadius(10, corners: [.topLeft, .topRight, .bottomLeft, .bottomRight])

                    Spacer()
                    
                        .onAppear {
                            
                            UITableView.appearance().backgroundColor = .clear
                            
                            
                            Task {
                                do {
                                    dailyWeather = try await weatherManager.getForecastWeatherForDays(latitude: weatherLocation.coord.lat, longtitude: weatherLocation.coord.lon, unit: "imperial")
                                    
                                    
                                } catch {
                                    print("Error occured while fetching your weather results: \(error)")
                                }
                            }
                        }
                    
                    if let data = dailyWeather?.daily{
                        
                        List(0 ..< data.count) { index in
                            let item = data[index]
                            Group {
                                HStack {
                                    //                                item.iconImage.padding()
                                    VStack{
                                        
                                        HStack {
                                            Image(systemName: "\(item.weather[0].id.weatherIcon())").font(.system(size: 35)).foregroundColor(.black)
                                            Spacer()
                                            VStack(alignment: .leading, spacing: 5){
                                                Text(item.weather[0].description.capitalizingFirstLetter()).fontWeight(.bold).foregroundColor(.black)
                                                Text(item.dt.getDtFromUnix()).fontWeight(.light).font(.system(size: 14)).foregroundColor(.black)
                                            }
                                            Spacer()
                                            Text("\(item.temp.max.roundDouble() + "°")").fontWeight(.bold).font(.system(size: 25)).foregroundColor(.black)
                                            Spacer()
                                        }
                                        
                                        HStack {
                                            DailyWeatherRow(logo: "wind", name: "Wind speed", value: (item.wind_speed.roundDouble() + " mph"))
                                            Spacer()
                                            DailyWeatherRow(logo: "humidity", name: "Humidity", value: "\(item.humidity.roundDouble())%")
                                        }
                                        
                                        
                                        HStack {
                                            DailyWeatherRow(logo: "arrow.left.arrow.right", name: "Wind Direction", value: (item.wind_deg.convertWindDirection()))
                                            Spacer()
                                            DailyWeatherRow(logo: "cloud", name: "Clouds", value:
                                                                "\(item.clouds.roundDouble())%")
                                        }
                                        
                                    }
                                }.padding().background(Color.white).cornerRadius(10, corners: [.topLeft, .topRight, .bottomLeft, .bottomRight])
                            }.listRowBackground(Color.clear)
                        }.listStyle(PlainListStyle()).background(Color.clear).listRowInsets(.init(top: 0, leading: 0, bottom: 0, trailing: 0)).navigationBarHidden(true)
                        
                    }
                    
                }
                
            }.frame(maxWidth: .infinity,  maxHeight: .infinity )
                .padding([.leading, .trailing], 24)
        }
        .background(
            LinearGradient(gradient: Gradient(colors: [.init(hex: 0x47BFDF), .init(hex: 0x4A91FF)]), startPoint: .top, endPoint: .bottom)
        )
//        .navigationBarHidden(true)
    }

}

struct DailyForecastView_Previews: PreviewProvider {
    static var previews: some View {
        DailyForecastView(weatherLocation: previewWeather)
    }
}
