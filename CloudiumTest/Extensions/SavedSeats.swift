//
//  SavedSeats.swift
//  CloudiumTest
//
//  Created by admin on 04/08/21.
//

import CoreData

extension SavedSeats {
    static func saveSeats(with ids: Set<String>) {
        
        ids.forEach {
            let seat: SavedSeats = SavedSeats(context: context)
            seat.seatIt = $0
            try? context.save()
        }
        
    }
}
