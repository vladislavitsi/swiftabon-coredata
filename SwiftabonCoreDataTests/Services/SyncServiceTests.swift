//
//  SyncServiceTests.swift
//  SwiftabonCoreDataTests
//
//  Created by Uladzislau Kleshchanka on 7/19/19.
//  Copyright © 2019 vladislavitsi. All rights reserved.
//

import XCTest
import CoreData
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
        var stubTransactions = [Transaction<TransactionHistoryTrackable>]()

        override func push(transactions: [Transaction<TransactionHistoryTrackable>]) {
            resultData = transactions
            finishedPush()
        }

        override func fetchTransactions(from lastSyncDate: Date?, completion: @escaping ([Transaction<TransactionHistoryTrackable>]) -> ()) {
            completion(stubTransactions)
        }
    }

    class MockTransactionProcessor: IncomingTransactionProcessor {
        var resultData = [Transaction<TransactionHistoryTrackable>]()

        override func process(transaction: Transaction<TransactionHistoryTrackable>, completion: @escaping () -> ()) {
            resultData.append(transaction)
            completion()
        }
    }

    class StubConfigService: ConfiguratesService {
        var lastSyncDateActionListener: (() -> ())?
        override var lastSyncDate: Date? {
            set {
                _lastSyncDate = newValue
                lastSyncDateActionListener?()
            }
            get { return _lastSyncDate }
        }
        var _lastSyncDate: Date?

        init() {
            class StubUserDefaults: UserDefaults {}
            super.init(StubUserDefaults())
        }
    }

    class MockCoreDataService: CoreDataService {
        var saveContextCalledHandler: (() -> ())?
        override func saveContext() {
            saveContextCalledHandler?()
        }

        init() {
            class StubPersistanceContainer: NSPersistentContainer {

            }
            super.init(coreDataHelper: CoreDataHelper(persistenceContainer: StubPersistanceContainer(name: "Stub")))
        }
    }

    func testUpload() {
        let stubData: [Transaction<TransactionHistoryTrackable>] = [Transaction(action: .insert, object: User(username: "name"), dateStamp: Date())]
        let stubTransactionHistory = StubTransactionHistory()
        stubTransactionHistory.stubData = stubData
        let mockNetworkService = MockNetworkService()
        let syncService = SyncService(stubTransactionHistory, mockNetworkService, ServiceProvider.transactionProcessor, ServiceProvider.config, ServiceProvider.coreData)

        let expectations = expectation(description: "A")
        mockNetworkService.finishedPush = {
            expectations.fulfill()
        }

        syncService.upload()

        wait(for: [expectations], timeout: 3)

        guard let resultDataTransaction = mockNetworkService.resultData.first else {
            XCTFail("Nil Data.")
            return
        }

        let excpectedTransaction = stubData.first!
        XCTAssert(resultDataTransaction.isEqual(to: excpectedTransaction, as: User.self), "Transactions should be equal.")
    }

    func testDownload() {
        let stubData: [Transaction<TransactionHistoryTrackable>] = [Transaction(action: .insert, object: User(username: "name"), dateStamp: Date())]

        let mockNetworkService = MockNetworkService()
        mockNetworkService.stubTransactions = stubData

        let stubConfigService = StubConfigService()
        let lastSyncDateActionExpectation = expectation(description: "lastSyncDateActionExpectation")
        stubConfigService.lastSyncDateActionListener = {
            lastSyncDateActionExpectation.fulfill()
        }

        let mockTransactionProcessor = MockTransactionProcessor()
        let mockCoreDataService = MockCoreDataService()
        let saveContextCalledExpectation = expectation(description: "saveContextCalledExpectation")
        mockCoreDataService.saveContextCalledHandler = {
            saveContextCalledExpectation.fulfill()
        }

        let syncService = SyncService(ServiceProvider.transactionHistory, mockNetworkService, mockTransactionProcessor, stubConfigService, mockCoreDataService)

        syncService.download()

        wait(for: [lastSyncDateActionExpectation, saveContextCalledExpectation], timeout: 3)

        XCTAssert(mockTransactionProcessor.resultData.first!.isEqual(to: stubData.first!, as: User.self), "Transaction should be equal.")
    }

    func testSync() {
        let mockSyncService = MockSyncService(ServiceProvider.transactionHistory, ServiceProvider.networker, ServiceProvider.transactionProcessor, ServiceProvider.config, ServiceProvider.coreData)
        let downloadExpectation = expectation(description: "downloadExpectation")
        mockSyncService._downloadHandler = {
            downloadExpectation.fulfill()
        }
        let uploadExpectation = expectation(description: "uploadExpectation")
        mockSyncService._uploadCalledHandler = {
            uploadExpectation.fulfill()
        }
        mockSyncService.sync()
        wait(for: [downloadExpectation, uploadExpectation], timeout: 3)
    }

    class MockSyncService: SyncService {
        var _uploadCalledHandler: (() -> ())?
        var _downloadHandler: (() -> ())?

        override func upload() {
            _uploadCalledHandler?()
        }

        override func download() {
            _downloadHandler?()
        }
    }
}
