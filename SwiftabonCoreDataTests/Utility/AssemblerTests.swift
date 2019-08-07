//
//  AssemblerTests.swift
//  SwiftabonCoreDataTests
//
//  Created by Uladzislau Kleshchanka on 8/7/19.
//  Copyright © 2019 vladislavitsi. All rights reserved.
//

import XCTest

@testable import SwiftabonCoreData

class AssemblerTests: XCTestCase {

    func testFeedViewController() {
        let feedViewController = Assembler.feedViewController

        XCTAssertNotNil(feedViewController.viewModel, "ViewModel should not be nil.")
    }

    func testAddRecordViewController() {
        let addRecordViewController = Assembler.addRecordViewController

        XCTAssertNotNil(addRecordViewController.viewModel, "ViewModel should not be nil.")
    }
}
