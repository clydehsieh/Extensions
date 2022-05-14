//
//  Int+Extension.swift
//  Extensions
//
//  Created by ClydeHsieh on 2022/5/14.
//

import UIKit

private let dateFormatter: DateFormatter = {
    let df = DateFormatter()
    df.timeZone = .current
    df.calendar = Calendar(identifier: .gregorian)
    df.locale = .current
    return df
}()

extension Date {
    /// Returns a Date with the specified days added to the one it is called with
    func add(years: Int = 0, months: Int = 0, days: Int = 0, hours: Int = 0, minutes: Int = 0, seconds: Int = 0) -> Date {
        var targetDay: Date
        targetDay = Calendar.current.date(byAdding: .year, value: years, to: self)!
        targetDay = Calendar.current.date(byAdding: .month, value: months, to: targetDay)!
        targetDay = Calendar.current.date(byAdding: .day, value: days, to: targetDay)!
        targetDay = Calendar.current.date(byAdding: .hour, value: hours, to: targetDay)!
        targetDay = Calendar.current.date(byAdding: .minute, value: minutes, to: targetDay)!
        targetDay = Calendar.current.date(byAdding: .second, value: seconds, to: targetDay)!
        return targetDay
    }
    
    /// Returns a Date with the specified days subtracted from the one it is called with
    func subtract(years: Int = 0, months: Int = 0, days: Int = 0, hours: Int = 0, minutes: Int = 0, seconds: Int = 0) -> Date {
        let inverseYears = -1 * years
        let inverseMonths = -1 * months
        let inverseDays = -1 * days
        let inverseHours = -1 * hours
        let inverseMinutes = -1 * minutes
        let inverseSeconds = -1 * seconds
        return add(years: inverseYears, months: inverseMonths, days: inverseDays, hours: inverseHours, minutes: inverseMinutes, seconds: inverseSeconds)
    }
    
    /// Returns the amount of years from another date
    func years(from date: Date) -> Int {
        return Calendar.current.dateComponents([.year], from: date, to: self).year ?? 0
    }
    
    /// Returns the amount of months from another date
    func months(from date: Date) -> Int {
        return Calendar.current.dateComponents([.month], from: date, to: self).month ?? 0
    }
    
    /// Returns the amount of weeks from another date
    func weeks(from date: Date) -> Int {
        return Calendar.current.dateComponents([.weekOfYear], from: date, to: self).weekOfYear ?? 0
    }
    
    /// Returns the amount of days from another date
    func days(from date: Date) -> Int {
        return Calendar.current.dateComponents([.day], from: date, to: self).day ?? 0
    }
    
    /// Returns the amount of hours from another date
    func hours(from date: Date) -> Int {
        return Calendar.current.dateComponents([.hour], from: date, to: self).hour ?? 0
    }
    
    /// Returns the amount of minutes from another date
    func minutes(from date: Date) -> Int {
        return Calendar.current.dateComponents([.minute], from: date, to: self).minute ?? 0
    }
    
    /// Returns the amount of seconds from another date
    func seconds(from date: Date) -> Int {
        return Calendar.current.dateComponents([.second], from: date, to: self).second ?? 0
    }
    
    /// Returns the a custom time interval description from another date
    func offset(from date: Date) -> String {
        if years(from: date) > 0 { return "\(years(from: date))y" }
        if months(from: date) > 0 { return "\(months(from: date))M" }
        if weeks(from: date) > 0 { return "\(weeks(from: date))w" }
        if days(from: date) > 0 { return "\(days(from: date))d" }
        if hours(from: date) > 0 { return "\(hours(from: date))h" }
        if minutes(from: date) > 0 { return "\(minutes(from: date))m" }
        if seconds(from: date) > 0 { return "\(seconds(from: date))s" }
        return ""
    }
    
    func getFormattedDate(timestamp: TimeInterval) -> String {
        let date = Date(timeIntervalSince1970: timestamp)
        let dateButtonFormatter = DateFormatter()
        dateButtonFormatter.setLocalizedDateFormatFromTemplate("dd MMMM (EEE)")
        dateButtonFormatter.calendar = Calendar(identifier: .gregorian)
        return dateButtonFormatter.string(from: date)
    }
    
