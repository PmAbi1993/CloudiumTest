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
        
        let allSeats = SavedSeats.allCases()
        print(allSeats.count)
        bookedSeats = Set<String>(allSeats.compactMap({ $0.seatIt }))
    }
    
    func handleSeatSelection(indexPath: IndexPath,
                             completionHandler: (Bool) -> ()) {
        guard let section = SeatType(rawValue: indexPath.section) else {
            return
        }
        let seatID: String = section.seatID(indexPath)
        // The first if case will disable touches for the seat prefix cells and invisible cells
        if indexPath.row%(section.rowsInSet) == 0
            || indexPath.row%section.rowToHide == 0
            || bookedSeats.contains(seatID)  {
            completionHandler(false)
        } else {
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
    
    func saveSeatsInSelection() {
        SavedSeats.saveSeats(with: selectedSeats)
    }
    func getSeatStatus(at indexPath: IndexPath) -> SeatStatus {
        guard let section = SeatType(rawValue: indexPath.section) else {
            fatalError()
        }

        if indexPath.row%(section.rowsInSet) == 0 {
            return .placeholder
        } else if indexPath.row%section.rowToHide == 0 {
            return .hidden
        } else if bookedSeats.contains(section.seatID(indexPath)) {
            return .booked
        } else if selectedSeats.contains(section.seatID(indexPath)) {
            return .selected
        } else {
            return .unselected
        }
    }
}
