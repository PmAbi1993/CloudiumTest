//
//  SavedSeats.swift
//  CloudiumTest
//
//  Created by admin on 04/08/21.
//

import CoreData

extension SavedSeats {
    static func saveSeats(with ids: Set<String>, ticketPrice: Double) {
        let sessionId: UUID = .init()
        ids.forEach {
            let seat: SavedSeats = SavedSeats(context: context)
            seat.session = sessionId
            seat.seatId = $0
            seat.sessionTicketPrice = ticketPrice
            try? context.save()
        }
        
    }
}
