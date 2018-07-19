//
//  HomeViewModel.swift
//  Anesthesia Plan
//
//  Created by Jean-David Morgenstern-Peirolo on 6/28/18.
//  Copyright © 2018 Jean-David Morgenstern-Peirolo. All rights reserved.
//

import Foundation
import CoreData

class HomeViewModel {
    
    /*************************
     *                       *
     *      INIT/DEINIT      *
     *                       *
     *************************/
    init(managedObjectContext: NSManagedObjectContext) {
        self.managedObjectContext = managedObjectContext
        self.mode = .done
        loadPlans()
        
        NotificationCenter.default.addObserver(self, selector: #selector(managedObjectContextDidSave), name: NSNotification.Name.NSManagedObjectContextDidSave, object: managedObjectContext)
        NotificationCenter.default.addObserver(self, selector: #selector(managedObjectContextObjectsDidChange), name: NSNotification.Name.NSManagedObjectContextObjectsDidChange, object: managedObjectContext)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    /*************************
     *                       *
     *       PROPERTIES      *
     *                       *
     *************************/
    fileprivate let managedObjectContext: NSManagedObjectContext
    
    fileprivate var plans: [Plan] = []
    
    fileprivate var selected: Set<Plan> = []
    
    enum Mode {
        case edit
        case done
        
        mutating func toggle() {
            switch self {
            case .edit:
                self = .done
            case .done:
                self = .edit
            }
        }
    }
    
    fileprivate var mode: Mode {
        didSet {
            updateEditMode?(mode)
        }
    }
    
    /*************************
     *                       *
     *       INTERFACES      *
     *                       *
     *************************/
    internal var reloadItems: ((_ indexPath: [IndexPath]) -> ())?
    internal var insertItems: ((_ indexPath: [IndexPath]) -> ())?
    internal var deleteItems: ((_ indexPath: [IndexPath]) -> ())?
    internal var showEditPlanViewController: ((_ editPlanViewModel: EditPlanViewModel)->())?
    internal var showPlanDetailViewController: ((_ planDetailViewModel: PlanDetailViewModel)->())?
    internal var showErrorAlert: ((_ message: String)->())?
    internal var updateEditMode: ((_ mode: Mode) -> ())?
    internal var showNotificationView: ((_ title: String) -> ())?
    internal var updateDeleteButton: ((_ title: String) -> ())?
    
    internal func planSelected(at indexPath: IndexPath) {
        let plan = plans[indexPath.row]
        switch mode {
        case .done:
            let planDetailViewModel = PlanDetailViewModel(managedObjectContext: managedObjectContext, plan: plan)
            showPlanDetailViewController?(planDetailViewModel)
            break
        case .edit:
            if selected.contains(plan) {
                selected.remove(plan)
            } else {
                selected.insert(plan)
            }
            reloadItems?([indexPath])
            let defaultTitle = NSLocalizedString("HomeViewController.DeleteButton.Title.Default", comment: "")
            let counterTitleTemplate = NSLocalizedString("HomeViewController.DeleteButton.Title.Counter", comment: "")
            let counterTitle = String(format: counterTitleTemplate, selected.count)
            updateDeleteButton?(selected.count > 0 ? counterTitle : defaultTitle)
            break
        }
    }
    
    internal func editButtonTapped() {
        switch mode {
        case .done:
            mode.toggle()
            break
        case .edit:
            deleteButtonTapped()
            break
        }
    }
    
    internal func deleteButtonTapped() {
        if selected.isEmpty {
            mode.toggle()
        } else {
            deletePlans()
        }
    }
    
    internal func addButtonTapped() {
        let plan = Plan(createdAt: Date(), managedObjectContext: managedObjectContext)
        let editPlanViewModel = EditPlanViewModel(managedObjectContext: managedObjectContext, plan: plan, isNew: true)
        showEditPlanViewController?(editPlanViewModel)
    }
    
    internal func getPlanCellModel(at indexPath: IndexPath) -> PlanCellModel {
        let plan = plans[indexPath.row]
        return PlanCellModel(plan: plan, selectedForDeletion: selected.contains(plan))
    }
    
    internal var numberOfCells: Int {
        return plans.count
    }
    
    internal func viewDidLoad() {
        if plans.isEmpty {
            let plan = Plan(createdAt: Date(), managedObjectContext: managedObjectContext)
            let editPlanViewModel = EditPlanViewModel(managedObjectContext: managedObjectContext, plan: plan, isNew: true)
            showEditPlanViewController?(editPlanViewModel)
        }
    }
    
    /****************************
     *                          *
     *     DATA OPERATIONS      *
     *                          *
     ****************************/
    fileprivate func loadPlans() {
        let request: NSFetchRequest<Plan> = Plan.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "createdAt", ascending: false)
        request.sortDescriptors = [sortDescriptor]
        do {
            plans = try managedObjectContext.fetch(request)
        } catch let error as NSError {
            showErrorAlert?(error.localizedDescription)
        }
    }
    
    fileprivate func deletePlans() {
        selected.forEach {managedObjectContext.delete($0)}
        showNotificationView?(NSLocalizedString("DeletedConfirmView.Title", comment: ""))
        selected = []
        mode.toggle()
    }
    
    // Updates and insertion are saved immediately.
    // We are notified here and we keep our plans list in sync.
    @objc func managedObjectContextDidSave(notification: NSNotification) {
        guard let userInfo = notification.userInfo else { return }

        if let insertedObjects = userInfo[NSInsertedObjectsKey] as? Set<NSManagedObject>, insertedObjects.count > 0 {
            let newPlans = insertedObjects.compactMap({$0 as? Plan})
            guard !newPlans.isEmpty else {return}
            plans.insert(contentsOf: newPlans, at: 0)
            let indexPath: [IndexPath] = newPlans.enumerated().map {IndexPath(row: $0.offset, section: 0)}
            insertItems?(indexPath)
        }
        
        if let updatedObjects = userInfo[NSUpdatedObjectsKey] as? Set<NSManagedObject>, updatedObjects.count > 0 {
            var updatedPlans: Set<Plan> = []
            updatedObjects.forEach {
                switch $0 {
                case let plan as Plan:
                    updatedPlans.insert(plan)
                    break
                case let question as Question:
                    guard let plan = question.plan else {break}
                    updatedPlans.insert(plan)
                    break
                case let choice as Choice:
                    guard let plan = choice.question?.plan else {break}
                    updatedPlans.insert(plan)
                    break
                default:
                    break
                }
            }
            var indexPath: [IndexPath] = []
            plans = plans
                .enumerated()
                .map {
                    let offset = $0.offset
                    let plan = $0.element
                    let updatedPlan: Plan? = updatedPlans.filter({$0 == plan}).first
                    if updatedPlan != nil {
                        indexPath.append(IndexPath(row: offset, section: 0))
                    }
                    return updatedPlan ?? plan
            }
            reloadItems?(indexPath)
        }
    }
    
    // Only deletion aren't saved immediately.
    // We listen here for "should-be-removed" plans from persistent store
    // and we filter them out from our plan lists.
    @objc func managedObjectContextObjectsDidChange(notification: NSNotification) {
        guard let context = notification.object as? NSManagedObjectContext else {return}
        let deletedPlans = context.deletedObjects.compactMap({$0 as? Plan})
        if deletedPlans.count > 0 {
            var indexPath: [IndexPath] = []
            plans = plans
                .enumerated()
                .filter({
                    let offset = $0.offset
                    let plan = $0.element
                    let isPlanDeleted: Bool = deletedPlans.contains(plan)
                    if isPlanDeleted {
                        indexPath.append(IndexPath(row: offset, section: 0))
                    }
                    return !isPlanDeleted
                })
                .map({$0.element})
            deleteItems?(indexPath)
        }
    }
}

