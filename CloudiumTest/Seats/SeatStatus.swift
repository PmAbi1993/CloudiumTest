//
//  SeatStatus.swift
//  CloudiumTest
//
//  Created by admin on 04/08/21.
//

import UIKit

enum SeatStatus {
    case booked
    case selected
    case unselected
    case hidden
    case placeholder
    
    var color: UIColor {
        switch self {
        case .booked:
            return .systemGray
        case .selected:
            return .green
        case .unselected:
            return UIColor("#282A37")//UIColor("#8B8C90")//.blue
        case .hidden:
            return .clear
        case .placeholder:
            return UIColor("#376BFE")//.blue
        }
    }
    var isHidden: Bool {
        switch self {
        case .hidden:
            return true
        default:
            return false
        }
    }
}
