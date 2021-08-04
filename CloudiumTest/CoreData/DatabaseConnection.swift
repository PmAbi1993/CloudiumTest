//
//  Database.swift
//  CloudiumTest
//
//  Created by admin on 04/08/21.
//

import CoreData

class DatabaseConnection {
    static let `default`: DatabaseConnection = .init()
    
    private init() { }
    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
    
        let container = NSPersistentContainer(name: "CloudiumTest")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

    lazy var context: NSManagedObjectContext  = {
        persistentContainer.viewContext
    }()
    
    func prefetch() {
        let coordinator = persistentContainer
    }
    
}
