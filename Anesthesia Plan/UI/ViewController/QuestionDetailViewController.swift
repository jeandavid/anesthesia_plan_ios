//
//  QuestionDetailViewController.swift
//  Anesthesia Plan
//
//  Created by Jean-David Morgenstern-Peirolo on 6/29/18.
//  Copyright © 2018 Jean-David Morgenstern-Peirolo. All rights reserved.
//

import UIKit

class QuestionDetailViewController: UIViewController {
    
    fileprivate let viewModel: QuestionDetailViewModel
    
    init(viewModel: QuestionDetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /*************************
     *                       *
     *       LIFE CYCLE      *
     *                       *
     *************************/
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // prepare views
        view.backgroundColor = Constants.Colors.background
        preparePageLabel()
        
        if viewModel.showTextView {
            prepareProblemLabel()
            prepareTextView()
        } else if viewModel.showLargeCollectionView {
            prepareLargeCollectionView()
        } else if viewModel.showSmallCollectionView {
            prepareSmallCollectionView()
        }
    }
    
    /*************************
     *                       *
     *         VIEWS         *
     *                       *
     *************************/
    fileprivate var smallCollectionView: SmallCellCollectionView!
    fileprivate var largeCollectionView: LargeCellCollectionView!
    
    fileprivate lazy var pageLabel: UILabel = {
        let _label = UILabel()
        _label.translatesAutoresizingMaskIntoConstraints = false
        _label.font = UIFont.preferredFont(forTextStyle: .headline)
        _label.textColor = Constants.Colors.primary
        _label.textAlignment = .center
        return _label
    }()
    
    fileprivate lazy var problemLabel: UILabel = {
        let _label = UILabel()
        _label.translatesAutoresizingMaskIntoConstraints = false
        _label.font = UIFont.preferredFont(forTextStyle: .title1)
        _label.textColor = Constants.Colors.primaryText
        _label.textAlignment = .center
        _label.numberOfLines = 0
        return _label
    }()
    
    fileprivate lazy var textView: UITextView = {
        let _textView = UITextView()
        _textView.font = UIFont.preferredFont(forTextStyle: .headline)
        _textView.delegate = self
        _textView.layer.borderColor = Constants.Colors.lightGray.cgColor
        _textView.layer.borderWidth = 2
        _textView.layer.cornerRadius = Constants.questionRoundedCornerRadius
        _textView.contentInset = UIEdgeInsets(top: 8.0, left: 8.0, bottom: 8.0, right: 8.0)
        _textView.textColor = Constants.Colors.primaryText
        _textView.translatesAutoresizingMaskIntoConstraints = false
        return _textView
    }()
    
    func preparePageLabel() {
        // prepare views
        pageLabel.text = viewModel.pageLabelText
        view.addSubview(pageLabel)
        
        // prepare constraints
        NSLayoutConstraint.activate([
            pageLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16.0),
            pageLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 8.0)
            ])
    }
    
    func prepareProblemLabel() {
        // prepare views
        problemLabel.text = viewModel.problem
        view.addSubview(problemLabel)
        
        // prepare constraints
        NSLayoutConstraint.activate([
            problemLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 32),
            problemLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            problemLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            problemLabel.heightAnchor.constraint(equalToConstant: Constants.questionHeaderHeight)
            ])
    }
    
    func prepareTextView() {
        // prepare views
        textView.text = viewModel.input
        view.addSubview(textView)
        
        // prepare constraints
        NSLayoutConstraint.activate([
            textView.topAnchor.constraint(equalTo: problemLabel.bottomAnchor, constant: 16),
            textView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            textView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            textView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -16)
            ])
    }
    
    func prepareLargeCollectionView() {
        // prepare views
        guard let question = viewModel.multiChoice else {return}
        let vm = MultiChoiceCollectionViewModel(question: question)
        largeCollectionView = LargeCellCollectionView(viewModel: vm)
        view.addSubview(largeCollectionView)
        
        // prepare constraints
        largeCollectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            largeCollectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: 32),
            largeCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            largeCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            largeCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
            ])
    }
    
    func prepareSmallCollectionView() {
        // prepare views
        guard let question = viewModel.multiChoice else {return}
        let vm = MultiChoiceCollectionViewModel(question: question)
        smallCollectionView = SmallCellCollectionView(viewModel: vm)
        view.addSubview(smallCollectionView)
        
        // prepare constraints
        smallCollectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            smallCollectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: 32),
            smallCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            smallCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            smallCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
            ])
    }
}

/*************************
 *                       *
 *       DELEGATE        *
 *                       *
 *************************/
extension QuestionDetailViewController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        viewModel.textDidChange(textView.text)
    }
}
