//
//  ConfiguratesServiceTests.swift
//  SwiftabonCoreDataTests
//
//  Created by Uladzislau Kleshchanka on 7/17/19.
//  Copyright © 2019 vladislavitsi. All rights reserved.
//

import XCTest

@testable import SwiftabonCoreData

class ConfiguratesServiceTests: XCTestCase {

    class MockUserDefaults: UserDefaults {

        var closure: ((Any?, String) -> ())?
        var lastSyncDate: Date?

        override func object(forKey defaultName: String) -> Any? {
            return lastSyncDate
        }

        override func set(_ value: Any?, forKey defaultName: String) {
            closure?(value, defaultName)
        }
    }

    func testLastSyncDateSetValid() {
        let dateToSet = Date()
        let validKey = "lastSyncDate"

        var result: Any?
        let mockUserDefaults = MockUserDefaults()
        let configuratesService = ConfiguratesService(mockUserDefaults)

        mockUserDefaults.closure = { value, key in
            result = value
            XCTAssert(key == validKey, "Key is not valid.")
        }
        configuratesService.lastSyncDate = dateToSet
        guard let resultValue = result as? Date else {
            XCTFail("Nil occured")
            return
        }
        XCTAssert(resultValue == dateToSet, "Last sync date is not valid.")
    }

    func testLastSyncDateSetNil() {
        let dateToSet: Date? = nil
        let validKey = "lastSyncDate"

        var result: Any?
        let mockUserDefaults = MockUserDefaults()
        let configuratesService = ConfiguratesService(mockUserDefaults)

        mockUserDefaults.closure = { value, key in
            result = value
            XCTAssert(key == validKey, "Key is not valid.")
        }
        configuratesService.lastSyncDate = dateToSet
        XCTAssertNil(result, "Saved result must be nil")
    }

    func testLastSyncDateGetValid() {
        let dateToSet = Date()

        let mockUserDefaults = MockUserDefaults()
        mockUserDefaults.lastSyncDate = dateToSet
        let configuratesService = ConfiguratesService(mockUserDefaults)

        let resultLastSyncDate = configuratesService.lastSyncDate
        XCTAssert(resultLastSyncDate == dateToSet, "Last sync date is not valid.")
    }

    func testLastSyncDateGetNil() {
        let dateToSet: Date? = nil

        let mockUserDefaults = MockUserDefaults()
        mockUserDefaults.lastSyncDate = dateToSet
        let configuratesService = ConfiguratesService(mockUserDefaults)

        let resultLastSyncDate = configuratesService.lastSyncDate
        XCTAssertNil(resultLastSyncDate, "Last sync date has to be nil.")
    }
}
