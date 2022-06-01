//
//  InputValidationResponseModel.swift
//  WeatherApp
//
//  Created by Jayamal shanuka Hettiarachchi on 2022-05-21.
//

import Foundation

struct LocationSet: Decodable {
    let name: String
    let lat: Double
    let lon: Double
    let country: String
}
