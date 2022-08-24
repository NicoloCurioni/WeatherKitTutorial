//
//  CLLocationManagerDelegate+Extensions.swift
//  WeatherKitTutorial
//
//  Created by Nicolò Curioni on 24/08/22.
//

import Foundation
import CoreLocation

extension LocationManager: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            
            self.currentLocation = location
        }
    }
}
