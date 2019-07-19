//
//  SyncServiceTests.swift
//  SwiftabonCoreDataTests
//
//  Created by Uladzislau Kleshchanka on 7/19/19.
//  Copyright © 2019 vladislavitsi. All rights reserved.
//

import XCTest
@testable import SwiftabonCoreData

class SyncServiceTests: XCTestCase {

    class StubTransactionHistory: TransactionHistoryService {

        var stubData = [Transaction<TransactionHistoryTrackable>]()

        override func fetchHistory() -> [Transaction<TransactionHistoryTrackable>] {
            return stubData
        }
    }

    class MockNetworkService: NetworkService {
        var resultData = [Transaction<TransactionHistoryTrackable>]()
        var finishedPush = { }

        override func push(transactions: [Transaction<TransactionHistoryTrackable>]) {
            resultData = transactions
            finishedPush()
        }
    }

    class MockTransactionProcessor: IncomingTransactionProcessor {
        var resultData: Transaction<TransactionHistoryTrackable>?

        override func process(transaction: Transaction<TransactionHistoryTrackable>, completion: @escaping () -> ()) {
            resultData = transaction
            completion()
        }
    }

    func testUpload() {
        let stubData: [Transaction<TransactionHistoryTrackable>] = [Transaction(action: .insert, object: User(username: "name"), dateStamp: Date())]
        let stubTransactionHistory = StubTransactionHistory()
        stubTransactionHistory.stubData = stubData
        let mockNetworkService = MockNetworkService()
        let mockTransactionProcessor = MockTransactionProcessor()
        let syncService = SyncService(stubTransactionHistory, mockNetworkService, mockTransactionProcessor)

        let expectations = expectation(description: "A")
        mockNetworkService.finishedPush = {
            expectations.fulfill()
        }

        syncService.upload()

        wait(for: [expectations], timeout: 3)

        guard let resultData = mockNetworkService.resultData.first else {
            XCTFail("Nil Data.")
            return
        }

        XCTAssert(resultData.action == stubData.first!.action, "Action should be same.")

        guard let user = resultData.object as? User, let expectedUser = stubData.first!.object as? User else {
            XCTFail("Wrong object type.")
            return
        }

        XCTAssert(user == expectedUser, "Objects should be same.")
    }

}
