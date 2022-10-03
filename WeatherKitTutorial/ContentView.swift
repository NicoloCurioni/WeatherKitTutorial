//
//  ContentView.swift
//  WeatherKitTutorial
//
//  Created by Nicolò Curioni on 17/08/22.
//

import SwiftUI
import Charts

struct ContentView: View {
    @ObservedObject var fetcher: WeatherFetcher
    
    init(fetcher: WeatherFetcher = WeatherFetcher()) {
        self.fetcher = fetcher
    }
    
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Hello, world!")
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(fetcher: WeatherFetcher(
            dailyTemperatures: [
                .init(day: .date(year: 2022, month: 5, day: 5), min: 5.6, max: 15.4, id: UUID().uuidString),
                .init(day: .date(year: 2022, month: 5, day: 6), min: 8, max: 12, id: UUID().uuidString),
                .init(day: .date(year: 2022, month: 5, day: 7), min: 7, max: 16.2, id: UUID().uuidString),
                .init(day: .date(year: 2022, month: 5, day: 8), min: 7.5, max: 11, id: UUID().uuidString),
                .init(day: .date(year: 2022, month: 5, day: 9), min: 9.35, max: 14.8, id: UUID().uuidString)
            ]
        ))
    }
}
