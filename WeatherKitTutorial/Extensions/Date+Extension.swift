//
//  Date+Extension.swift
//  WeatherKitTutorial
//
//  Created by Nicolò Curioni on 03/10/22.
//

import Foundation

extension Date {
    static func date(year: Int, month: Int, day: Int) -> Date {
        Calendar.current.date(
            from: DateComponents(year: year, month: month, day: day)
        ) ?? Date()
    }
}
