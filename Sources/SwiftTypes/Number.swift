//
//  Number.swift
//  SwiftTypes
//
//  Created by Piotr Brzeski on 2020-08-08.
//

import Foundation

public extension Double {
  func string(precision: Int = 2) -> String {
    if precision > 0 {
      let format = "%.\(precision)f"
      return String(format: format, self)
    }
    return String(Int(self))
  }
}
