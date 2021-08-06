//
//  BookedTicketsViewModel.swift
//  CloudiumTest
//
//  Created by admin on 05/08/21.
//

import Foundation

class BookedTicketsViewModel {
    var allSavedSeats: [SavedSeats] = []
    init() {
        allSavedSeats = SavedSeats.allCases()
    }
    func getSeatsAt(index: Int) -> [Seat] {
        guard let seatsBooked: [Seat] = allSavedSeats[index].seats?.allObjects as? [Seat] else { return [] }
        return seatsBooked
    }
}
