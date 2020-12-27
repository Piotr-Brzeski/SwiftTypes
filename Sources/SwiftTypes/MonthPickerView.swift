//
//  MonthPickerView.swift
//  SwiftTypes
//
//  Created by Piotr Brzeski on 2020-08-14.
//

import SwiftUI

public struct MonthPickerView: View {
  @Binding private var month: Month?
  
  public init(month: Binding<Month?>) {
    self._month = month
  }
  
  public var body: some View {
    Picker("Month", selection: self.$month) {
      Text("Month").tag(Month?.none)
      HStack { Divider() }
      Group {
        ForEach(Month.allCases) { month in
          Text(month.name).tag(month as Month?)
        }
      }
    }
    .frame(width: 150)
  }
}

struct MonthPickerView_Previews: PreviewProvider {
  static var previews: some View {
    MonthPickerView(month: .constant(.January))
  }
}
