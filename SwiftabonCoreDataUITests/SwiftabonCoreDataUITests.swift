//
//  SwiftabonCoreDataUITests.swift
//  SwiftabonCoreDataUITests
//
//  Created by Uladzislau Kleshchanka on 8/7/19.
//  Copyright © 2019 vladislavitsi. All rights reserved.
//

import XCTest

class SwiftabonCoreDataUITests: XCTestCase {

    var app: XCUIApplication!

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        app = XCUIApplication()
        app.launchArguments.append("--uitesting")
        app.launch()
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        app.buttons["Add"].tap()
        app.buttons["Cancel"].tap()
        app.otherElements
    }

}
