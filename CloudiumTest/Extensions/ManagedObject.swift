//
//  ManagedObject.swift
//  CloudiumTest
//
//  Created by admin on 04/08/21.
//

import CoreData

protocol ManagedObject { }

extension ManagedObject where Self: NSManagedObject {
    
    static var context: NSManagedObjectContext { DatabaseConnection.default.context }
//    static var coordinator
    static func allCases() -> [Self] {
        do {
            let fetchRequest: NSFetchRequest = Self.fetchRequest()
            guard let allCases: [Self] = try context.fetch(fetchRequest) as? [Self] else { return [] }
            return allCases
        } catch  {
            return []
        }
    }
    static func removeAllInstances() {
        
        let entityRequest : NSFetchRequest<NSFetchRequestResult> = fetchRequest()
        let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: entityRequest)
        do {
            let coordinator = DatabaseConnection.default.persistentContainer.persistentStoreCoordinator
            try coordinator.execute(batchDeleteRequest, with: context)
            try context.save()
        }catch{
            print(error)
        }
    }
}

extension NSManagedObject: ManagedObject { }
