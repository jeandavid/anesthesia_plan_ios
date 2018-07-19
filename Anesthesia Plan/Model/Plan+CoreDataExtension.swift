//
//  Plan+CoreDataExtension.swift
//  Anesthesia Plan
//
//  Created by Jean-David Morgenstern-Peirolo on 6/28/18.
//  Copyright © 2018 Jean-David Morgenstern-Peirolo. All rights reserved.
//

import Foundation
import CoreData

extension Plan {
    var numberOfQuestions: Int {
        return questions?.array.count ?? 0
    }
    
    convenience init(createdAt: Date, managedObjectContext: NSManagedObjectContext) {
        self.init(context: managedObjectContext)
        
        self.createdAt = createdAt
        
        prepareQuestion1(managedObjectContext: managedObjectContext)
        prepareQuestion2(managedObjectContext: managedObjectContext)
        prepareQuestion3(managedObjectContext: managedObjectContext)
        prepareQuestion4(managedObjectContext: managedObjectContext)
        prepareQuestion5(managedObjectContext: managedObjectContext)
        prepareQuestion6(managedObjectContext: managedObjectContext)
        prepareQuestion7(managedObjectContext: managedObjectContext)
        prepareQuestion8(managedObjectContext: managedObjectContext)
        prepareQuestion9(managedObjectContext: managedObjectContext)
        prepareQuestion10(managedObjectContext: managedObjectContext)
        prepareQuestion11(managedObjectContext: managedObjectContext)
        prepareQuestion12(managedObjectContext: managedObjectContext)
        prepareQuestion13(managedObjectContext: managedObjectContext)
    }
    
    func prepareQuestion1(managedObjectContext: NSManagedObjectContext) {
        let question = MultiChoice(context: managedObjectContext)
        question.problem = "איזה סוג הרדמה?"
        question.layout = MultiChoice.Layout.large.rawValue
        question.mode = MultiChoice.Mode.multiple.rawValue
        
        let choice_1 = Choice(context: managedObjectContext)
        choice_1.body = "כללית"
        choice_1.selected = false
        question.addToChoices(choice_1)
        
        let choice_2 = Choice(context: managedObjectContext)
        choice_2.body = "איזורית"
        choice_2.selected = false
        question.addToChoices(choice_2)
        
        let choice_3 = Choice(context: managedObjectContext)
        choice_3.body = "בלוק"
        choice_3.selected = false
        question.addToChoices(choice_3)
        
        let choice_4 = Choice(context: managedObjectContext)
        choice_4.body = "סדציה"
        choice_4.selected = false
        question.addToChoices(choice_4)
        
        addToQuestions(question)
    }
    
    func prepareQuestion2(managedObjectContext: NSManagedObjectContext) {
        let question = MultiChoice(context: managedObjectContext)
        question.problem = "איזה ניטורים בנוסף ל-ASA standard?"
        question.layout = MultiChoice.Layout.small.rawValue
        question.mode = MultiChoice.Mode.multiple.rawValue
        
        let choice_1 = Choice(context: managedObjectContext)
        choice_1.body = "5 lead ECG"
        choice_1.selected = false
        question.addToChoices(choice_1)
        
        let choice_2 = Choice(context: managedObjectContext)
        choice_2.body = "Arterial line"
        choice_2.selected = false
        question.addToChoices(choice_2)
        
        let choice_3 = Choice(context: managedObjectContext)
        choice_3.body = "קטטר שתן"
        choice_3.selected = false
        question.addToChoices(choice_3)
        
        let choice_4 = Choice(context: managedObjectContext)
        choice_4.body = "זונדה"
        choice_4.selected = false
        question.addToChoices(choice_4)
        
        let choice_5 = Choice(context: managedObjectContext)
        choice_5.body = "CVP"
        choice_5.selected = false
        question.addToChoices(choice_5)
        
        let choice_6 = Choice(context: managedObjectContext)
        choice_6.body = "BIS"
        choice_6.selected = false
        question.addToChoices(choice_6)
        
        let choice_7 = Choice(context: managedObjectContext)
        choice_7.body = "Vigileo"
        choice_7.selected = false
        question.addToChoices(choice_7)
        
        let choice_8 = Choice(context: managedObjectContext)
        choice_8.body = "NIRS"
        choice_8.selected = false
        question.addToChoices(choice_8)
        
        let choice_9 = Choice(context: managedObjectContext)
        choice_9.body = "Swann-Ganz"
        choice_9.selected = false
        question.addToChoices(choice_9)
        
        let choice_10 = Choice(context: managedObjectContext)
        choice_10.body = "Nerve stimulator"
        choice_10.selected = false
        question.addToChoices(choice_10)
        
        let choice_11 = Choice(context: managedObjectContext)
        choice_11.body = "TEE"
        choice_11.selected = false
        question.addToChoices(choice_11)
        
        addToQuestions(question)
    }
    
