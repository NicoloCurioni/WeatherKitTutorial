//
//  WeatherFetcher.swift
//  WeatherKitTutorial
//
//  Created by Nicolò Curioni on 03/10/22.
//

import Foundation
import WeatherKit
import CoreLocation

final class WeatherFetcher: ObservableObject {
    @Published var dailyTemperatures: [DailyTemperature]
    
    init(dailyTemperatures: [DailyTemperature] = []) {
        self.dailyTemperatures = dailyTemperatures
    }
    
    func fetchDaily() async {
        // Stop previews from fetching live data
        guard ProcessInfo.processInfo.environment["XCODE_RUNNING_FOR_PREVIEWS"] != "1" else {
            return
        }
        
        let weatherService = WeatherService()
        let newYork = CLLocation(latitude:  43.000000, longitude: -75.000000)
        
        do {
            let weather = try await weatherService.weather(for: newYork)
            
            let dailyForecasts = weather.dailyForecast.forecast
            
            let dailyTemperatures = Array(dailyForecasts.prefix(5)).map {
                DailyTemperature(
                    day: $0.date,
                    min: $0.lowTemperature.value,
                    max: $0.highTemperature.value,
                    id: UUID().uuidString
                )
            }
            
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                
                self.dailyTemperatures = dailyTemperatures
            }
        } catch {
            print(error.localizedDescription)
        }
    }
}
