//
//  QuestionCell.swift
//  Anesthesia Plan
//
//  Created by Jean-David Morgenstern-Peirolo on 6/28/18.
//  Copyright © 2018 Jean-David Morgenstern-Peirolo. All rights reserved.
//

import UIKit

class QuestionCell: UICollectionViewCell {
    
    enum Margin {
        static let top: CGFloat = 8.0
        static let bottom: CGFloat = 8.0
        static let middle: CGFloat = 6.0
    }
    
    enum Font {
        static let headerFont: UIFont = UIFont.preferredFont(forTextStyle: .headline)
        static let subheaderFont: UIFont = UIFont.preferredFont(forTextStyle: .title1)
    }
    
    internal var header: String? {
        didSet {
            headerLabel.text = header
        }
    }
    
    internal var subheader: String? {
        didSet {
            subheaderLabel.text = subheader
        }
    }
    
    fileprivate lazy var headerLabel: UILabel = {
        let _label = UILabel()
        _label.translatesAutoresizingMaskIntoConstraints = false
        _label.font = Font.headerFont
        _label.textColor = Constants.Colors.primaryLight
        _label.numberOfLines = 1
        return _label
    }()
    
    fileprivate lazy var subheaderLabel: UILabel = {
        let _label = UILabel()
        _label.translatesAutoresizingMaskIntoConstraints = false
        _label.font = Font.subheaderFont
        _label.textColor = Constants.Colors.accent
        _label.numberOfLines = 0
        return _label
    }()
    
    fileprivate lazy var questionStackView: UIStackView = {
        let _stackView = UIStackView()
        _stackView.translatesAutoresizingMaskIntoConstraints = false
        _stackView.axis = .vertical
        _stackView.spacing = QuestionCell.Margin.middle
        _stackView.layoutMargins = UIEdgeInsets(top: QuestionCell.Margin.top, left: 16.0, bottom: QuestionCell.Margin.bottom, right: 16.0)
        _stackView.isLayoutMarginsRelativeArrangement = true
        return _stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // prepare views
        backgroundColor = UIColor.white
        layer.cornerRadius = 25.0
        prepareQuestionStackView()
        
        // prepare constraints
        NSLayoutConstraint.activate([
            questionStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            questionStackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            questionStackView.topAnchor.constraint(equalTo: topAnchor),
            questionStackView.bottomAnchor.constraint(equalTo: bottomAnchor)
            ])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func prepareQuestionStackView() {
        questionStackView.addArrangedSubview(headerLabel)
        questionStackView.addArrangedSubview(subheaderLabel)
        addSubview(questionStackView)
    }
}


