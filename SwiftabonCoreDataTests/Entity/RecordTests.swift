//
//  RecordTests.swift
//  SwiftabonCoreDataTests
//
//  Created by Uladzislau Kleshchanka on 8/6/19.
//  Copyright © 2019 vladislavitsi. All rights reserved.
//

import XCTest

@testable import SwiftabonCoreData

class RecordTests: XCTestCase {

    func testEquitableSuccess1() {
        let recordId = UUID()
        let record1 = Record(id: recordId, user: User(username: "Stub"), text: "Stub", date: Date())
        let record2 = Record(id: recordId, user: User(username: "Stub"), text: "Stub", date: Date())

        XCTAssertEqual(record1, record2, "Records should be equal.")
    }

    func testEquitableSuccess2() {
        let recordId = UUID()
        let record1 = Record(id: recordId, user: User(username: "Stub1"), text: "Stub1", date: Date())
        let record2 = Record(id: recordId, user: User(username: "Stub2"), text: "Stub2", date: Date())

        XCTAssertEqual(record1, record2, "Records should be equal.")
    }

    func testEquitableFailure1() {
        let record1 = Record(id: UUID(), user: User(username: "Stub"), text: "Stub", date: Date())
        let record2 = Record(id: UUID(), user: User(username: "Stub"), text: "Stub", date: Date())

        XCTAssertNotEqual(record1, record2, "Records should be not equal.")
    }

    func testEquitableFailure2() {
        let record1 = Record(id: UUID(), user: User(username: "Stub1"), text: "Stub1", date: Date())
        let record2 = Record(id: UUID(), user: User(username: "Stub2"), text: "Stub2", date: Date())

        XCTAssertNotEqual(record1, record2, "Records should be not equal.")
    }

}
