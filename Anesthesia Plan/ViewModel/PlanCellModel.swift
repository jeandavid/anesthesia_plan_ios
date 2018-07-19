//
//  PlanCellModel.swift
//  Anesthesia Plan
//
//  Created by Jean-David Morgenstern-Peirolo on 6/28/18.
//  Copyright © 2018 Jean-David Morgenstern-Peirolo. All rights reserved.
//

import Foundation

struct PlanCellModel {
    let headerText: String?
    let subheaderText: String?
    let timeAndDateText: String?
    let selectedForDeletion: Bool
}

extension PlanCellModel {
    init(plan: Plan, selectedForDeletion: Bool = false) {
        var header: String?
        if let multiChoice = plan.questions?.array.first as? MultiChoice,
            let choices = multiChoice.choices?.array as? [Choice] {
            let answers: [String] = choices.filter({$0.selected}).compactMap({$0.body})
            header = answers.joined(separator: ", ")
        }
        var subheader: String?
        if let multiChoice = plan.questions?.array.second as? MultiChoice,
            let choices = multiChoice.choices?.array as? [Choice] {
            let answers: [String] = choices.filter({$0.selected}).compactMap({$0.body})
             subheader = answers.joined(separator: ", ")
        }
        var timeAndDate: String?
        if let date: Date = plan.createdAt {
            let dateFormatter: DateFormatter = DateFormatter()
            let now: Date = Date()
            if date.isEarlierThanAYearAgo {
                dateFormatter.dateFormat = "MMM yyyy" // Nov 2016
                timeAndDate = dateFormatter.string(from: date)
            } else if date.isEarlierThanAMonthAgo {
                dateFormatter.dateFormat = "d MMM" // 12 Aug
                timeAndDate = dateFormatter.string(from: date)
            } else if date.isEarlierThanAWeekAgo {
                dateFormatter.dateFormat = "d MMM" // 9 Nov
                timeAndDate = dateFormatter.string(from: date)
            } else if date.isYesterday {
                dateFormatter.dateFormat = "HH:mm" // 13:47
                let yesterdayStr: String = NSLocalizedString("PlanCellMode.YesterdayTime", comment: "")
                timeAndDate = String(format: yesterdayStr, dateFormatter.string(from: date))
            } else if date.isToday {
                dateFormatter.dateFormat = "HH:mm" // 13:47
                let todayStr: String = NSLocalizedString("PlanCellMode.TodayTime", comment: "")
                timeAndDate = String(format: todayStr, dateFormatter.string(from: date))
            } else if date < now {
                dateFormatter.dateFormat = "EEEE" // Monday
                timeAndDate = dateFormatter.string(from: date)
            } else {
                dateFormatter.dateFormat = "dd MMM yyyy"
                timeAndDate = dateFormatter.string(from: date)
            }
        }
        self.init(headerText: header, subheaderText: subheader, timeAndDateText: timeAndDate, selectedForDeletion: selectedForDeletion)
    }
}

