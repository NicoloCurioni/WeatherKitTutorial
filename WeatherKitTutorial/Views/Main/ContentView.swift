//
//  ContentView.swift
//  WeatherKitTutorial
//
//  Created by Nicolò Curioni on 17/08/22.
//

import SwiftUI
import WeatherKit
import CoreLocation

struct ContentView: View {
    
    @StateObject private var locationManager = LocationManager()
    
    let weatherService = WeatherService.shared
    
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Hello, world!")
        }.task(id: locationManager.currentLocation) {
            if let location = locationManager.currentLocation {
                do {
                    let weather = try await weatherService.weather(for: location)
                    
                    print("** WEATHER: \(weather)")
                } catch {
                    print(error.localizedDescription)
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
