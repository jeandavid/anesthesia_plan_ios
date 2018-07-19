//
//  Constants.swift
//  Anesthesia Plan
//
//  Created by Jean-David Morgenstern-Peirolo on 6/28/18.
//  Copyright © 2018 Jean-David Morgenstern-Peirolo. All rights reserved.
//

import UIKit

enum Constants {

    static let questionHeaderHeight: CGFloat = 100.0
    static let questionRoundedCornerRadius: CGFloat = 10.0
    
    enum Colors {
        static let primary: UIColor = UIColor(rgb: 0x272958)
        static let primaryLight: UIColor = UIColor(rgb: 0x6C6ED7)
        static let accent: UIColor = UIColor(rgb: 0xDD346B)
        static let primaryText: UIColor = UIColor.black.withAlphaComponent(0.87)
        static let placeholderText: UIColor = UIColor.black.withAlphaComponent(0.38)
        static let secondaryText: UIColor = UIColor.black.withAlphaComponent(0.67)
        static let tertiaryText: UIColor = UIColor.black.withAlphaComponent(0.38)
        static let lightGray: UIColor = UIColor.black.withAlphaComponent(0.1)
        static let background: UIColor = UIColor.white
    }
    
    enum Dimens {
        static let viewHorizontalMargin: CGFloat = 16
        static let viewVerticalMargin: CGFloat = 16
    }
    
    enum Configuration {
        static let BUNDLE_ID = Bundle.main.infoDictionary!["CFBundleIdentifier"] as! String
        static let MY_BUNDLE_ID_URL_SCHEME = Bundle.main.infoDictionary!["MY_BUNDLE_ID_URL_SCHEME"] as! String
    }
}
