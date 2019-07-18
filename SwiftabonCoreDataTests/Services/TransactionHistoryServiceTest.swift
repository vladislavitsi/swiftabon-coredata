//
//  TransactionHistoryServiceTest.swift
//  SwiftabonCoreDataTests
//
//  Created by Uladzislau Kleshchanka on 7/18/19.
//  Copyright © 2019 vladislavitsi. All rights reserved.
//

import XCTest
import CoreData

@testable import SwiftabonCoreData

class TransactionHistoryServiceTest: XCTestCase {

    var transactionHistoryService: TransactionHistoryService!

    override func setUp() {
        transactionHistoryService = TransactionHistoryService()
    }

    func testAddTransactionAndFetchForEnabledService() {

        let expectedUser = User(username: "name")
        let expectedTransaction: Transaction<TransactionHistoryTrackable> = Transaction(action: .insert, object: expectedUser, dateStamp: Date())

        transactionHistoryService.isEnabled = true
        transactionHistoryService.add(transaction: expectedTransaction)

        let resultTransactions = transactionHistoryService.fetchHistory()
        XCTAssert(resultTransactions.count == 1, "Should be 1.")

        guard let userTransaction = resultTransactions.first, let realUser = userTransaction.object as? User else {
            XCTFail("Expected user")
            return
        }

        XCTAssert(userTransaction.action == expectedTransaction.action, "Expected equal action.")
        XCTAssert(realUser == expectedUser, "Expected equal user.")
    }

    func testAddTransactionAndFetchForDisabledService() {

        let expectedUser = User(username: "name")
        let expectedTransaction: Transaction<TransactionHistoryTrackable> = Transaction(action: .insert, object: expectedUser, dateStamp: Date())

        transactionHistoryService.isEnabled = false
        transactionHistoryService.add(transaction: expectedTransaction)

        let resultTransactions = transactionHistoryService.fetchHistory()
        XCTAssertTrue(resultTransactions.isEmpty, "Should be Empty.")
    }

    func testIsEmpty() {
        transactionHistoryService.isEnabled = false
        XCTAssertTrue(transactionHistoryService.isEmpty, "Should be Empty.")
    }
}
