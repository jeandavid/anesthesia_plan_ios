//
//  UINavigationBar+Extension.swift
//  Anesthesia Plan
//
//  Created by Jean-David Morgenstern-Peirolo on 6/28/18.
//  Copyright © 2018 Jean-David Morgenstern-Peirolo. All rights reserved.
//

import UIKit

extension UINavigationBar {
    // https://stackoverflow.com/questions/26390072/remove-border-in-navigationbar-in-swift
    func hideShadow(_ isHidden: Bool) {
        setValue(isHidden, forKey: "hidesShadow")
    }
}
