//
//  NumericField.swift
//  SwiftTypes
//
//  Created by Piotr Brzeski on 2020-08-15.
//

import SwiftUI

fileprivate func isDigit(_ character: Character) -> Bool {
  "0123456789".contains(character)
}

fileprivate func process(_ input: String, precision: Int) -> String {
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
      else if precision > 0 && (character == "." || character == ",") {
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
  if precision > 0 {
    if fractionalDigits < 0 {
      output.append(".0")
      fractionalDigits = 1
    }
    while fractionalDigits < precision {
      output.append("0")
      fractionalDigits += 1
    }
  }
  return output
}

public struct IntField: View {
  private let key: String
  @Binding private var value: Int
  @State private var string: String
  
  public init(_ key: String, value: Binding<Int>) {
    self.key = key
    self._value = value
    self._string = State<String>(initialValue: String(value.wrappedValue))
  }
  
  public var body: some View {
    TextField(self.key, text: Binding<String>(get: { String(self.value) }, set: { str in self.string = str }), onCommit: {
      let newString = process(self.string, precision: 0)
      let newValue = Int(newString) ?? 0
      self.value = newValue
      self.string = newString
    }).multilineTextAlignment(.trailing)
  }
}

public struct DoubleField: View {
  private let key: String
  private let precision: Int
  @Binding private var value: Double
  @State private var string: String
  
  public init(_ key: String, value: Binding<Double>, precision: Int = 2) {
    self.key = key
    self.precision = precision
    self._value = value
    self._string = State<String>(initialValue: value.wrappedValue.string(precision: precision))
  }

  public var body: some View {
    TextField(self.key, text: Binding<String>(get: { self.value.string(precision: self.precision) }, set: { str in self.string = str }), onCommit: {
      let newString = process(self.string, precision: self.precision)
      let newValue = Double(newString) ?? 0.0
      self.value = newValue
      self.string = newString
    }).multilineTextAlignment(.trailing)
  }
}

struct NumericField_Previews: PreviewProvider {
  static var previews: some View {
    VStack {
      DoubleField("Test", value: .constant(10.0), precision: 3)
        .padding()
      IntField("Test", value: .constant(100))
        .padding()
    }
  }
}
