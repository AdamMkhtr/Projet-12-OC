//
//  Date+Extensions.swift
//  LocklearApp
//
//  Created by Adam Mokhtar on 23/12/2021.
//

import Foundation
import UIKit

extension Date {
  
  //----------------------------------------------------------------------------
  // MARK: - Properties
  //----------------------------------------------------------------------------
  
  static var yesterday: Date { return Date().dayBefore }
  static var tomorrow:  Date { return Date().dayAfter }
  
  var dayBefore: Date {
    return Calendar.current.date(byAdding: .day, value: -1, to: noon)!
  }
  var dayAfter: Date {
    return Calendar.current.date(byAdding: .day, value: 1, to: noon)!
  }
  var noon: Date {
    return Calendar.current.date(bySettingHour: 12, minute: 0, second: 0, of: self)!
  }
  var month: Int {
    return Calendar.current.component(.month,  from: self)
  }
  var isLastDayOfMonth: Bool {
    return dayAfter.month != month
  }
  
  //----------------------------------------------------------------------------
  // MARK: - Method
  //----------------------------------------------------------------------------
  
  /// Check what is the dat of today
  /// - Returns: Return the string of the day of today.
  func dayOfWeek() -> String? {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "EEEE"
    
    return dateFormatter.string(from: self).capitalized
    
  }
}


