//
//  LocationManager.swift
//  WeatherKitTutorial
//
//  Created by Nicolò Curioni on 17/08/22.
//

import Foundation
import CoreLocation

class LocationManager: NSObject, ObservableObject {
    let manager = CLLocationManager()
    
    @Published var currentLocation: CLLocation?
    private let locationManager = CLLocationManager()
    
    override init() {
        super.init()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.distanceFilter = kCLDistanceFilterNone
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
        locationManager.delegate = self
    }
}


