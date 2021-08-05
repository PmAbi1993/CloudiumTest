//
//  HomeVCViewModel.swift
//  CloudiumTest
//
//  Created by admin on 04/08/21.
//

import Foundation

class HomeVCViewModel {
    
    func clearAllItemsInDb(completion: () -> ()) {
        SavedSeats.removeAllInstances()
        Seat.removeAllInstances()
        completion()
    }
    
    
    func availableSeats() -> Int {
        var allBookedSeats: Int = 0
        SavedSeats.allCases().forEach { (seatData) in
            if let seats = seatData.seats?.allObjects as? [Seat] {
                seats.forEach({ _ in
                    allBookedSeats += 1
                })
            }
        }
        var totalSeatsAvailable: Int = 0
        SeatType.allCases.forEach({
            totalSeatsAvailable += $0.seatsInSection
        })
        let availableSeat: Int = totalSeatsAvailable - allBookedSeats
        return availableSeat
    }
    
    func checkIfSeatsAvailable(count: Int) -> Bool {
        let availableSeat: Int = availableSeats()
        return availableSeat >= count
    }
}
