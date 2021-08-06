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
            return .appGrey
        case .hidden:
            return .clear
        case .placeholder:
            return .accentColor
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
