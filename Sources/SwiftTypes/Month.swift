//
//  Month.swift
//  SwiftTypes
//
//  Created by Piotr Brzeski on 2020-12-23.
//

import Foundation

public enum MonthError: Error, Equatable {
  case invalidId
}

public enum Month: Int, Identifiable {
  case January = 1
  case February = 2
  case March = 3
  case April = 4
  case May = 5
  case June = 6
  case July = 7
  case August = 8
  case September = 9
  case October = 10
  case November = 11
  case December = 12
  
  public init(id: Int) throws {
    guard let month = Month(rawValue: id) else {
      throw MonthError.invalidId
    }
    self = month
  }
  
  public var id: Int {
    self.rawValue
  }
  
  public var name: String {
    switch self {
    case .January:
      return "January"
    case .February:
      return "February"
    case .March:
      return "March"
    case .April:
      return "April"
    case .May:
      return "May"
    case .June:
      return "June"
    case .July:
      return "July"
    case .August:
      return "August"
    case .September:
      return "September"
    case .October:
      return "October"
    case .November:
      return "November"
    case .December:
      return "December"
    }
  }
  
  public var quarter: Int {
    switch self {
    case .January:
      return 1
    case .February:
      return 1
    case .March:
      return 1
    case .April:
      return 2
    case .May:
      return 2
    case .June:
      return 2
    case .July:
      return 3
    case .August:
      return 3
    case .September:
      return 3
    case .October:
      return 4
    case .November:
      return 4
    case .December:
      return 4
    }
  }
  
  public var next: Month {
    switch self {
    case .January:
      return .February
    case .February:
      return .March
    case .March:
      return .April
    case .April:
      return .May
    case .May:
      return .June
    case .June:
      return .July
    case .July:
      return .August
    case .August:
      return .September
    case .September:
      return .October
    case .October:
      return .November
    case .November:
      return .December
    case .December:
      return .January
    }
  }
  
  public static let allCases = [Month.January,
                                Month.February,
                                Month.March,
                                Month.April,
                                Month.May,
                                Month.June,
                                Month.July,
                                Month.August,
                                Month.September,
                                Month.October,
                                Month.November,
                                Month.December]
}

