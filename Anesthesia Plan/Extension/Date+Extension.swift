//
//  Date+Extension.swift
//  Anesthesia Plan
//
//  Created by Jean-David Morgenstern-Peirolo on 6/28/18.
//  Copyright © 2018 Jean-David Morgenstern-Peirolo. All rights reserved.
//

import Foundation

extension Date {
    var isToday: Bool {
        return Calendar.current.isDateInToday(self)
    }
    
    var isYesterday: Bool {
        return Calendar.current.isDateInYesterday(self)
    }
    
    var isEarlierThanAWeekAgo: Bool {
        let now: Date = Date()
        guard let aWeekAgo: Date = Calendar.current.date(byAdding: .day, value: -7, to: now) else {return false}
        return self < aWeekAgo
    }
    
    var isEarlierThanAMonthAgo: Bool {
        let now: Date = Date()
        guard let aMonthAgo: Date = Calendar.current.date(byAdding: .month, value: -1, to: now) else {return false}
        return self < aMonthAgo
    }
    
    var isEarlierThanAYearAgo: Bool {
        let now: Date = Date()
        guard let aYearAgo: Date = Calendar.current.date(byAdding: .year, value: -1, to: now) else {return false}
        return self < aYearAgo
    }
}

