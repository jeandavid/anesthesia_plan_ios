//
//  PlanDetailViewModel.swift
//  Anesthesia Plan
//
//  Created by Jean-David Morgenstern-Peirolo on 6/28/18.
//  Copyright © 2018 Jean-David Morgenstern-Peirolo. All rights reserved.
//

import Foundation
import CoreData

class PlanDetailViewModel {
    
    /*************************
     *                       *
     *      INIT/DEINIT      *
     *                       *
     *************************/
    init(managedObjectContext: NSManagedObjectContext, plan: Plan) {
        self.managedObjectContext = managedObjectContext
        self.plan = plan
        if let questions = plan.questions?.array as? [Question] {
            questionCellModels = questions.map {QuestionCellModel(question: $0)}
        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(managedObjectContextDidSave), name: NSNotification.Name.NSManagedObjectContextDidSave, object: managedObjectContext)
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
    
    fileprivate var plan: Plan {
        didSet {
            guard let questions = plan.questions?.array as? [Question] else {return}
            questionCellModels = questions.map {QuestionCellModel(question: $0)}
        }
    }
    
    fileprivate var questionCellModels: [QuestionCellModel] = [] {
        didSet {
            reloadCollectionView?()
        }
    }
    
    /*************************
     *                       *
     *       INTERFACES      *
     *                       *
     *************************/
    internal var reloadCollectionView: (() -> ())?
    internal var showNotificationView: ((_ title: String)->())?
    internal var showErrorAlert: ((_ message: String) -> ())?
    internal var showEditPlanViewController: ((_ editPlanViewModel: EditPlanViewModel) -> ())?
    
    internal func deleteButtonTapped() {
        deletePlan()
    }
    
    internal func questionSelected(at indexPath: IndexPath) {
        let editPlanViewModel = EditPlanViewModel(managedObjectContext: managedObjectContext, plan: plan, isNew: false, startPage: indexPath.row)
        showEditPlanViewController?(editPlanViewModel)
    }
    
    internal func getQuestionCellModel(at indexPath: IndexPath) -> QuestionCellModel {
        return questionCellModels[indexPath.row]
    }
    
    internal var numberOfCells: Int {
        return questionCellModels.count
    }
    
    /****************************
     *                          *
     *     DATA OPERATIONS      *
     *                          *
     ****************************/
    fileprivate func deletePlan() {
        managedObjectContext.delete(plan)
        showNotificationView?("Deleted")
    }
    
    @objc func managedObjectContextDidSave(notification: NSNotification) {
        guard let updatedPlan = managedObjectContext.object(with: plan.objectID) as? Plan else {return}
        plan = updatedPlan
    }
}

