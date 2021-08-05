//
//  Sequence + safety.swift
//  CloudiumTest
//
//  Created by admin on 05/08/21.
//

import Foundation

extension Collection {
    subscript (safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
