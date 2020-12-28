//
//  NumericField.swift
//  SwiftTypes
//
//  Created by Piotr Brzeski on 2020-08-15.
//

import SwiftUI

public struct NumericField: View {
  private let key: String
  private let precision: Int
  @Binding private var doubleValue: Double
  @Binding private var intValue: Int
  @State private var string: String
  private let isInt: Bool
  
  public init(_ key: String, value: Binding<Double>, precision: Int = 2) {
    self.key = key
    self.precision = precision
    self._doubleValue = value
    self._intValue = Binding<Int>(get: {0}, set: {_ in})
    self._string = State<String>(initialValue: value.wrappedValue.string(precision: precision))
    self.isInt = false
  }
  
  public init(_ key: String, value: Binding<Int>) {
    self.key = key
    self.precision = 0
    self._doubleValue = Binding<Double>(get: {0.0}, set: {_ in})
    self._intValue = value
    self._string = State<String>(initialValue: String(value.wrappedValue))
    self.isInt = true
  }
  
  public var body: some View {
    TextField(self.key, text: self.$string, onCommit: {
      let newString = process(self.string)
      if newString != self.string {
        let newValue = Double(newString) ?? 0.0
        if newValue != self.currentValue {
          if self.isInt {
            self.intValue = Int(newValue)
          }
          else {
            self.doubleValue = newValue
          }
        }
        self.string = newString
      }
    }).multilineTextAlignment(.trailing)
  }
  
  private var currentValue: Double {
    self.isInt ? Double(self.intValue) : self.doubleValue
  }
  
  private func isDigit(_ character: Character) -> Bool {
    "0123456789".contains(character)
  }
  
  private func process(_ input: String) -> String {
    var output = ""
    var fractionalDigits = -1
    var negative = false
    for character in input {
      if fractionalDigits < 0 {
        if character == "-" {
          if output.isEmpty {
            negative = true
          }
        }
        else if isDigit(character) {
          if output == "0" {
            output = ""
          }
          output.append(character)
        }
        else if self.precision > 0 && (character == "." || character == ",") {
          if output.isEmpty {
            output = "0."
          }
          else {
            output.append(".")
          }
          fractionalDigits = 0
        }
      }
      else if isDigit(character) {
        output.append(character)
        fractionalDigits += 1
        if fractionalDigits == precision {
          break
        }
      }
    }
    if output.isEmpty {
      output = "0"
    }
    if negative {
      output = "-" + output
    }
    if self.precision > 0 {
      if fractionalDigits < 0 {
        output.append(".0")
        fractionalDigits = 1
      }
      while fractionalDigits < self.precision {
        output.append("0")
        fractionalDigits += 1
      }
    }
    return output
  }
}

struct NumericField_Previews: PreviewProvider {
  static var previews: some View {
    VStack {
      NumericField("Test", value: .constant(10.0), precision: 3)
        .padding()
      NumericField("Test", value: .constant(100))
        .padding()
    }
  }
}
