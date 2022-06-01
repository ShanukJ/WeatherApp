//
//  RowCard.swift
//  WeatherApp
//
//  Created by Jayamal shanuka Hettiarachchi on 2022-05-20.
//

import Foundation
import SwiftUI

struct StoreRow: View {
    
    var title: String
    var address: String
    var city: String
    var categories: [String]
    var kilometres: Double
    
    var body: some View {
        ZStack(alignment: .leading) {
            
            Color.flatDarkCardBackground
            HStack {
                ZStack {
                    Circle()
                        .fill(
                            LinearGradient(
                                gradient: Gradient(colors: [.pink, .red]),
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        )
                    
                    VStack {
                        Text("\(kilometres)")
                            .font(.system(size: 20, weight: .bold))
                            .foregroundColor(.white)
                        
                        Text("km")
                            .font(.caption)
                            .foregroundColor(.white)
                    }
                }
                .frame(width: 70, height: 70, alignment: .center)
                
                VStack(alignment: .leading) {
                    Text(title)
                        .font(.headline)
                        .fontWeight(.bold)
                        .lineLimit(2)
                        .padding(.bottom, 5)
                    
                    Text(address)
                        .padding(.bottom, 5)
                    
                    HStack(alignment: .center) {
                        Image(systemName: "mappin")
                        Text(city)
                    }
                    .padding(.bottom, 5)
                    
                    HStack {
                        ForEach(categories, id: \.self) { category in
                            //CategoryPill(categoryName: category)
                        }
                    }
                    
                }
                .padding(.horizontal, 5)
            }
            .padding(15)
        }
        .clipShape(RoundedRectangle(cornerRadius: 15))
    }
}