    func getFormattedTime(timestamp: TimeInterval) -> String {
        let date = Date(timeIntervalSince1970: timestamp)
        let timeButtonFormatter = DateFormatter()
        timeButtonFormatter.dateFormat = "HH:mm"
        timeButtonFormatter.calendar = Calendar(identifier: .gregorian)
        return timeButtonFormatter.string(from: date)
    }

    var yyyy: String {
        dateFormatter.dateFormat = "yyyy"
        return dateFormatter.string(from: self)
    }
    
    /// 2016-04-12
    var yyyyMMdd: String {
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter.string(from: self)
    }
    
    var yyyyMMddDot: String {
        dateFormatter.dateFormat = "yyyy.MM.dd"
        return dateFormatter.string(from: self)
    }
    
    /// 2016-04-12 18:30
    var dateTimeInStr: String {
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
        return dateFormatter.string(from: self)
    }

    var yyyyMMddHHmmss: String {
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return dateFormatter.string(from: self)
    }
    
    /// 18:30
    var Hr24TimeInStr: String {
        dateFormatter.dateFormat = "HH:mm"
        return dateFormatter.string(from: self)
    }
    
    /// Jun/12
    var dateInStr: String {
        dateFormatter.dateFormat = "MM/dd"
        return dateFormatter.string(from: self)
    }
    
    /// Wed, Jul 10 - 20:30
    var EEEMMdd_HHmm: String {
        dateFormatter.dateFormat = "EEE, MMM dd - HH:mm"
        return dateFormatter.string(from: self)
    }
    
    var postCreatedFormat: String {
        dateFormatter.dateFormat = "HH:mm, MMMM dd日 yyyy"
        return dateFormatter.string(from: self)
    }
    
    func EEEMMMddHHmm(secondsFromGMT: Int? = nil) -> String {
        let df = DateFormatter()
        if let secondsFromGMT = secondsFromGMT {
            df.timeZone = TimeZone(secondsFromGMT: secondsFromGMT)
        } else {
            df.timeZone = .current
        }
        df.calendar = Calendar(identifier: .gregorian)
        df.locale = .current
        df.dateFormat = "EEE, MMM dd - HH:mm"
        return df.string(from: self)
    }

    func EEEMMMddHHmmWithTimeZone(minutesFromGMT: Int? = nil) -> String {
        let df = DateFormatter()
        let timeZoneDescription: String
        if let minutesFromGMT = minutesFromGMT {
            df.timeZone = TimeZone(secondsFromGMT: minutesFromGMT*60)
            timeZoneDescription = "(UTC \(minutesFromGMT >= 0 ? "+" : "-")\(minutesFromGMT/60))"
        } else {
            df.timeZone = .current
            let secondsFromGMT = df.timeZone.secondsFromGMT()
            timeZoneDescription = "(UTC \(secondsFromGMT >= 0 ? "+" : "-")\(secondsFromGMT/60/60))"
        }
        df.calendar = Calendar(identifier: .gregorian)
        df.locale = .current
        df.dateFormat = "EEE, MMM dd - HH:mm"
        return "\(df.string(from: self)) \(timeZoneDescription)"
    }

    func MMddHHmm(secondsFromGMT: Int? = nil) -> String {
        let df = DateFormatter()
        if let secondsFromGMT = secondsFromGMT {
            df.timeZone = TimeZone(secondsFromGMT: secondsFromGMT)
        } else {
            df.timeZone = .current
        }
        df.calendar = Calendar(identifier: .gregorian)
        df.locale = .current
        df.dateFormat = "MM/dd, HH:mm"
        return df.string(from: self)
    }
    
    func HHmm(secondsFromGMT: Int? = nil) -> String {
        let df = DateFormatter()
        if let secondsFromGMT = secondsFromGMT {
            df.timeZone = TimeZone(secondsFromGMT: secondsFromGMT)
        } else {
            df.timeZone = .current
        }
        df.calendar = Calendar(identifier: .gregorian)
        df.locale = .current
        df.dateFormat = "HH:mm"
        return df.string(from: self)
    }
    
    /// Jul 10 - 20:30
    var MMMddHHmm: String {
        dateFormatter.dateFormat = "MMM dd - HH:mm"
        return dateFormatter.string(from: self)
    }
    
    /// 6/30 星期三 下午 7:00
    var MMdd_EEE_HHmm: String {
        dateFormatter.dateFormat = "MM/dd\nEEE\nHH:mm"
        return dateFormatter.string(from: self)
    }
    
