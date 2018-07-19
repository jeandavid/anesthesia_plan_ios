//
//  ChoiceCell.swift
//  Anesthesia Plan
//
//  Created by Jean-David Morgenstern-Peirolo on 6/28/18.
//  Copyright © 2018 Jean-David Morgenstern-Peirolo. All rights reserved.
//

import UIKit

class ChoiceCell: UICollectionViewCell {
    
    enum Font {
        static let headerFont: UIFont = UIFont.preferredFont(forTextStyle: .headline)
    }
    
    internal var checked: Bool = false {
        didSet {
            layer.borderColor = checked ? UIColor.clear.cgColor : Constants.Colors.lightGray.cgColor
            layer.borderWidth = checked ? 0.0 : 2.0
            backgroundColor = checked ? Constants.Colors.primaryLight : Constants.Colors.background
            label.textColor = checked ? UIColor.white : Constants.Colors.primaryText
        }
    }
    
    internal var choice: String? {
        didSet {
            label.text = choice
        }
    }
    
    fileprivate lazy var label: UILabel = {
        let _label = UILabel()
        _label.translatesAutoresizingMaskIntoConstraints = false
        _label.font = Font.headerFont
        _label.textColor = Constants.Colors.primaryText
        _label.numberOfLines = 1
        _label.textAlignment = .right
        return _label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // prepare views
        layer.cornerRadius = 25.0
        addSubview(label)
        
        // prepare constraints
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: topAnchor, constant: 16.0),
            label.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16.0),
            label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16.0),
            label.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16.0)
            ])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

