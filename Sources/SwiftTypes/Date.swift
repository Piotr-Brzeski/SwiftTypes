//
//  Date.swift
//  SwiftTypes
//
//  Created by Piotr Brzeski on 2020-07-19.
//

import Foundation

public extension Date {
  var dateString: String {
    let components = Calendar.current.dateComponents([.year, .month, .day], from: self)
    return String(format: "%.4d-%.2d-%.2d", components.year!, components.month!, components.day!)
  }
  
  var dateTtimeString: String {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
    return formatter.string(from: self)
  }
  
  static func from(dateString: String) -> Date? {
    let components = dateString.prefix(10).split(separator: "-")
    if components.count == 3 {
      let year = Int(components[0])
      let month = Int(components[1])
      let day = Int(components[2])
      let date = DateComponents(calendar:Calendar.current, year: year, month: month, day: day).date
      return date
    }
    return nil
  }
  
  var year: Year {
    Calendar.current.component(.year, from: self)
  }
  
  var month: Month {
    Month(rawValue: Calendar.current.component(.month, from: self))!
  }
  
  func isFrom(year: Year?, month: Month?) -> Bool {
    if year != nil && year! != self.year {
      return false
    }
    if month != nil && month! != self.month {
      return false
    }
    return true
  }
  
  func isFrom(year: Year, quarter: Int) -> Bool {
    self.year == year && self.month.quarter == quarter
  }
  
  static func firstDayOf(year: Year, month: Month) -> Date? {
    DateComponents(calendar:Calendar.current, year: year, month: month.id, day: 1).date
  }
  
  static func lastDayOf(year: Year, month: Month) -> Date? {
    if month != .December {
      return firstDayOf(year: year, month: month.next)?.addingTimeInterval(-24*60*60)
    }
    return DateComponents(calendar:Calendar.current, year: year, month: 12, day: 31).date
  }
}