    /// 12/30 星期三
    var MMddEEE: String {
        dateFormatter.dateFormat = "MM/dd EEE"
        return dateFormatter.string(from: self)
    }
    
    /// 12/30
    var MMdd: String {
        dateFormatter.dateFormat = "MM/dd"
        return dateFormatter.string(from: self)
    }
    
    /// 12月30日
    var MMMMdd: String {
        dateFormatter.dateFormat = "MMMM dd"
        return dateFormatter.string(from: self)
    }
    
    /// 12月30日, 2020
    var MMMMddYYYY: String {
        dateFormatter.dateFormat = "MMMM dd, yyyy"
        return dateFormatter.string(from: self)
    }
    
    /// 12月, 2016
    var MMMMyyyy: String {
        dateFormatter.dateFormat = "MMMM, yyyy"
        return dateFormatter.string(from: self)
    }
    
    /// 19:30
    var HHmm: String {
        dateFormatter.dateFormat = "HH:mm"
        return dateFormatter.string(from: self)
    }
    
    /// 12/23
    var ddMM: String {
        dateFormatter.dateFormat = "dd/MM"
        return dateFormatter.string(from: self)
    }
    
    /// 23/12\n19:30
    var MMdd_HHmm: String {
        dateFormatter.dateFormat = "MM/dd\nHH:mm"
        return dateFormatter.string(from: self)
    }
    
    var MMddHHmm: String {
        dateFormatter.dateFormat = "MM/dd HH:mm"
        return dateFormatter.string(from: self)
    }
    
    /// 23/12 19:30
    var MMddEEEHHmm: String {
        dateFormatter.dateFormat = "MM/dd EEE HH:mm"
        return dateFormatter.string(from: self)
    }
    
    var yyyyMMdd_EEE_HHmm: String {
        dateFormatter.dateFormat = "yyyy/MM/dd EEE HH:mm"
        return dateFormatter.string(from: self)
    }
    
    var EEEMMMdd: String {
        dateFormatter.dateFormat = "EEE, MMM dd"
        return dateFormatter.string(from: self)
    }

    var EEEMMddyyyy: String {
        dateFormatter.dateFormat = "EEE, MMM dd yyyy"
        return dateFormatter.string(from: self)
    }
    
    var MMddhhmma: String {
        dateFormatter.dateFormat = "MM/dd hh:mm a"
        return dateFormatter.string(from: self)
    }
    
    var timeAgo: String {
        let currentTime = Date().timeIntervalSince1970
        let compareTimeInSec = currentTime - timeIntervalSince1970
        if compareTimeInSec < 60 {
            // Less than a minute
            return "Just Now".localized
        } else if compareTimeInSec < (60 * 2 - 1) {
            // In the second minute
            return "1 \("Min Ago".localized)"
        } else if compareTimeInSec < (60 * 60) {
            // Less than an hour
            return "\(Int(compareTimeInSec / 60)) \("Min Ago".localized)"
        } else if compareTimeInSec < (60 * 60 * 24) {
            // Less than a day
            return "\(Int(compareTimeInSec / (60 * 60))) \("Hour Ago".localized)"
        } else if compareTimeInSec < (60 * 60 * 24 * 7) {
            // Less than a week
            return "\(Int(compareTimeInSec / (60 * 60 * 24))) \("Day Ago".localized)"
        }
        return yyyyMMdd
    }
    
    func toString(iso8601DateFormatter: ISO8601DateFormatter) -> String {
        iso8601DateFormatter.string(from: self)
    }
    
    func isToday() -> Bool {
        let calendar = Calendar.current
        
        let today  = calendar.dateComponents([.year,.month,.day], from: Date())
        let target = calendar.dateComponents([.year,.month,.day], from: self)
        let difference = calendar.dateComponents([.year,.month,.day], from: target, to: today)
        
        if difference.year! == 0 && difference.month! == 0 && difference.day! == 0 {
            return true
        }
        
        return false
    }
    
    static func random(in range: Range<Date>) -> Date {
        Date(
            timeIntervalSinceNow: .random(
                in: range.lowerBound.timeIntervalSinceNow...range.upperBound.timeIntervalSinceNow
            )
        )
    }
    
    static func randomInAYear() -> Date {
        let yearAgo = Date().add(years: -1)
        let now = Date()
        return Date.random(in: yearAgo..<now )
    }
}
