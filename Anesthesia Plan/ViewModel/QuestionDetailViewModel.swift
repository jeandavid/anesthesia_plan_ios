//
//  QuestionDetailViewModel.swift
//  Anesthesia Plan
//
//  Created by Jean-David Morgenstern-Peirolo on 6/29/18.
//  Copyright © 2018 Jean-David Morgenstern-Peirolo. All rights reserved.
//

import Foundation

class QuestionDetailViewModel {
    
    /*************************
     *                       *
     *      INIT/DEINIT      *
     *                       *
     *************************/
    init(question: Question, page: Int, totalPages: Int) {
        self.question = question
        self.page = page
        self.totalPages = totalPages
    }
    
    /*************************
     *                       *
     *       PROPERTIES      *
     *                       *
     *************************/
    fileprivate let question: Question
    fileprivate let page: Int
    fileprivate let totalPages: Int
    
    /*************************
     *                       *
     *       INTERFACES      *
     *                       *
     *************************/
    internal var showLargeCollectionView: Bool {
        return (question is MultiChoice) && (question as! MultiChoice).layout == MultiChoice.Layout.large.rawValue
    }
    
    internal var showSmallCollectionView: Bool {
        return (question is MultiChoice) && (question as! MultiChoice).layout == MultiChoice.Layout.small.rawValue
    }
    
    internal var showTextView: Bool {
        return question is FreeText
    }
    
    internal var pageLabelText: String {
        return "\(page + 1) / \(totalPages)"
    }
    
    internal var input: String? {
        return (question as? FreeText)?.input
    }
    
    internal var problem: String? {
        return question.problem
    }
    
    internal var multiChoice: MultiChoice? {
        return question as? MultiChoice
    }
    
    internal func textDidChange(_ text: String) {
        (question as? FreeText)?.input = text
    }
}
