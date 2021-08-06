//
//  HomeItemsModel.swift
//  CloudiumTest
//
//  Created by admin on 04/08/21.
//

import Foundation

enum HomeItemsModel {

    static var allItems: [HomeItemsModel] {
        return [.bookTickets(name: "", tickets: -1),
                .showBookedTickets,
                .clearAllData]
    }
    case bookTickets(name: String, tickets: Int)
    case showBookedTickets
    case clearAllData
    var title: String {
        switch self {
        case .bookTickets: return "Book your Tickets"
        case .showBookedTickets: return "Show booked Tickets"
        case .clearAllData: return "Clear All Data"
        }
    }
}
