//
//  WeatherView.swift
//  WeatherApp
//
//  Created by Jayamal shanuka Hettiarachchi on 2022-05-14.
//

//_ in Task {
//    print("dsfadf")
//    do {
//       newweather = try await weatherManager.getCurrentWeatherByCity(city: title)
//        print(newweather as Any)
//    } catch {
//        print("Error occured while fetching your weather results: \(error)")
//    }
//}


import SwiftUI

struct WeatherView: View {
    
    @State var updater: Bool = false
    @State private var displayAlert = false
    
    @State private var isRenameAlertPresented = false
    @State private var title = "Old title"
    @State var weather: ResponseBodyByLocation
    var weatherManager = WeatherManager()
    var inputLocationManager = InputValidation()
    private func alert() {
        isRenameAlertPresented = true
    }
    
    var body: some View {
        NavigationView {
            ZStack(alignment: .leading) {
                VStack(spacing: 16) {
                    Color.clear
                        .overlay(
                            VStack {
                                HStack(spacing: 20) {
                                    
                                    
                                    Image(systemName: "mappin.and.ellipse").font(.system(size: 20)).foregroundColor(.black)
                                    
                                    Text(weather.name).bold().font(.title).foregroundColor(.black)
                                    
                                    Spacer()
                                    
                                    Button(action: alert) {
                                        HStack {
                                            Image(systemName: "location.viewfinder").font(.system(size: 25)).foregroundColor(.black)
                                        }
                                    }
                                    
                                    .textFieldAlert(
                                        isPresented: $isRenameAlertPresented,
                                        title: "City",
                                        text: "",
                                        placeholder: "Enter a city",
                                        action: {
                                            
                                            newText in
                                            title = newText ?? ""
                                            
                                            
                                            Task {
                                                if !title.isEmpty {
                                                    
                                                    do {
                                                        
                                                        let allowedCharacterset = CharacterSet(charactersIn: "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ")
                                                        
                                                        let locationResults = try await inputLocationManager.getGeoValidation(location: title)
                                                        
                                                        if locationResults > 0 && !(title.rangeOfCharacter(from: allowedCharacterset.inverted) != nil) {
                                                            
                                                            weather = try await weatherManager.getCurrentWeatherByCity(city: title)
                                                            
                                                        }else{
                                                            displayAlert = true
                                                        }
                                                        
                                                        
                                                    } catch {
                                                        print("Error occured while fetching your weather results: \(error)")
                                                    }
                                                }
                                                
                                                //                                                }else{
                                                //                                                    displayAlert = true
                                                //                                                }
                                                
                                            }
                                        }
                                    )
                                }
                                .frame(maxWidth: .infinity, alignment: .leading)
                            }
                        )
                    VStack {
                        //Spacer()
                        VStack(alignment: .leading, spacing: 20) {
                            VStack(alignment: .center, spacing: 5) {
                                
                                Text("Today, \(Date().formatted(.dateTime.month().day().hour().minute()))")
                                    .fontWeight(.light)
                                    .padding()
                                    .foregroundColor(.black)
                                
                                HStack {
                                    
                                    AsyncImage(url: URL(string: "\(weather.weather[0].id.weatherImage())")) { image in
                                        image
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                        //.frame(width: 120)
                                    } placeholder: {
                                        ProgressView()
                                    }
                                    
                                    Text(weather.main.feelsLike.roundDouble() + "°")
                                        .font(.system(size: 75))
                                        .fontWeight(.bold)
                                        .padding(5)
                                        .foregroundColor(.black)
                                }
                                
                                Text("\(weather.weather[0].main)")
                                    .font(.system(size: 30))
                                    .fontWeight(.bold)
                                
                            }
                            .frame(maxWidth: .infinity, alignment: .center)
                            
                            HStack {
                                WeatherRow(logo: "wind", name: "Wind speed", value: (weather.wind.speed.roundDouble() + " m/s"))
                                Spacer()
                                WeatherRow(logo: "humidity", name: "Humidity", value: "\(weather.main.humidity.roundDouble())%")
                            }
                            
                            
                            HStack {
                                WeatherRow(logo: "arrow.left.arrow.right", name: "Wind Direction", value: (weather.wind.deg.convertWindDirection()))
                                Spacer()
                                WeatherRow(logo: "cloud", name: "Clouds", value:
                                            "\(weather.clouds.all.roundDouble())%")
                            }
                            
                            HStack {
                                
                                Spacer()
                                
                                WeatherRow(logo: "rectangle.compress.vertical", name: "Pressure", value: (weather.main.pressure.roundDouble() + " hPa") )
                                
                                Spacer()
                                
                            }
                            
                            //Spacer()
                            
                            HStack {
                                
                                if let weather = weather {
                                    NavigationLink(destination: MainTabView(weather: weather)) {
                                        Label("Forecast report", systemImage: "newspaper")
                                            .padding()
                                            .background(Color(hue: 1.0, saturation: 0.0, brightness: 0.888))
                                            .cornerRadius(20, corners: [.topLeft, .topRight, .bottomLeft, .bottomRight])
                                    }
                                }
                                
                            }
                            .frame(maxWidth: .infinity, alignment: .center)
                            
                        }
                        .frame(maxWidth: .infinity, alignment: .leading).padding().padding(.bottom,20).foregroundColor(Color(hue: 0.701, saturation: 0.933, brightness: 0.337))
                        .background(.white).cornerRadius(20, corners: [.topLeft, .topRight, .bottomLeft, .bottomRight])
                        
                    }
                    Color.clear.overlay(
                        HStack {
                            
                            Image(systemName: "sun.min.fill").font(.system(size: 15))
                            
                            Text("openweathermap").font(.system(size: 15))
                            
                        }
                    )
                    
                }
                .padding([.leading, .trailing], 24)
            }
            .edgesIgnoringSafeArea(.bottom)
            .background(
                LinearGradient(gradient: Gradient(colors: [.init(hex: 0x47BFDF), .init(hex: 0x4A91FF)]), startPoint: .top, endPoint: .bottom)
            )
            .navigationBarHidden(true)
            .alert(isPresented: $displayAlert) {
                Alert(
                    title: Text("Oops!.. Location not found"),
                    message: Text("Your location does not exist on our maps, or your input contains special or numerical characters. Please recheck the information before proceeding."),
                    dismissButton: .default(Text("Ok"), action: {
                        displayAlert = false
                    })
                )
            }
        }
        
    }
}

struct WeatherView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherView(weather: previewWeather)
    }
}
