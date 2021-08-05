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
    var currentTicketPrice: Double = 0
    
    init(numberOfSeatsToSelect: Int) {
        self.numberOfSeatsToSelect = numberOfSeatsToSelect
        
        let allSeats = SavedSeats.allCases()
        bookedSeats = Set<String>(allSeats.compactMap({ $0.seatId }))
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
            print("Current Ticket Price: \(currentTicketPrice)")
            completionHandler(false)
        } else {
            if numberOfSeatsToSelect >= 0 || selectedSeats.contains(seatID) {
                if !selectedSeats.contains(seatID) {
                    selectedSeats.insert(seatID)
                    currentTicketPrice += section.ticketPrice
                    numberOfSeatsToSelect -= 1
                } else {
                    selectedSeats.remove(seatID)
                    currentTicketPrice -= section.ticketPrice
                    numberOfSeatsToSelect += 1
                }
                completionHandler(true)
            }
        }
        print("Current Ticket Price: \(currentTicketPrice)")
    }
    
    func saveSeatsInSelection() {
        SavedSeats.saveSeats(with: selectedSeats,
                             ticketPrice: currentTicketPrice)
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
