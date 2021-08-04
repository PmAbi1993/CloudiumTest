//
//  BookSeatViewModel.swift
//  CloudiumTest
//
//  Created by admin on 04/08/21.
//

import Foundation

class BookSeatViewModel {
    var selectedSeats: Set<String> = []
    var numberOfSeatsToSelect: Int = 0
    var bookedSeats: Set<String> = []
    
    init(numberOfSeatsToSelect: Int) {
        self.numberOfSeatsToSelect = numberOfSeatsToSelect
    }
    
    
    
    func handleSeatSelection(indexPath: IndexPath,
                             completionHandler: (Bool) -> ()) {
        guard let section = SeatType(rawValue: indexPath.section) else {
            return
        }
        // The first if case will disable touches for the seat prefix cells and invisible cells
        if indexPath.row%(section.rowsInSet) == 0
            || indexPath.row%section.rowToHide == 0 {
            completionHandler(false)
        } else {
            let seatID: String = section.seatID(indexPath)
            if numberOfSeatsToSelect >= 0 || selectedSeats.contains(seatID) {
                if !selectedSeats.contains(seatID) {
                    selectedSeats.insert(seatID)
                    numberOfSeatsToSelect -= 1
                } else {
                    selectedSeats.remove(seatID)
                    numberOfSeatsToSelect += 1
                }
                completionHandler(true)
            }
        }
    }
}
