//
//  CloudiumTestTests.swift
//  CloudiumTestTests
//
//  Created by admin on 06/08/21.
//

@testable import CloudiumTest
import XCTest

class CloudiumTestTests: XCTestCase {

    var model: HomeVCViewModel!
    override func setUp() {
        model = HomeVCViewModel()
    }
    override func tearDown() {
        model = nil
    }
    func testSeatsAvailability() {
        let availableSeats = model.plottedSeatsData()
        XCTAssert(availableSeats.hiddenSeats == 12)
        XCTAssert(availableSeats.totalSeatsAvailable == 110)
        XCTAssert(availableSeats.placeHolders == 12)
    }
}
