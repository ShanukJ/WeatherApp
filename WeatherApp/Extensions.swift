//
//  Extwnsions.swift
//  WeatherApp
//
//  Created by Jayamal shanuka Hettiarachchi on 2022-05-14.
//

import Foundation
import SwiftUI

extension Double {
    func roundDouble() -> String {
        return String(format: "%.0f", self)
    }
}

extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCorner(radius: radius, corners: corners) )
    }
}

struct RoundedCorner: Shape {
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}

extension Color {
    init(hex: Int, opacity: Double = 1.0) {
        let red = Double((hex & 0xff0000) >> 16) / 255.0
        let green = Double((hex & 0xff00) >> 8) / 255.0
        let blue = Double((hex & 0xff) >> 0) / 255.0
        self.init(.sRGB, red: red, green: green, blue: blue, opacity: opacity)
    }
}

extension Double {
    func convertWindDirection() -> String{
        switch self {
            
        case 0...11:
            return "N"
        case 12...33:
            return "NNE"
        case 34...56:
            return "NE"
        case 57...78:
            return "ENE"
        case 79...101:
            return "E"
        case 102...123:
            return "ESE"
        case 124...146:
            return "SE"
        case 147...168:
            return "SSE"
        case 169...191:
            return "S"
        case 192...213:
            return "SSW"
        case 214...236:
            return "SW"
        case 237...258:
            return "WSW"
        case 259...281:
            return "W"
        case 282...303:
            return "WNW"
        case 304...326:
            return "NW"
        case 327...348:
            return "NNW"
        case 349...360:
            return "N"
            
        default:
            return "CLM"
        }
    }
}

extension Double {
    func weatherImage() -> String{
        switch self {
            
        case 200...232:
            return "https://res.cloudinary.com/dgly8b9lq/image/upload/v1652561168/WeatherApp/thnderstorm_tjowbm.png"
        case 300...321:
            return "https://res.cloudinary.com/dgly8b9lq/image/upload/v1652559528/WeatherApp/rainy_dx7wuz.png"
        case 500...531:
            return "https://res.cloudinary.com/dgly8b9lq/image/upload/v1652559528/WeatherApp/rainy_dx7wuz.png"
        case 600...622:
            return "https://res.cloudinary.com/dgly8b9lq/image/upload/v1652561185/WeatherApp/snowy_knqgmn.png"
        case 701...781:
            return "https://res.cloudinary.com/dgly8b9lq/image/upload/v1653140480/WeatherApp/Group_46_be6jxo.png"
        case 800:
            return "https://res.cloudinary.com/dgly8b9lq/image/upload/v1652531361/WeatherApp/slight_touch_happyday_e78nn1.png"
        case 801...804:
            return "https://res.cloudinary.com/dgly8b9lq/image/upload/v1652561248/WeatherApp/cloudy_ifrpe2.png"
            
            
        default:
            return "https://res.cloudinary.com/dgly8b9lq/image/upload/v1652531424/WeatherApp/partly_cloudy_bpuw98.png"
        }
    }
}

extension Double {
    func weatherIcon() -> String{
        switch self {
            
        case 200...232:
            return "cloud.bolt"
        case 300...321:
            return "cloud.drizzle"
        case 500...531:
            return "cloud.heavyrain"
        case 600...622:
            return "snow"
        case 701...781:
            return "wind"
        case 800:
            return "sun.max"
        case 801...804:
            return "cloud"
            
            
        default:
            return "cloud.sun"
        }
    }
}

extension Double {
    func getDtFromUnix() -> String{
        let date = Date(timeIntervalSince1970: self)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMM yyyy HH:mm"
        let localDate = dateFormatter.string(from: date)
        return localDate
    }
}

extension View {
    
    public func textFieldAlert(
        isPresented: Binding<Bool>,
        title: String,
        text: String = "",
        placeholder: String = "",
        action: @escaping (String?) -> Void
    ) -> some View {
        self.modifier(TextFieldAlertModifier(isPresented: isPresented, title: title, text: text, placeholder: placeholder, action: action))
    }
    
}

extension UIColor {
    
    static let flatDarkBackground = UIColor(red: 36, green: 36, blue: 36)
    static let flatDarkCardBackground = UIColor(red: 46, green: 46, blue: 46)
    
    convenience init(red: Int, green: Int, blue: Int, a: CGFloat = 1.0) {
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: a)
    }
}

extension Color {
    public init(decimalRed red: Double, green: Double, blue: Double) {
        self.init(red: red / 255, green: green / 255, blue: blue / 255)
    }
    
    public static var flatDarkBackground: Color {
        return Color(decimalRed: 36, green: 36, blue: 36)
    }
    
    public static var flatDarkCardBackground: Color {
        return Color(decimalRed: 46, green: 46, blue: 46)
    }
}

extension String {
    func capitalizingFirstLetter() -> String {
        return prefix(1).capitalized + dropFirst()
    }

    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
}



