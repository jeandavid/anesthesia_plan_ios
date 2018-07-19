//
//  ProblemReusableView.swift
//  Anesthesia Plan
//
//  Created by Jean-David Morgenstern-Peirolo on 6/28/18.
//  Copyright © 2018 Jean-David Morgenstern-Peirolo. All rights reserved.
//

import UIKit

class ProblemReusableView: UICollectionReusableView {
    
    internal var header: String? {
        didSet {
            label.text = header
        }
    }
    
    fileprivate lazy var label: UILabel = {
        let _label = UILabel()
        _label.translatesAutoresizingMaskIntoConstraints = false
        _label.font = UIFont.preferredFont(forTextStyle: .title1)
        _label.textColor = Constants.Colors.primaryText
        _label.numberOfLines = 0
        _label.textAlignment = .center
        return _label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // Add subviews
        addSubview(label)
        
        // Add constraints
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            label.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16),
            label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            label.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16)
            ])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
