//
//  MultiChoice+CoreDataExtension.swift
//  Anesthesia Plan
//
//  Created by Jean-David Morgenstern-Peirolo on 6/28/18.
//  Copyright © 2018 Jean-David Morgenstern-Peirolo. All rights reserved.
//

import Foundation

extension MultiChoice {
    
    enum Layout: Int16 {
        case large = 0, small
    }
    
    enum Mode: Int16 {
        case unique = 0, multiple
    }

    var showOneChoicePerLine: Bool {
        return layout == Layout.small.rawValue
    }
    
    var allowsMultipleSelection: Bool {
        return mode == Mode.multiple.rawValue
    }
    
    var atLeastOnceSelectedChoice: Bool {
        let selectedChoices = (choices?.array as? [Choice])?.filter({$0.selected})
        return selectedChoices?.first != nil
    }

    func cancelSelection() {
        (choices?.array as? [Choice])?.forEach {$0.setSelected(false)}
    }
}
