
//
//  IncomingTransactionProcessorTests.swift
//  SwiftabonCoreDataTests
//
//  Created by Uladzislau Kleshchanka on 8/5/19.
//  Copyright © 2019 vladislavitsi. All rights reserved.
//

import XCTest

@testable import SwiftabonCoreData

class IncomingTransactionProcessorTests: XCTestCase {

    class MockTrackableObject: TransactionHistoryTrackable {
        var calledAction: TransactionActionType?

        func insert() {
            calledAction = .insert
        }

        func delete() {
            calledAction = .delete
        }
    }

    func testProcessInsertAction() {
        let mockTrackableObject = MockTrackableObject()
        let transaction: Transaction<TransactionHistoryTrackable> = Transaction(action: .insert, object: mockTrackableObject, dateStamp: Date())

        let transactionProcessorExpectation = expectation(description: "TransactionProcessorExpectation")
    
        ServiceProvider.transactionProcessor.process(transaction: transaction, completion: {
            transactionProcessorExpectation.fulfill()
        })

        wait(for: [transactionProcessorExpectation], timeout: 3)

        XCTAssert(mockTrackableObject.calledAction == .insert, "Should be not nil and .insert.")
    }

    func testProcessDeleteAction() {
        let mockTrackableObject = MockTrackableObject()
        let transaction: Transaction<TransactionHistoryTrackable> = Transaction(action: .delete, object: mockTrackableObject, dateStamp: Date())

        let transactionProcessorExpectation = expectation(description: "TransactionProcessorExpectation")

        ServiceProvider.transactionProcessor.process(transaction: transaction, completion: {
            transactionProcessorExpectation.fulfill()
        })

        wait(for: [transactionProcessorExpectation], timeout: 3)

        XCTAssert(mockTrackableObject.calledAction == .delete, "Should be not nil and .insert.")
    }

}