    func prepareQuestion3(managedObjectContext: NSManagedObjectContext) {
        let question = MultiChoice(context: managedObjectContext)
        question.problem = "האם צריך מנות דם?"
        question.layout = MultiChoice.Layout.large.rawValue
        question.mode = MultiChoice.Mode.multiple.rawValue
        
        let choice_1 = Choice(context: managedObjectContext)
        choice_1.body = "לא"
        choice_1.selected = false
        question.addToChoices(choice_1)
        
        let choice_2 = Choice(context: managedObjectContext)
        choice_2.body = "רק סוג וסקר"
        choice_2.selected = false
        question.addToChoices(choice_2)
        
        let choice_3 = Choice(context: managedObjectContext)
        choice_3.body = "מנות מוכנות בבנק הדם"
        choice_3.selected = false
        question.addToChoices(choice_3)
        
        let choice_4 = Choice(context: managedObjectContext)
        choice_4.body = "מנות מוכנות בחדר ניתוח"
        choice_4.selected = false
        question.addToChoices(choice_4)
        
        let choice_5 = Choice(context: managedObjectContext)
        choice_5.body = "Cell Saver"
        choice_5.selected = false
        question.addToChoices(choice_5)
        
        addToQuestions(question)
    }
    
    func prepareQuestion4(managedObjectContext: NSManagedObjectContext) {
        let question = MultiChoice(context: managedObjectContext)
        question.problem = "איזה נוזלים?"
        question.layout = MultiChoice.Layout.large.rawValue
        question.mode = MultiChoice.Mode.multiple.rawValue
        
        let choice_1 = Choice(context: managedObjectContext)
        choice_1.body = "Ringer Lactate"
        choice_1.selected = false
        question.addToChoices(choice_1)
        
        let choice_2 = Choice(context: managedObjectContext)
        choice_2.body = "Plasmalyte"
        choice_2.selected = false
        question.addToChoices(choice_2)
        
        let choice_3 = Choice(context: managedObjectContext)
        choice_3.body = "0.9% NaCl"
        choice_3.selected = false
        question.addToChoices(choice_3)
        
        let choice_4 = Choice(context: managedObjectContext)
        choice_4.body = "אחר"
        choice_4.selected = false
        question.addToChoices(choice_4)
        
        addToQuestions(question)
    }
    
    func prepareQuestion5(managedObjectContext: NSManagedObjectContext) {
        let question = MultiChoice(context: managedObjectContext)
        question.problem = "חימום נוזלים?"
        question.layout = MultiChoice.Layout.large.rawValue
        question.mode = MultiChoice.Mode.multiple.rawValue
        
        let choice_1 = Choice(context: managedObjectContext)
        choice_1.body = "ללא"
        choice_1.selected = false
        question.addToChoices(choice_1)
        
        let choice_2 = Choice(context: managedObjectContext)
        choice_2.body = "חימום רגיל"
        choice_2.selected = false
        question.addToChoices(choice_2)
        
        let choice_3 = Choice(context: managedObjectContext)
        choice_3.body = "Hotline"
        choice_3.selected = false
        question.addToChoices(choice_3)
        
        let choice_4 = Choice(context: managedObjectContext)
        choice_4.body = "Level 1"
        choice_4.selected = false
        question.addToChoices(choice_4)
        
        addToQuestions(question)
    }
    
    func prepareQuestion6(managedObjectContext: NSManagedObjectContext) {
        let question = MultiChoice(context: managedObjectContext)
        question.problem = "האם יש אינדיקציה ל-RSI?"
        question.layout = MultiChoice.Layout.large.rawValue
        question.mode = MultiChoice.Mode.unique.rawValue
        
        let choice_1 = Choice(context: managedObjectContext)
        choice_1.body = "לא"
        choice_1.selected = false
        question.addToChoices(choice_1)
        
        let choice_2 = Choice(context: managedObjectContext)
        choice_2.body = "כן"
        choice_2.selected = false
        question.addToChoices(choice_2)
        
        addToQuestions(question)
    }
    
    func prepareQuestion7(managedObjectContext: NSManagedObjectContext) {
        let question = MultiChoice(context: managedObjectContext)
        question.problem = "האם יש חשד ל-difficult airway?"
        question.layout = MultiChoice.Layout.large.rawValue
        question.mode = MultiChoice.Mode.multiple.rawValue
        
        let choice_1 = Choice(context: managedObjectContext)
        choice_1.body = "לא"
        choice_1.selected = false
        question.addToChoices(choice_1)
        
        let choice_2 = Choice(context: managedObjectContext)
        choice_2.body = "כן, נשתמש ב-video laryngoscope"
        choice_2.selected = false
        question.addToChoices(choice_2)
        
        let choice_3 = Choice(context: managedObjectContext)
        choice_3.body = "כן, נשתמש ב-fiberoptic"
        choice_3.selected = false
        question.addToChoices(choice_3)
        
        let choice_4 = Choice(context: managedObjectContext)
        choice_4.body = "כן, נשתמש בשיטה אחרת"
        choice_4.selected = false
        question.addToChoices(choice_4)
        
        addToQuestions(question)
    }
    
