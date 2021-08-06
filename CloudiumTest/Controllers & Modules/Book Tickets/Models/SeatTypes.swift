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
        case .recliner: return 8
        case .prime:  return 32
        case .classicPlus: return 70
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
        case .recliner: return 8
        case .prime: return 8
        case .classicPlus: return 10
        }
    }
    var rowToHide: Int {
        switch self {
        case .recliner: return 4
        case .prime: return 4
        case .classicPlus: return 5
        }
    }
    var seatLabel: [String] {
        switch self {
        case .recliner:
            return ["Q"]
        case .prime:
            return ["P", "N", "M", "L"]
        case .classicPlus:
            return ["K", "J", "H", "G", "F", "E", "D"]
        }
    }
    func getSeatName(_ indexPath: IndexPath) -> String {
        guard let seat: SeatType = SeatType(rawValue: indexPath.section) else { fatalError() }
        return seat.seatLabel[indexPath.row / seat.rowsInSet]
    }
    func seatID(_ indexPath: IndexPath) -> String {
        let seatName: String = getSeatName(indexPath) + "\(indexPath.row)"
        return seatName
    }
}
