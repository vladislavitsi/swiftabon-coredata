//
//  AddRecordViewModelingTests.swift
//  SwiftabonCoreDataTests
//
//  Created by Uladzislau Kleshchanka on 8/7/19.
//  Copyright © 2019 vladislavitsi. All rights reserved.
//

import XCTest

@testable import SwiftabonCoreData

class AddRecordViewModelingTests: XCTestCase {

    class MockAddRecordPersistance: AddRecordPersistance {
        var _addedRecord: Record?

        func add(record: Record) {
            _addedRecord = record
        }

    }

    func testAddRecord() {
        let mockAddRecordPersistance = MockAddRecordPersistance()
        let addRecordViewModel = AddRecordViewModel(persistence: mockAddRecordPersistance)

        let testRecord = Record(user: User(username: "Test"), text: "Test", date: Date())
        addRecordViewModel.add(record: testRecord)

        guard let resultRecord = mockAddRecordPersistance._addedRecord else {
            XCTFail("Added record should be nil.")
            return
        }

        XCTAssertEqual(testRecord, resultRecord, "Result and expected records should be equal.")
    }

}