    func prepareQuestion8(managedObjectContext: NSManagedObjectContext) {
        let question = MultiChoice(context: managedObjectContext)
        question.problem = "ניהול נתיב אוויר?"
        question.layout = MultiChoice.Layout.large.rawValue
        question.mode = MultiChoice.Mode.multiple.rawValue
        
        let choice_1 = Choice(context: managedObjectContext)
        choice_1.body = "טובוס רגיל"
        choice_1.selected = false
        question.addToChoices(choice_1)
        
        let choice_2 = Choice(context: managedObjectContext)
        choice_2.body = "LMA"
        choice_2.selected = false
        question.addToChoices(choice_2)
        
        let choice_3 = Choice(context: managedObjectContext)
        choice_3.body = "מסכה"
        choice_3.selected = false
        question.addToChoices(choice_3)
        
        let choice_4 = Choice(context: managedObjectContext)
        choice_4.body = "טובוס נזאלי"
        choice_4.selected = false
        question.addToChoices(choice_4)
        
        let choice_5 = Choice(context: managedObjectContext)
        choice_5.body = "טובוס מיוחד אחר"
        choice_5.selected = false
        question.addToChoices(choice_5)
        
        addToQuestions(question)
    }
    
    func prepareQuestion9(managedObjectContext: NSManagedObjectContext) {
        let question = MultiChoice(context: managedObjectContext)
        question.problem = "מה ה-Maintenance של ההרדמה?"
        question.layout = MultiChoice.Layout.large.rawValue
        question.mode = MultiChoice.Mode.multiple.rawValue
        
        let choice_1 = Choice(context: managedObjectContext)
        choice_1.body = "גזים"
        choice_1.selected = false
        question.addToChoices(choice_1)
        
        let choice_2 = Choice(context: managedObjectContext)
        choice_2.body = "TIVA"
        choice_2.selected = false
        question.addToChoices(choice_2)
        
        addToQuestions(question)
    }
    
    func prepareQuestion10(managedObjectContext: NSManagedObjectContext) {
        let question = MultiChoice(context: managedObjectContext)
        question.problem = "האם החולה לאקסטובציה?"
        question.layout = MultiChoice.Layout.large.rawValue
        question.mode = MultiChoice.Mode.multiple.rawValue
        
        let choice_1 = Choice(context: managedObjectContext)
        choice_1.body = "כן, awake"
        choice_1.selected = false
        question.addToChoices(choice_1)
        
        let choice_2 = Choice(context: managedObjectContext)
        choice_2.body = "כן, deep"
        choice_2.selected = false
        question.addToChoices(choice_2)
        
        let choice_3 = Choice(context: managedObjectContext)
        choice_3.body = "לא"
        choice_3.selected = false
        question.addToChoices(choice_3)
        
        addToQuestions(question)
    }
    
    func prepareQuestion11(managedObjectContext: NSManagedObjectContext) {
        let question = MultiChoice(context: managedObjectContext)
        question.problem = "טיפול בכאב post-op?"
        question.layout = MultiChoice.Layout.large.rawValue
        question.mode = MultiChoice.Mode.multiple.rawValue
        
        let choice_1 = Choice(context: managedObjectContext)
        choice_1.body = "IV PRN"
        choice_1.selected = false
        question.addToChoices(choice_1)
        
        let choice_2 = Choice(context: managedObjectContext)
        choice_2.body = "IV PCA"
        choice_2.selected = false
        question.addToChoices(choice_2)
        
        let choice_3 = Choice(context: managedObjectContext)
        choice_3.body = "PECA"
        choice_3.selected = false
        question.addToChoices(choice_3)
        
        let choice_4 = Choice(context: managedObjectContext)
        choice_4.body = "peripheral block"
        choice_4.selected = false
        question.addToChoices(choice_4)
        
        addToQuestions(question)
    }
    
    func prepareQuestion12(managedObjectContext: NSManagedObjectContext) {
        let question = MultiChoice(context: managedObjectContext)
        question.problem = "לאן החולה הולך בסוף?"
        question.layout = MultiChoice.Layout.large.rawValue
        question.mode = MultiChoice.Mode.multiple.rawValue
        
        let choice_1 = Choice(context: managedObjectContext)
        choice_1.body = "התעוררות והביתה או למחלקה"
        choice_1.selected = false
        question.addToChoices(choice_1)
        
        let choice_2 = Choice(context: managedObjectContext)
        choice_2.body = "כירורגית מוגברת"
        choice_2.selected = false
        question.addToChoices(choice_2)
        
        let choice_3 = Choice(context: managedObjectContext)
        choice_3.body = "טיפול נמרץ כללי"
        choice_3.selected = false
        question.addToChoices(choice_3)
        
        let choice_4 = Choice(context: managedObjectContext)
        choice_4.body = "טיפול נמרץ אחר"
        choice_4.selected = false
        question.addToChoices(choice_4)
        
        addToQuestions(question)
    }
    
    func prepareQuestion13(managedObjectContext: NSManagedObjectContext) {
        let question = FreeText(context: managedObjectContext)
        question.problem = "משהו אחר חשוב?"
        
        addToQuestions(question)
    }
}


