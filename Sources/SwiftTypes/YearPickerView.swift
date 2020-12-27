//
//  YearPickerView.swift
//  SwiftTypes
//
//  Created by Piotr Brzeski on 2020-08-14.
//

import SwiftUI

public struct YearPickerView: View {
  @Binding private var year: Year?
  
  public init(year: Binding<Year?>) {
    self._year = year
  }
  
  public var body: some View {
    Picker("Year", selection: self.$year) {
      Text("Year").tag(Year?.none)
      HStack { Divider() }
      Text("2018").tag(2018 as Year?)
      Text("2019").tag(2019 as Year?)
      Text("2020").tag(2020 as Year?)
      Text("2021").tag(2021 as Year?)
    }
    .frame(width: 100)
  }
}

struct YearPickerView_Previews: PreviewProvider {
  static var previews: some View {
    YearPickerView(year: .constant(2020))
  }
}
