//
//  SeatTypes.swift
//  CompositionalLayout
//
//  Created by admin on 30/07/21.
//

import UIKit

enum SeatType: Int, CaseIterable {
    case recliner
    case prime
    case classicPlus
    
    var ticketPrice: Double {
        switch self {
        case .recliner: return 350
        case .prime:  return 190
        case .classicPlus: return 160
        }
    }
    var seatsInSection: Int {
        switch self {
        case .recliner: return 7
        case .prime:  return 40
        case .classicPlus: return 60
        }
    }
    var seatTitle: String {
        switch self {
        case .prime: return "Prime"
        case .recliner: return "Recliner"
        case .classicPlus: return "Classic Plus"
        }
    }
    var rowsInSet: Int {
        switch self {
        case .recliner:
            return 7
        case .prime:
            return 8
        case .classicPlus:
            return 10
        }
    }
}
