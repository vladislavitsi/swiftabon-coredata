//
//  TransactionTests.swift
//  SwiftabonCoreDataTests
//
//  Created by Uladzislau Kleshchanka on 8/5/19.
//  Copyright © 2019 vladislavitsi. All rights reserved.
//

import XCTest

@testable import SwiftabonCoreData

class TransactionTests: XCTestCase {

    func testTransactionEquatableSuccess() {
        let dateStamp = Date()
        let action: TransactionActionType = .insert
        let transactionObject = User(username: "name")
        let transaction1 = Transaction(action: action, object: transactionObject, dateStamp: dateStamp)
        let transaction2 = Transaction(action: action, object: transactionObject, dateStamp: dateStamp)

        let result = transaction1 == transaction2

        XCTAssert(result, "Transactions should be equal")
    }

    func testTransactionEquatableFailureByObject() {
        let dateStamp = Date()
        let action: TransactionActionType = .insert
        let transactionObject = User(username: "name")
        let differentObject = User(username: "klava")
        let transaction1 = Transaction(action: action, object: transactionObject, dateStamp: dateStamp)
        let transaction2 = Transaction(action: action, object: differentObject, dateStamp: dateStamp)

        let result = transaction1 == transaction2

        XCTAssertFalse(result, "Transactions should be equal")
    }

    func testTransactionEquatableFailureByAction() {
        let dateStamp = Date()
        let action: TransactionActionType = .insert
        let differentAction: TransactionActionType = .update
        let transactionObject = User(username: "name")
        let transaction1 = Transaction(action: action, object: transactionObject, dateStamp: dateStamp)
        let transaction2 = Transaction(action: differentAction, object: transactionObject, dateStamp: dateStamp)

        let result = transaction1 == transaction2

        XCTAssertFalse(result, "Transactions should be equal")
    }

    func testTransactionEquatableFailureByDate() {
        let dateStamp = Date()
        let differentDateStamp = Date(timeInterval: 10, since: dateStamp)
        let action: TransactionActionType = .insert
        let transactionObject = User(username: "name")
        let transaction1 = Transaction(action: action, object: transactionObject, dateStamp: dateStamp)
        let transaction2 = Transaction(action: action, object: transactionObject, dateStamp: differentDateStamp)

        let result = transaction1 == transaction2

        XCTAssertFalse(result, "Transactions should be equal")
    }

    func testTransactionIsEqualSuccess() {
        let dateStamp = Date()
        let action: TransactionActionType = .insert
        let transactionObject = User(username: "name")
        let transaction1 = Transaction(action: action, object: transactionObject, dateStamp: dateStamp)
        let transaction2 = Transaction(action: action, object: transactionObject, dateStamp: dateStamp)

        let result = transaction1.isEqual(to: transaction2, as: User.self)

        XCTAssert(result, "Transactions should be equal")
    }


}
