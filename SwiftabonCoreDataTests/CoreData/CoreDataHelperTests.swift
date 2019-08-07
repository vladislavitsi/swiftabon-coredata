//
//  CoreDataHelperTests.swift
//  SwiftabonCoreDataTests
//
//  Created by Uladzislau Kleshchanka on 8/6/19.
//  Copyright © 2019 vladislavitsi. All rights reserved.
//

import XCTest

import CoreData
@testable import SwiftabonCoreData

class CoreDataHelperTests: XCTestCase {

    class MockPersistentContainer: NSPersistentContainer {
        class StubManagedObjectModel: NSManagedObjectModel {
            override init() {
                super.init()
            }

            required init?(coder aDecoder: NSCoder) {
                fatalError("init(coder:) has not been implemented")
            }
        }

        class MockManagedObjectContext: NSManagedObjectContext {
            override var hasChanges: Bool {
                return _hasChanges
            }

            var _hasChanges = false
            var calledSave: (() -> ())?
            var hasBeenSaved = false

            override func save() throws {
                calledSave?()
                hasBeenSaved = true
            }
        }

        override var viewContext: NSManagedObjectContext {
            return _viewContext
        }
        let _viewContext: MockManagedObjectContext

        init() {
            _viewContext = MockManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
            super.init(name: "Mock", managedObjectModel: StubManagedObjectModel())
        }
    }

    func testSafeContextWithoutChanges() {
        let mockPersistentContainer = MockPersistentContainer()
        mockPersistentContainer._viewContext._hasChanges = false
        let coreDataHelperExpectation = expectation(description: "CalledSaveExpectation")
        coreDataHelperExpectation.isInverted = true
        mockPersistentContainer._viewContext.calledSave = {
            coreDataHelperExpectation.fulfill()
        }

        let coreDataHelper = CoreDataHelper(persistenceContainer: mockPersistentContainer)
        coreDataHelper.saveContext()
        wait(for: [coreDataHelperExpectation], timeout: 3)
    }

    func testSafeContextWithChanges() {
        let mockPersistentContainer = MockPersistentContainer()
        mockPersistentContainer._viewContext._hasChanges = true
        let coreDataHelperExpectation = expectation(description: "CalledSaveExpectation")
        mockPersistentContainer._viewContext.calledSave = {
            coreDataHelperExpectation.fulfill()
        }

        let coreDataHelper = CoreDataHelper(persistenceContainer: mockPersistentContainer)
        coreDataHelper.saveContext()

        wait(for: [coreDataHelperExpectation], timeout: 3)
        XCTAssert(mockPersistentContainer._viewContext.hasBeenSaved, "Has to be called.")
    }

}
