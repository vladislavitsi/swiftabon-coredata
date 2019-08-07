//
//  AddRecordCoreDataPersistanceTests.swift
//  SwiftabonCoreDataTests
//
//  Created by Uladzislau Kleshchanka on 8/7/19.
//  Copyright © 2019 vladislavitsi. All rights reserved.
//

import XCTest
import CoreData

@testable import SwiftabonCoreData

class AddRecordCoreDataPersistanceTests: XCTestCase {

    class CoreDataServiceMock: CoreDataService {
        var isSaveContextCalled = false

        init() {
            super.init(coreDataHelper: CoreDataHelper(persistenceContainer: NSPersistentContainer(name: "Stub")))
        }

        override func saveContext() {
            isSaveContextCalled = true
        }
    }

    func testAddRecord() {

        let coreDataServiceMock = CoreDataServiceMock()
        let persistence = AddRecordCoreDataPersistance(coreDataService: coreDataServiceMock)
        persistence.add(record: Record(user: nil, text: nil, date: nil))

        XCTAssert(coreDataServiceMock.isSaveContextCalled, "SaveContext shoud have been called.")
    }

}
