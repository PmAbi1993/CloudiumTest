//
//  SavedSeats+CoreDataProperties.swift
//  CloudiumTest
//
//  Created by admin on 04/08/21.
//
//

import Foundation
import CoreData


extension SavedSeats {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<SavedSeats> {
        return NSFetchRequest<SavedSeats>(entityName: "SavedSeats")
    }

    @NSManaged public var seatIt: String?

}

extension SavedSeats : Identifiable {
}

