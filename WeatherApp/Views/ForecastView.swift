//
//  ForecastView.swift
//  WeatherApp
//
//  Created by Jayamal shanuka Hettiarachchi on 2022-05-16.
//

import SwiftUI

struct ForecastView: View {
    var weatherManager = WeatherManager()
    @State var weather: ForecastResponseBody?
    @State var weatherLocation: ResponseBodyByLocation
    
    var body: some View {
        ZStack(alignment: .leading){
            VStack{
                
                Text(weatherLocation.name).bold().font(.title).foregroundColor(.black)
                
                HStack {
                    Image(systemName: "\(weatherLocation.weather[0].id.weatherIcon())").font(.system(size: 35)).foregroundColor(.black)
                    Spacer()
                    VStack(alignment: .leading, spacing: 5){
                        Text(weatherLocation.weather[0].main.capitalizingFirstLetter()).fontWeight(.regular).foregroundColor(.black)
                        Text("Today, \(Date().formatted(.dateTime.month().day().hour().minute()))").fontWeight(.light).font(.system(size: 14)).foregroundColor(.black)
                    }
                    Spacer()
                    Text("\(weatherLocation.main.temp.roundDouble() + "°")").fontWeight(.semibold).font(.system(size: 25)).foregroundColor(.black)
                    Spacer()
                }.padding().background(Color.white).cornerRadius(10, corners: [.topLeft, .topRight, .bottomLeft, .bottomRight])
                
                Spacer()
                
                    .onAppear {
                        
                        UITableView.appearance().backgroundColor = .clear
                        
                        
                        Task {
                            do {
                                weather = try await weatherManager.getForecastWeather(longitude: weatherLocation.coord.lon, latitude: weatherLocation.coord.lat)
                                
                            } catch {
                                print("Error occured while fetching your weather results: \(error)")
                            }
                        }
                    }
                
                if let data = weather?.list{
                    
                    List(0 ..< data.count) { index in
                        let item = data[index]
                        Group {
                            HStack {
                                //                                item.iconImage.padding()
                                Image(systemName: "\(item.weather[0].id.weatherIcon())").font(.system(size: 35)).foregroundColor(.black)
                                Spacer()
                                VStack(alignment: .leading, spacing: 5){
                                    Text(item.weather[0].description.capitalizingFirstLetter()).fontWeight(.regular).foregroundColor(.black)
                                    Text(item.dt.getDtFromUnix()).fontWeight(.light).font(.system(size: 14)).foregroundColor(.black)
                                }
                                Spacer()
                                Text("\(item.main.temp.roundDouble() + "°")").fontWeight(.semibold).font(.system(size: 25)).foregroundColor(.black)
                                Spacer()
                            }.padding().background(Color.white).cornerRadius(10, corners: [.topLeft, .topRight, .bottomLeft, .bottomRight])
                        }.listRowBackground(Color.clear)
                    }.listStyle(PlainListStyle()).background(Color.clear).listRowInsets(.init(top: 0, leading: 0, bottom: 0, trailing: 0)).navigationBarHidden(true)
                    
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

struct ForecastView_Previews: PreviewProvider {
    static var previews: some View {
        ForecastView(weatherLocation: previewWeather)
    }
}
