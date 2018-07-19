//
//  HomeViewController.swift
//  Anesthesia Plan
//
//  Created by Jean-David Morgenstern-Peirolo on 7/1/18.
//  Copyright © 2018 Jean-David Morgenstern-Peirolo. All rights reserved.
//

import UIKit

class HomeViewController: UICollectionViewController {
    
    fileprivate let viewModel: HomeViewModel
    
    init(viewModel: HomeViewModel) {
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
        prepareDeleteVisualView()
        prepareDeleteConfirmView()
        
        // prepare constraints
        NSLayoutConstraint.activate([
            deleteVisualView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            deleteVisualView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            deleteVisualView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            deleteButton.leadingAnchor.constraint(equalTo: deleteVisualView.leadingAnchor, constant: 16.0),
            deleteButton.topAnchor.constraint(equalTo: deleteVisualView.topAnchor, constant: 16.0),
            deleteButton.bottomAnchor.constraint(equalTo: deleteVisualView.bottomAnchor, constant: -16.0),
            deleteButton.trailingAnchor.constraint(equalTo: deleteVisualView.trailingAnchor, constant: -16.0),
            deleteButton.heightAnchor.constraint(equalToConstant: 48),
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
    fileprivate var editButton: UIBarButtonItem!
    fileprivate var doneButton: UIBarButtonItem!
    
    fileprivate lazy var deleteVisualView: UIVisualEffectView = {
        let _view: UIVisualEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .light))
        _view.translatesAutoresizingMaskIntoConstraints = false
        _view.alpha = 0.0
        return _view
    }()
    
    fileprivate lazy var deleteButton: UIButton = {
        let _button: UIButton = UIButton()
        _button.translatesAutoresizingMaskIntoConstraints = false
        _button.backgroundColor = UIColor(rgb: 0x13142C)
        _button.setTitleColor(UIColor.white, for: .normal)
        let title: String = NSLocalizedString("HomeViewController.DeleteButton.Title.Default", comment: "")
        _button.setTitle(title, for: .normal)
        return _button
    }()
    
    fileprivate lazy var notificationView: NotificationView = {
        let text: String = NSLocalizedString("DeletedConfirmView.Title", comment: "")
        let _view = NotificationView(text: text)
        _view.translatesAutoresizingMaskIntoConstraints = false
        _view.alpha = 0.0
        return _view
    }()
    
    func prepareNavigationBar() {
        title = NSLocalizedString("HomeViewController.Title", comment: "")
        
        navigationController?.view.backgroundColor = Constants.Colors.primary
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.barTintColor = Constants.Colors.primary
        navigationController?.navigationBar.backgroundColor = Constants.Colors.primary
        navigationController?.navigationBar.tintColor = UIColor.white
        navigationController?.navigationBar.hideShadow(true)
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
        // prepare buttons
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonTapped))
        navigationItem.setLeftBarButton(addButton, animated: true)
        editButton = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(editButtonTapped))
        doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(editButtonTapped))
        navigationItem.setRightBarButton(editButton, animated: true)
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
    
    @objc func addButtonTapped() {
        viewModel.addButtonTapped()
    }
    
    @objc func editButtonTapped() {
        viewModel.editButtonTapped()
    }
    
    @objc func deleteButtonTapped() {
        viewModel.deleteButtonTapped()
    }
    
    func prepareDeleteVisualView() {
        deleteButton.addTarget(self, action: #selector(deleteButtonTapped), for: .touchUpInside)
        deleteVisualView.contentView.addSubview(deleteButton)
        view.addSubview(deleteVisualView)
    }
    
    func prepareDeleteConfirmView() {
        view.addSubview(notificationView)
    }
    
    fileprivate let sectionInsets: UIEdgeInsets = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
    fileprivate let PLAN_CELL_IDENTIFIER: String = "PlanCellIdentifier"
    
    func prepareCollectionView() {
        collectionView?.allowsMultipleSelection = false
        collectionView?.backgroundColor = Constants.Colors.primary
        collectionView?.register(PlanCell.self, forCellWithReuseIdentifier: PLAN_CELL_IDENTIFIER)
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
        viewModel.reloadItems = { [weak self] (_ indexPath: [IndexPath]) in
            DispatchQueue.main.async {
                self?.collectionView?.reloadItems(at: indexPath)
            }
        }
        viewModel.insertItems = { [weak self] (_ indexPath: [IndexPath]) in
            DispatchQueue.main.async {
                self?.collectionView?.insertItems(at: indexPath)
            }
        }
        viewModel.deleteItems = { [weak self] (_ indexPath: [IndexPath]) in
            DispatchQueue.main.async {
                self?.collectionView?.deleteItems(at: indexPath)
            }
        }
        viewModel.updateDeleteButton = { [weak self] (_ title: String) in
            DispatchQueue.main.async {
                self?.deleteButton.setTitle(title, for: .normal)
            }
        }
        viewModel.showEditPlanViewController = { [weak self] (_ editPlanViewModel: EditPlanViewModel) in
            DispatchQueue.main.async {
                self?.showEditPlanViewController(viewModel: editPlanViewModel)
            }
        }
        viewModel.showPlanDetailViewController = { [weak self] (_ planDetailViewModel: PlanDetailViewModel) in
            DispatchQueue.main.async {
                self?.showPlanDetailViewController(viewModel: planDetailViewModel)
            }
        }
        viewModel.updateEditMode = { [weak self] (_ mode: HomeViewModel.Mode) in
            guard let strongSelf = self else {return}
            DispatchQueue.main.async {
                switch mode {
                case .edit:
                    strongSelf.navigationItem.setRightBarButton(strongSelf.doneButton, animated: true)
                    strongSelf.collectionView?.allowsMultipleSelection = true
                    UIView.animate(withDuration: 0.5, animations: {
                        strongSelf.view.bringSubview(toFront: strongSelf.deleteVisualView)
                        strongSelf.deleteVisualView.alpha = 1.0
                    })
                    break
                case .done:
                    strongSelf.navigationItem.setRightBarButton(strongSelf.editButton, animated: true)
                    strongSelf.collectionView?.allowsMultipleSelection = false
                    UIView.animate(withDuration: 0.5, animations: {
                        strongSelf.deleteVisualView.alpha = 0.0
                    })
                    break
                }
            }
        }
        viewModel.showNotificationView = { [weak self] (_ title: String) in
            DispatchQueue.main.async {
                self?.notificationView.show(animated: true, completion: {
                    self?.notificationView.hide(animated: true)
                })
            }
        }
        viewModel.showErrorAlert = { [weak self] (_ message: String) in
            DispatchQueue.main.async {
                self?.showErrorAlert(message: message)
            }
        }
        viewModel.viewDidLoad()
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
    
    func showPlanDetailViewController(viewModel: PlanDetailViewModel) {
        let planDetailViewController: PlanDetailViewController = PlanDetailViewController(viewModel: viewModel)
        navigationController?.pushViewController(planDetailViewController, animated: true)
    }
}

/*************************
 *                       *
 *     DATA SOURCE       *
 *                       *
 *************************/
extension HomeViewController {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfCells
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PLAN_CELL_IDENTIFIER, for: indexPath) as! PlanCell
        let planCellModel: PlanCellModel = viewModel.getPlanCellModel(at: indexPath)
        cell.header = planCellModel.headerText
        cell.subheader = planCellModel.subheaderText
        cell.timeAndDate = planCellModel.timeAndDateText
        cell.selectedForDeletion = planCellModel.selectedForDeletion
        return cell
    }
}

/*************************
 *                       *
 *       DELEGATE        *
 *                       *
 *************************/
extension HomeViewController {
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.planSelected(at: indexPath)
        collectionView.deselectItem(at: indexPath, animated: true)
    }
}

/*************************
 *                       *
 *       DELEGATE        *
 *                       *
 *************************/
extension HomeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let marginSpace: CGFloat = sectionInsets.left + sectionInsets.right
        let width: CGFloat = collectionView.frame.width - marginSpace
        let headerHeight = "sample".height(withConstrainedWidth: 200, font: PlanCell.Font.headerFont)
        let subheaderHeight = "sample".height(withConstrainedWidth: 200, font: PlanCell.Font.subheaderFont)
        let height: CGFloat = PlanCell.Margin.top + headerHeight + PlanCell.Margin.middle + subheaderHeight + PlanCell.Margin.bottom
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInsets.top
    }
}

