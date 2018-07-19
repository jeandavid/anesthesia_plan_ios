//
//  PlanDetailViewController.swift
//  Anesthesia Plan
//
//  Created by Jean-David Morgenstern-Peirolo on 7/1/18.
//  Copyright © 2018 Jean-David Morgenstern-Peirolo. All rights reserved.
//

import UIKit

class PlanDetailViewController: UICollectionViewController {
    
    fileprivate let viewModel: PlanDetailViewModel
    
    init(viewModel: PlanDetailViewModel) {
        self.viewModel = viewModel
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
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
        prepareNavigationBar()
        prepareCollectionView()
        view.addSubview(notificationView)
        
        // prepare constraints
        NSLayoutConstraint.activate([
            notificationView.heightAnchor.constraint(equalToConstant: 150),
            notificationView.widthAnchor.constraint(equalToConstant: 150),
            notificationView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            notificationView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
            ])
        
        // prepare view models
        prepareViewModel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if #available(iOS 11.0, *) {
            navigationController?.navigationBar.prefersLargeTitles = true
            navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
        }
    }
    
    /*************************
     *                       *
     *         VIEWS         *
     *                       *
     *************************/
    fileprivate lazy var notificationView: NotificationView = {
        let text: String = NSLocalizedString("DeletedConfirmView.Title", comment: "")
        let _view = NotificationView(text: text)
        _view.translatesAutoresizingMaskIntoConstraints = false
        _view.alpha = 0.0
        return _view
    }()
    
    fileprivate let sectionInsets: UIEdgeInsets = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
    fileprivate let QUESTION_CELL_IDENTIFIER: String = "QuestionCellIdentifier"
    
    func prepareCollectionView() {
        collectionView?.backgroundColor = Constants.Colors.primary
        collectionView?.register(QuestionCell.self, forCellWithReuseIdentifier: QUESTION_CELL_IDENTIFIER)
    }
    
    func prepareNavigationBar() {
        title = "פרטי התוכנית"
        let deleteButton = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(deleteButtonTapped))
        navigationItem.setRightBarButton(deleteButton, animated: true)
    }
    
    @objc func deleteButtonTapped() {
        let message: String = NSLocalizedString("PlanDetailViewController.DeleteAlert.Message", comment: "")
        let alertController = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        let deleteAction = UIAlertAction(title: NSLocalizedString("DeleteActionTitle", comment: ""), style: .destructive) { (_) in
            self.viewModel.deleteButtonTapped()
        }
        alertController.addAction(deleteAction)
        let cancelAction = UIAlertAction(title: NSLocalizedString("CancelActionTitle", comment: ""), style: .cancel)
        alertController.addAction(cancelAction)
        present(alertController, animated: true)
    }
    
    func showErrorAlert(message: String) {
        let alertController = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        let continueAction = UIAlertAction(title: NSLocalizedString("OkActionTitle", comment: ""), style: .cancel)
        alertController.addAction(continueAction)
        present(alertController, animated: true)
    }
    
    /*************************
     *                       *
     *     VIEW MODELS       *
     *                       *
     *************************/
    func prepareViewModel() {
        viewModel.reloadCollectionView = { [weak self] () in
            DispatchQueue.main.async {
                self?.collectionView?.reloadData()
            }
        }
        viewModel.showEditPlanViewController = { [weak self] (_ editPlanViewModel: EditPlanViewModel) in
            DispatchQueue.main.async {
                self?.showEditPlanViewController(viewModel: editPlanViewModel)
            }
        }
        viewModel.showErrorAlert = { [weak self] (_ message: String) in
            DispatchQueue.main.async {
                self?.showErrorAlert(message: message)
            }
        }
        viewModel.showNotificationView = { [weak self] (_ title: String) in
            DispatchQueue.main.async {
                self?.notificationView.show(animated: true, completion: {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                        self?.navigationController?.popViewController(animated: true)
                    }
                })
            }
        }
    }
    
    /*************************
     *                       *
     *      NAVIGATION       *
     *                       *
     *************************/
    func showEditPlanViewController(viewModel: EditPlanViewModel) {
        let editPlanViewController: EditPlanViewController = EditPlanViewController(viewModel: viewModel)
        navigationController?.pushViewController(editPlanViewController, animated: true)
    }
}

/*************************
 *                       *
 *     DATA SOURCE       *
 *                       *
 *************************/
extension PlanDetailViewController {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfCells
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: QUESTION_CELL_IDENTIFIER, for: indexPath) as! QuestionCell
        let questionCellModel: QuestionCellModel = viewModel.getQuestionCellModel(at: indexPath)
        cell.header = questionCellModel.headerText
        cell.subheader = questionCellModel.subheaderText
        return cell
    }
}

/*************************
 *                       *
 *       DELEGATE        *
 *                       *
 *************************/
extension PlanDetailViewController {
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.questionSelected(at: indexPath)
        collectionView.deselectItem(at: indexPath, animated: true)
    }
}

extension PlanDetailViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let questionCellModel: QuestionCellModel = viewModel.getQuestionCellModel(at: indexPath)
        let marginSpace: CGFloat = sectionInsets.left + sectionInsets.right
        let cellWidth: CGFloat = collectionView.frame.width - marginSpace
        let labelWidth: CGFloat = cellWidth - marginSpace
        let headerHeight = questionCellModel.headerText?.height(withConstrainedWidth: labelWidth, font: QuestionCell.Font.headerFont) ?? 0
        let subheaderHeight = questionCellModel.subheaderText?.height(withConstrainedWidth: labelWidth, font: QuestionCell.Font.subheaderFont) ?? 0
        let height: CGFloat = QuestionCell.Margin.top + headerHeight + QuestionCell.Margin.middle + subheaderHeight + QuestionCell.Margin.bottom
        return CGSize(width: cellWidth, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInsets.top
    }
}

