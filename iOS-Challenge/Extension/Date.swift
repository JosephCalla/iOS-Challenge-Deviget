//
//  Date.swift
//  iOS-Challenge
//
//  Created by Joseph Calla Moreyra on 10/09/21.
//

import Foundation
extension String {
    func timeAgo(_ timestamp: TimeInterval) -> String {
        let now = Date()
        let timestampDifference = now.timeIntervalSince1970 - timestamp
        let contant = Constant()
        if timestampDifference < 60 {
            return contant.JustNowText
        }
        if timestampDifference < (60 * 60) {
            let minutes = floor(timestampDifference / 60)
            return "\(String(format: "%.0f", minutes)) \(minutes > 1 ? contant.MinutesText : contant.MinuteText)"
        }
        if timestampDifference < (60 * 60 * 24) {
            let hours = floor(timestampDifference / 60 / 60)
            return "\(String(format: "%.0f", hours)) \(hours < 2 ? contant.HourText : contant.HoursText)"
        }
        if timestampDifference < (60 * 60 * 24 * 7) {
            let days = floor(timestampDifference / 60 / 60 / 24)
            return "\(String(format: "%.0f", days)) \(days < 2 ? contant.DayText : contant.DaysText)"
        }
        if timestampDifference < (60 * 60 * 24 * 30) {
            let weeks = floor(timestampDifference / 60 / 60 / 24 / 7)
            return "\(String(format: "%.0f", weeks)) \(weeks < 2 ? contant.WeekText : contant.WeeksText)"
        }
        if timestampDifference < (60 * 60 * 24 * 365) {
            let months = floor(timestampDifference / 60 / 60 / 24 / 30)
            return "\(String(format: "%.0f", months)) \(months < 2 ? contant.MonthText : contant.MonthsText)"
        }
        let years = floor(timestampDifference / 60 / 60 / 24 / 365)
        return "\(String(format: "%.0f", years)) \(years < 2 ? contant.YearText : contant.YearsText)"
    }
}
