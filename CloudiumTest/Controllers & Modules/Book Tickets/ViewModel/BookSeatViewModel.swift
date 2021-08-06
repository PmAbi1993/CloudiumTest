//
//  BookSeatViewModel.swift
//  CloudiumTest
//
//  Created by admin on 04/08/21.
//

import Foundation

class BookSeatViewModel {
    var selectedSeats: Set<String> = []
    var bookedSeats: Set<String> = []
    var currentTicketPrice: Double = 0
    
    private var numberOfSeatsToSelect: Int = 0
    private var userName: String = ""
    init(numberOfSeatsToSelect: Int, userName: String) {
        self.numberOfSeatsToSelect = numberOfSeatsToSelect
        self.userName = userName
        getAllSavedSeats()
    }
    fileprivate func getAllSavedSeats() {
        var allSavedSeatId: [String] = []
        let seatsSession: [SavedSeats] = SavedSeats.allCases()
        seatsSession.forEach { (savedSeat) in
            if let seats = savedSeat.seats?.allObjects as? [Seat] {
                allSavedSeatId.append(contentsOf: seats.compactMap({ $0.seatId }))
            }
        }
        bookedSeats = Set<String>(allSavedSeatId)
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
    
    func saveSeatsInSelection(completion: () -> ()) {
        SavedSeats.saveSeats(with: selectedSeats,
                             name: userName,
                             ticketPrice: currentTicketPrice)
        completion()
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
