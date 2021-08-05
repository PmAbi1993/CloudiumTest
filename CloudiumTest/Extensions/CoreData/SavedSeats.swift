//
//  SavedSeats.swift
//  CloudiumTest
//
//  Created by admin on 04/08/21.
//

import CoreData

extension SavedSeats {
    static func saveSeats(with ids: Set<String>,
                          name: String,
                          ticketPrice: Double) {
        let session: SavedSeats = SavedSeats(context: context)
        session.sessionName = name
        session.sessionTicketPrice = ticketPrice
        ids.forEach {
            let seat: Seat = Seat(context: context)
            seat.seatId = $0
            session.addToSeats(seat)
        }
        try? context.save()

    }
}
