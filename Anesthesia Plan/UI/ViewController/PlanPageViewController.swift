//
//  PlanPageViewController.swift
//  Anesthesia Plan
//
//  Created by Jean-David Morgenstern-Peirolo on 6/29/18.
//  Copyright © 2018 Jean-David Morgenstern-Peirolo. All rights reserved.
//

import UIKit

protocol PlanPageViewControllerDelegate: AnyObject {
    func didChangePage(to index: Int)
}

class PlanPageViewController: UIPageViewController {
    
    let plan: Plan
    let startPage: Int
    weak var planPageDelegate: PlanPageViewControllerDelegate?
    
    init(plan: Plan, startPage: Int = 0, delegate: PlanPageViewControllerDelegate? = nil) {
        self.plan = plan
        self.startPage = startPage
        self.planPageDelegate = delegate
        super.init(transitionStyle: .scroll, navigationOrientation: .horizontal)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /*************************
     *                       *
     *       LIFE CYCLE      *
     *                       *
     *************************/
    override func viewDidLoad() {
        super.viewDidLoad()
        view.layer.cornerRadius = Constants.questionRoundedCornerRadius
        dataSource = self
        delegate = self
        
        guard questionDetailViewControllers.count > startPage else {return}
        let questionDetailViewController = questionDetailViewControllers[startPage]
        setViewControllers([questionDetailViewController], direction: .forward, animated: true, completion: nil)
    }
    
    /*************************
     *                       *
     *         VIEWS         *
     *                       *
     *************************/
    fileprivate lazy var questionDetailViewControllers: [UIViewController] = {
        let _viewControllers: [UIViewController]? = plan.questions?.array.enumerated().compactMap({
            guard let question = $0.element as? Question else {return nil}
            let viewModel = QuestionDetailViewModel(question: question, page: $0.offset, totalPages: plan.questions?.array.count ?? 0)
            return QuestionDetailViewController(viewModel: viewModel)
        })
        return _viewControllers ?? []
    }()
}

/*************************
 *                       *
 *     DATA SOURCE       *
 *                       *
 *************************/
extension PlanPageViewController: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let vcIndex = questionDetailViewControllers.index(of: viewController) else {return nil}
        let prevIndex = vcIndex - 1
        guard prevIndex >= 0 else {return nil}
        guard questionDetailViewControllers.count > prevIndex else {return nil}
        return questionDetailViewControllers[prevIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let vcIndex = questionDetailViewControllers.index(of: viewController) else {return nil}
        let nextIndex = vcIndex + 1
        guard questionDetailViewControllers.count != nextIndex else {return nil}
        guard questionDetailViewControllers.count > nextIndex else {return nil}
        return questionDetailViewControllers[nextIndex]
    }
}

/*************************
 *                       *
 *       DELEGATE        *
 *                       *
 *************************/
extension PlanPageViewController: UIPageViewControllerDelegate {
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        guard completed else {return}
        guard let nextQuestionDetailViewController = pageViewController.viewControllers?.first as? QuestionDetailViewController else {return}
        guard let nextIndex = questionDetailViewControllers.index(of: nextQuestionDetailViewController) else {return}
        planPageDelegate?.didChangePage(to: nextIndex)
    }
}
