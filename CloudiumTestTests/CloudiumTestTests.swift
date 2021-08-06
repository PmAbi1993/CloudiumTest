//
//  CloudiumTestTests.swift
//  CloudiumTestTests
//
//  Created by admin on 06/08/21.
//

@testable import CloudiumTest
import XCTest

class CloudiumTestTests: XCTestCase {

    var homeViewModel: HomeVCViewModel!
    override func setUp() {
        homeViewModel = HomeVCViewModel()
    }
    override func tearDown() {
        homeViewModel = nil
    }
    func test_seats_data() {
        let availableSeats = homeViewModel.plottedSeatsData()
        XCTAssert(availableSeats.hiddenSeats == 12)
        XCTAssert(availableSeats.totalSeatsAvailable == 110)
        XCTAssert(availableSeats.placeHolders == 12)
        // Tests to verify Seat data
        let userNameError = homeViewModel.verifySeatData(name: "", noOfSeats: 2)
        XCTAssert(userNameError == .failure(.imporoperName))
        let seatsError = homeViewModel.verifySeatData(name: "User", noOfSeats: -1)
        XCTAssert(seatsError == .failure(.improperNumberOfseats))
        let seatsErrorTwo = homeViewModel.verifySeatData(name: "User", noOfSeats: 200)
        XCTAssert(seatsErrorTwo == .failure(.seatsNotAvailable))
    }
}
