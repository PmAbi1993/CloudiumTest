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
        var hiddenSeats: Int = 0
        var placeHolders: Int = 0
        SeatType.allCases.forEach({
            totalSeatsAvailable += $0.seatsInSection
            print($0.seatsInSection / $0.rowsInSet)
            hiddenSeats += $0.seatsInSection / $0.rowsInSet
            placeHolders += $0.seatLabel.count
        })
        let availableSeat: Int = totalSeatsAvailable - (allBookedSeats + placeHolders + hiddenSeats)
        return availableSeat
    }
    
    func checkIfSeatsAvailable(count: Int) -> Bool {
        let availableSeat: Int = availableSeats()
        return availableSeat >= count
    }
}
