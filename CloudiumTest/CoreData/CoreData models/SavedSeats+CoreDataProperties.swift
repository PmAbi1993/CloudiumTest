//
//  SavedSeats+CoreDataProperties.swift
//  CloudiumTest
//
//  Created by admin on 05/08/21.
//
//

import Foundation
import CoreData


extension SavedSeats {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<SavedSeats> {
        return NSFetchRequest<SavedSeats>(entityName: "SavedSeats")
    }

    @NSManaged public var sessionName: String?
    @NSManaged public var sessionTicketPrice: Double
    @NSManaged public var seats: NSSet?

}

// MARK: Generated accessors for seats
extension SavedSeats {

    @objc(addSeatsObject:)
    @NSManaged public func addToSeats(_ value: Seat)

    @objc(removeSeatsObject:)
    @NSManaged public func removeFromSeats(_ value: Seat)

    @objc(addSeats:)
    @NSManaged public func addToSeats(_ values: NSSet)

    @objc(removeSeats:)
    @NSManaged public func removeFromSeats(_ values: NSSet)

}

extension SavedSeats : Identifiable {

}
