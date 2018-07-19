//
//  PlanCell.swift
//  Anesthesia Plan
//
//  Created by Jean-David Morgenstern-Peirolo on 6/28/18.
//  Copyright © 2018 Jean-David Morgenstern-Peirolo. All rights reserved.
//

import UIKit

class PlanCell: UICollectionViewCell {
    
    enum Margin {
        static let top: CGFloat = 8.0
        static let bottom: CGFloat = 8.0
        static let middle: CGFloat = 6.0
    }
    
    enum Font {
        static let headerFont: UIFont = UIFont.preferredFont(forTextStyle: .title1)
        static let subheaderFont: UIFont = UIFont.preferredFont(forTextStyle: .headline)
        static let timeAndDateFont: UIFont = UIFont.preferredFont(forTextStyle: .subheadline)
    }
    
    internal var selectedForDeletion: Bool = false {
        didSet {
            imageView.isHidden = !selectedForDeletion
            backgroundColor = selectedForDeletion ? UIColor.black.withAlphaComponent(0.5) : UIColor.white
        }
    }
    
    internal var timeAndDate: String? {
        didSet {
            timeAndDateLabel.text = timeAndDate
        }
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
        _label.textColor = Constants.Colors.accent
        _label.numberOfLines = 1
        return _label
    }()
    
    fileprivate lazy var subheaderLabel: UILabel = {
        let _label = UILabel()
        _label.translatesAutoresizingMaskIntoConstraints = false
        _label.font = Font.subheaderFont
        _label.textColor = Constants.Colors.primaryLight
        _label.numberOfLines = 1
        return _label
    }()
    
    fileprivate lazy var timeAndDateLabel: UILabel = {
        let _label = UILabel()
        _label.translatesAutoresizingMaskIntoConstraints = false
        _label.font = Font.timeAndDateFont
        _label.textColor = Constants.Colors.secondaryText
        _label.numberOfLines = 1
        _label.textAlignment = .right
        return _label
    }()
    
    fileprivate lazy var mainStackView: UIStackView = {
        let _stackView = UIStackView()
        _stackView.translatesAutoresizingMaskIntoConstraints = false
        _stackView.axis = .horizontal
        _stackView.alignment = .center
        _stackView.distribution = .fill
        _stackView.spacing = 16
        _stackView.layoutMargins = UIEdgeInsets(top: Margin.top, left: 16.0, bottom: Margin.bottom, right: 16.0)
        _stackView.isLayoutMarginsRelativeArrangement = true
        return _stackView
    }()
    
    fileprivate lazy var questionStackView: UIStackView = {
        let _stackView = UIStackView()
        _stackView.translatesAutoresizingMaskIntoConstraints = false
        _stackView.axis = .vertical
        _stackView.spacing = Margin.middle
        return _stackView
    }()
    
    private lazy var imageView: UIImageView = {
        let _imageView = UIImageView()
        _imageView.image = UIImage(named: "DeleteIcon")
        _imageView.translatesAutoresizingMaskIntoConstraints = false
        _imageView.isHidden = true
        return _imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = UIColor.white
        layer.cornerRadius = 25.0
        
        // prepare views
        prepareImageView()
        prepareQuestionStackView()
        prepareMainStackView()
        
        // prepare constraints
        NSLayoutConstraint.activate([
            mainStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            mainStackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            mainStackView.topAnchor.constraint(equalTo: topAnchor),
            imageView.widthAnchor.constraint(equalToConstant: 30),
            imageView.heightAnchor.constraint(equalToConstant: 30),
            imageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: centerYAnchor)
            ])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func prepareImageView() {
        addSubview(imageView)
    }
    
    func prepareMainStackView() {
        mainStackView.addArrangedSubview(questionStackView)
        mainStackView.addArrangedSubview(UIView())
        mainStackView.addArrangedSubview(timeAndDateLabel)
        addSubview(mainStackView)
    }
    
    func prepareQuestionStackView() {
        questionStackView.addArrangedSubview(headerLabel)
        questionStackView.addArrangedSubview(subheaderLabel)
    }
}

