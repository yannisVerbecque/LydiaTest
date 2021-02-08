//
//  PersistentContainer.swift
//  LydiaTest
//
//  Created by Yannis VERBECQUE on 08/02/2021.
//

import Foundation
import CoreData

class PersistentContainer: NSPersistentContainer {
    
    static let shared = PersistentContainer(name: "LydiaTestModel")

    func saveContext(backgroundContext: NSManagedObjectContext? = nil) {
        let context = backgroundContext ?? viewContext
        guard context.hasChanges else { return }
        do {
            try context.save()
        } catch let error as NSError {
            print("Error: \(error), \(error.userInfo)")
        }
    }

}
