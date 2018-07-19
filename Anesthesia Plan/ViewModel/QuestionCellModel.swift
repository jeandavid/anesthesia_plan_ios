//
//  QuestionCellModel.swift
//  Anesthesia Plan
//
//  Created by Jean-David Morgenstern-Peirolo on 6/28/18.
//  Copyright © 2018 Jean-David Morgenstern-Peirolo. All rights reserved.
//

import Foundation

struct QuestionCellModel {
    let headerText: String?
    let subheaderText: String?
}

extension QuestionCellModel {
    init(question: Question) {
        let header: String? = question.problem
        var subheader: String?
        switch question {
        case let multiChoice as MultiChoice:
            if let choices = multiChoice.choices?.array as? [Choice] {
                let answers: [String] = choices.filter({$0.selected}).compactMap({$0.body})
                subheader = answers.joined(separator: ", ")
            }
            break
        case let freeText as FreeText:
            subheader = freeText.input
            break
        default:
            break
        }
        self.init(headerText: header, subheaderText: subheader)
    }
}
