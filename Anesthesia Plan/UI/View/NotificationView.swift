//
//  NotificationView.swift
//  Anesthesia Plan
//
//  Created by Jean-David Morgenstern-Peirolo on 6/28/18.
//  Copyright © 2018 Jean-David Morgenstern-Peirolo. All rights reserved.
//

import UIKit

class NotificationView: UIView {
    
    fileprivate lazy var imageView: UIImageView = {
        let _imageView = UIImageView()
        _imageView.image = UIImage(named: "SavedIcon")
        _imageView.translatesAutoresizingMaskIntoConstraints = false
        return _imageView
    }()
    
    fileprivate lazy var titleLabel: UILabel = {
        let _label = UILabel()
        _label.translatesAutoresizingMaskIntoConstraints = false
        _label.font = UIFont.preferredFont(forTextStyle: .headline)
        _label.numberOfLines = 0
        _label.textColor = .white
        _label.textAlignment = .center
        return _label
    }()
    
    fileprivate lazy var stackView: UIStackView = {
        let _stackView = UIStackView()
        _stackView.translatesAutoresizingMaskIntoConstraints = false
        _stackView.axis = .vertical
        _stackView.alignment = .center
        _stackView.spacing = 8
        return _stackView
    }()
    
    fileprivate func setAlpha(_ alpha: CGFloat, animated: Bool, delay: TimeInterval = 0.0, completion: (() -> Void)? = nil) {
        let duration = animated ? 0.3 : 0
        UIView.animate(withDuration: duration, delay: delay, animations: {
            self.alpha = alpha
        }, completion: { _ in
            completion?()
        })
    }
    
    internal static func notificationView(in view: UIView) -> NotificationView? {
        return view.subviews.first(where: { $0 is NotificationView }) as? NotificationView
    }
    
    internal convenience init(text: String) {
        self.init(frame: .zero)
        
        // prepare views
        titleLabel.text = text
        backgroundColor = UIColor.black.withAlphaComponent(0.5)
        layer.cornerRadius = 25.0
        stackView.addArrangedSubview(imageView)
        stackView.addArrangedSubview(titleLabel)
        addSubview(stackView)
        
        // prepare constraints
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: centerYAnchor),
            stackView.leftAnchor.constraint(equalTo: leftAnchor, constant: 20),
            stackView.rightAnchor.constraint(equalTo: rightAnchor, constant: -20),
            imageView.widthAnchor.constraint(equalToConstant: 50),
            imageView.heightAnchor.constraint(equalToConstant: 50)
            ])
        
        hide(animated: false)
    }
    
    internal func show(animated: Bool, delay: TimeInterval = 0.0, completion: (() -> Void)? = nil) {
        setAlpha(1, animated: animated, delay: delay, completion: completion)
    }
    
    internal func hide(animated: Bool, delay: TimeInterval = 0.0, completion: (() -> Void)? = nil)  {
        setAlpha(0, animated: animated, delay: delay, completion: completion)
    }
}


