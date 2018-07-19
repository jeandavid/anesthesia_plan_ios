//
//  EditPlanViewModel.swift
//  Anesthesia Plan
//
//  Created by Jean-David Morgenstern-Peirolo on 6/28/18.
//  Copyright © 2018 Jean-David Morgenstern-Peirolo. All rights reserved.
//

import Foundation
import CoreData

class EditPlanViewModel {
    
    /*************************
     *                       *
     *      INIT/DEINIT      *
     *                       *
     *************************/
    init(managedObjectContext: NSManagedObjectContext, plan: Plan, isNew: Bool, startPage: Int = 0) {
        self.managedObjectContext = managedObjectContext
        self.plan = plan
        self.isNew = isNew
        self.currentPage = startPage
        self.startPlanPageViewController = PlanPageViewController(plan: plan, startPage: startPage)
    }
    
    /*************************
     *                       *
     *       PROPERTIES      *
     *                       *
     *************************/
    fileprivate let managedObjectContext: NSManagedObjectContext
    
    fileprivate let plan: Plan
    
    fileprivate let isNew: Bool
    
    /*************************
     *                       *
     *       INTERFACES      *
     *                       *
     *************************/
    internal var showNotificationView: ((_ title: String)->())?
    internal var showErrorAlert: ((_ message: String) -> ())?
    internal var showNextPage: (()->())?
    internal var showPrevPage: (()->())?
    internal var updatePageControl: ((_ currentPage: Int)->())?
    internal var closeView: (() -> ())?
    
    internal func stopButtonTapped() {
        cancelUpdates()
        closeView?()
    }
    
    internal func doneButtonTapped() {
        saveUpdates()
    }
    
    internal func didSwipeLeft() {
        if currentPage < plan.numberOfQuestions {
            currentPage += 1
            showNextPage?()
        }
    }
    
    internal func didSwipeRight() {
        if currentPage > 0 {
            currentPage -= 1
            showPrevPage?()
        }
    }
    
    internal var currentPage: Int {
        didSet {
            updatePageControl?(currentPage)
        }
    }
    
    internal var title: String {
        return isNew ? "תוכנית חדשה" : "עדכון תוכנית"
    }
    
    internal var numberOfQuestions: Int {
        return plan.questions?.count ?? 0
    }
    
    internal let startPlanPageViewController: PlanPageViewController
    
    /****************************
     *                          *
     *     DATA OPERATIONS      *
     *                          *
     ****************************/
    fileprivate func cancelUpdates() {
        if isNew {
            managedObjectContext.delete(plan)
        } else {
            managedObjectContext.refresh(plan, mergeChanges: false)
        }
    }
    
    fileprivate func saveUpdates() {
        do {
            try managedObjectContext.save()
            showNotificationView?("Saved")
        } catch let error as NSError {
            showErrorAlert?(error.localizedDescription)
        }
    }
}

