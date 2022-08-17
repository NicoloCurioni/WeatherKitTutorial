//
//  UserLocation.swift
//  WeatherKitTutorial
//
//  Created by Nicolò Curioni on 17/08/22.
//

import Foundation
import CoreLocation

struct UserLocation: Hashable, Identifiable {
    var code: String
    var name: String
    var city: String
    var region: String
    var country: String
    var elevation: Double
    var latitude: Double
    var longitude: Double
    
    var id: String { code }
    
    var location: CLLocation {
        CLLocation(latitude: latitude, longitude: longitude)
    }
    
    var locationDescription: String {
        "\(city), \(country) (\(code))"
    }
}

extension UserLocation: Codable {
    enum CodingKeys: String, CodingKey {
        case code
        case name
        case city
        case region
        case country
        case elevation
        case latitude = "lat"
        case longitude = "lon"
    }
}

extension UserLocation: Comparable {
    static func <(lhs: UserLocation, rhs: UserLocation) -> Bool {
        lhs.name < rhs.name
    }
}
