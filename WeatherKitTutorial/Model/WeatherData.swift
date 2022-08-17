//
//  WeatherData.swift
//  WeatherKitTutorial
//
//  Created by Nicolò Curioni on 17/08/22.
//

import Foundation
import WeatherKit
import os.log

@MainActor
class WeatherData: ObservableObject {
    let logger = Logger(subsystem: "com.example.WeatherKitTutorial.WeatherData", category: "Model")
    
    @Published private var _currentWeathers = [UserLocation.ID: CurrentWeather]()
    @Published private var _dailyForecasts = [UserLocation.ID: Forecast<DayWeather>]()
    @Published private var _hourlyForecasts = [UserLocation.ID: Forecast<HourWeather>]()
    
    static let shared = WeatherData()
    
    private let service = WeatherService.shared
    
    subscript(userLocation id: UserLocation.ID) -> CurrentWeather? {
        _currentWeathers[id]
    }
    
    subscript(userLocation id: UserLocation.ID) -> Forecast<DayWeather>? {
        _dailyForecasts[id]
    }
    
    subscript(userLocation id: UserLocation.ID) -> Forecast<HourWeather>? {
        _hourlyForecasts[id]
    }
    
    @discardableResult
    func weather(for userLocation: UserLocation) async -> CurrentWeather? {
        let currentWeather = await Task.detached(priority: .userInitiated) {
            let forecast = try? await self.service.weather(
                for: userLocation.location,
                including: .current)
            
            return forecast
        }.value
        
        _currentWeathers[userLocation.id] = currentWeather
        
        return currentWeather
    }
    
    @discardableResult
    func dailyForecast(for userLocation: UserLocation) async -> Forecast<DayWeather>? {
        let dayWeather = await Task.detached(priority: .userInitiated) {
            let forcast = try? await self.service.weather(
                for: userLocation.location,
                including: .daily)
            return forcast
        }.value
        _dailyForecasts[userLocation.id] = dayWeather
        return dayWeather
    }
    
    @discardableResult
    func hourlyForecast(for userLocation: UserLocation) async -> Forecast<HourWeather>? {
        let hourWeather = await Task.detached(priority: .userInitiated) {
            let forcast = try? await self.service.weather(
                for: userLocation.location,
                including: .hourly)
            return forcast
        }.value
        _hourlyForecasts[userLocation.id] = hourWeather
        return hourWeather
    }
}
