//
//  Collection+Extension.swift
//  Anesthesia Plan
//
//  Created by Jean-David Morgenstern-Peirolo on 6/28/18.
//  Copyright © 2018 Jean-David Morgenstern-Peirolo. All rights reserved.
//

import Foundation

extension Collection {
    // https://developer.apple.com/videos/play/wwdc2018/229/
    var second: Element? {
        guard startIndex != endIndex else {return nil}
        let secondIndex = index(after: startIndex)
        guard secondIndex != endIndex else {return nil}
        return self[secondIndex]
    }
}
