//
//  HomeVCViewModel.swift
//  CloudiumTest
//
//  Created by admin on 04/08/21.
//

import Foundation

class HomeVCViewModel {
    
    func clearAllItemsInDb(completion: () -> ()) {
        SavedSeats.removeAllInstances()
        Seat.removeAllInstances()
        completion()
    }
    
}
