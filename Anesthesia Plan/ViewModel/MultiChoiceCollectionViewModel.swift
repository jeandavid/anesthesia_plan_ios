//
//  MultiChoiceCollectionViewModel.swift
//  Anesthesia Plan
//
//  Created by Jean-David Morgenstern-Peirolo on 6/29/18.
//  Copyright © 2018 Jean-David Morgenstern-Peirolo. All rights reserved.
//

import Foundation

class MultiChoiceCollectionViewModel {
    
    /*************************
     *                       *
     *      INIT/DEINIT      *
     *                       *
     *************************/
    init(question: MultiChoice) {
        self.question = question
    }
    
    /*************************
     *                       *
     *       PROPERTIES      *
     *                       *
     *************************/
    fileprivate let question: MultiChoice
    
    /*************************
     *                       *
     *       INTERFACES      *
     *                       *
     *************************/
    internal var reloadData: (() -> ())?

    internal func choiceSelected(at indexPath: IndexPath) {
        let choice = question.choices?.array[indexPath.row] as! Choice
        switch question.mode {
        case MultiChoice.Mode.multiple.rawValue:
            choice.toggleSelection()
            break
        case MultiChoice.Mode.unique.rawValue:
            if question.atLeastOnceSelectedChoice && !choice.selected {
               question.cancelSelection()
            }
            choice.toggleSelection()
            break
        default:
            break
        }
        reloadData?()
    }
    
    internal func getChoiceCellModel(at indexPath: IndexPath) -> ChoiceCellModel {
        let choice = question.choices?.array[indexPath.row] as! Choice
        return ChoiceCellModel(body: choice.body, selected: choice.selected)
    }
    
    internal var numberOfItems: Int {
        return question.choices?.array.count ?? 0
    }
    
    internal var header: String {
        return question.problem ?? ""
    }
}

struct ChoiceCellModel {
    let body: String?
    let selected: Bool
}
