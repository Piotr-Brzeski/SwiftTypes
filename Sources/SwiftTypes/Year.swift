//
//  Year.swift
//  SwiftTypes
//
//  Created by Piotr Brzeski on 2020-12-23.
//

import Foundation

public typealias Year = Int

public extension Year {
  var string: String {
    String(format: "%u", self)
  }
}
