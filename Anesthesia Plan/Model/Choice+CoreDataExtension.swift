//
//  Choice+CoreDataExtension.swift
//  Anesthesia Plan
//
//  Created by Jean-David Morgenstern-Peirolo on 6/29/18.
//  Copyright © 2018 Jean-David Morgenstern-Peirolo. All rights reserved.
//

import Foundation

extension Choice {
    func setSelected(_ selected: Bool) {
        setValue(selected, forKey: "selected")
    }
    
    func toggleSelection() {
        setValue(!selected, forKey: "selected")
    }
}
