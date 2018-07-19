//
//  EditPlanViewController.swift
//  Anesthesia Plan
//
//  Created by Jean-David Morgenstern-Peirolo on 7/1/18.
//  Copyright © 2018 Jean-David Morgenstern-Peirolo. All rights reserved.
//

import UIKit

class EditPlanViewController: UIViewController {
    
    fileprivate let viewModel: EditPlanViewModel
    
    init(viewModel: EditPlanViewModel) {
        self.viewModel = viewModel
        self.planPageViewController = viewModel.startPlanPageViewController
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
        prepareView()
        prepareNavigationBar()
        view.addSubview(pageControl)
        view.addSubview(containerView)
        view.addSubview(savedNotificationView)
        
        // prepare constraints
        NSLayoutConstraint.activate([
            pageControl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            pageControl.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor),
            containerView.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
            containerView.topAnchor.constraint(equalTo: view.topAnchor, constant: 16),
            containerView.heightAnchor.constraint(equalTo: view.layoutMarginsGuide.heightAnchor, multiplier: 0.75),
            savedNotificationView.heightAnchor.constraint(equalToConstant: 150),
            savedNotificationView.widthAnchor.constraint(equalToConstant: 150),
            savedNotificationView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            savedNotificationView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
            ])
        
        // prepare view models
        prepareViewModel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if #available(iOS 11.0, *) {
            navigationController?.navigationBar.prefersLargeTitles = false
        }
        add(planPageViewController, to: containerView)
    }
    
    /*************************
     *                       *
     *         VIEWS         *
     *                       *
     *************************/
    fileprivate let planPageViewController: PlanPageViewController
    
    fileprivate lazy var containerView: UIView = {
        let _view = UIView()
        _view.translatesAutoresizingMaskIntoConstraints = false
        _view.addShadow()
        return _view
    }()
    
    fileprivate lazy var pageControl: UIPageControl = {
        let _control = UIPageControl()
        _control.translatesAutoresizingMaskIntoConstraints = false
        _control.numberOfPages = viewModel.numberOfQuestions
        _control.currentPage = viewModel.currentPage
        return _control
    }()
    
    fileprivate lazy var savedNotificationView: NotificationView = {
        let text: String = NSLocalizedString("SavedConfirmView.Title", comment: "")
        let _view = NotificationView(text: text)
        _view.translatesAutoresizingMaskIntoConstraints = false
        _view.alpha = 0.0
        return _view
    }()
    
    func prepareView() {
        view.backgroundColor = Constants.Colors.primary
        planPageViewController.planPageDelegate = self
        
        // add gestures
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(swipe))
        swipeLeft.direction = .left
        view.addGestureRecognizer(swipeLeft)
        
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(swipe))
        swipeRight.direction = .right
        view.addGestureRecognizer(swipeRight)
    }
    
    func prepareNavigationBar() {
        title = viewModel.title
        let stopButton = UIBarButtonItem(barButtonSystemItem: .stop, target: self, action: #selector(stopButtonTapped))
        navigationItem.setLeftBarButton(stopButton, animated: true)
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneButtonTapped))
        navigationItem.setRightBarButton(doneButton, animated: true)
    }
    
    @objc func stopButtonTapped() {
        viewModel.stopButtonTapped()
    }
    
    @objc func doneButtonTapped() {
        viewModel.doneButtonTapped()
    }
    
    @objc func swipe(swipeRecognizer: UISwipeGestureRecognizer) {
        if swipeRecognizer.direction == .right {
            viewModel.didSwipeRight()
        } else if swipeRecognizer.direction == .left {
            viewModel.didSwipeLeft()
        }
    }
    
    func showErrorAlert(message: String) {
        let alertController = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        let okActionTitle = NSLocalizedString("OkActionTitle", comment: "")
        let continueAction = UIAlertAction(title: okActionTitle, style: .cancel)
        alertController.addAction(continueAction)
        present(alertController, animated: true)
    }
    
    /*************************
     *                       *
     *     VIEW MODELS       *
     *                       *
     *************************/
    func prepareViewModel() {
        viewModel.showErrorAlert = { [weak self] (_ message: String) in
            DispatchQueue.main.async {
                self?.showErrorAlert(message: message)
            }
        }
        viewModel.showNotificationView = { [weak self] (_ title: String) in
            DispatchQueue.main.async {
                self?.savedNotificationView.show(animated: true, completion: {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                        self?.navigationController?.popViewController(animated: true)
                    }
                })
            }
        }
        viewModel.showNextPage = { [weak self] () in
            DispatchQueue.main.async {
                self?.planPageViewController.goToNextPage()
            }
        }
        viewModel.showPrevPage = { [weak self] () in
            DispatchQueue.main.async {
                self?.planPageViewController.goToPreviousPage()
            }
        }
        viewModel.updatePageControl = { [weak self] (_ currentPage: Int) in
            DispatchQueue.main.async {
                self?.pageControl.currentPage = currentPage
            }
        }
        viewModel.closeView = { [weak self] () in
            DispatchQueue.main.async {
                self?.navigationController?.popViewController(animated: true)
            }
        }
    }
}

/*************************
 *                       *
 *       DELEGATE        *
 *                       *
 *************************/
extension EditPlanViewController: PlanPageViewControllerDelegate {
    func didChangePage(to index: Int) {
        viewModel.currentPage = index
    }
}

