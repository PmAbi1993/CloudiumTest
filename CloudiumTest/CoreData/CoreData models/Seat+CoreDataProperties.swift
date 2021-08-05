//
//  Seat+CoreDataProperties.swift
//  CloudiumTest
//
//  Created by admin on 05/08/21.
//
//

import Foundation
import CoreData


extension Seat {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Seat> {
        return NSFetchRequest<Seat>(entityName: "Seat")
    }

    @NSManaged public var seatId: String?
    @NSManaged public var session: SavedSeats?

}

extension Seat : Identifiable {

}
