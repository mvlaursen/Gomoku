//
//  GomokuUITests.swift
//  GomokuUITests
//
//  Created by Mike Laursen on 10/28/18.
//  Copyright © 2019 Appamajigger. All rights reserved.
//

import XCTest

class GomokuUITests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.

        let app = XCUIApplication()
        app.launchArguments.append("ui-testing")
        app.launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testPlayASelfPlayingGame() {
        let playButton = XCUIApplication().buttons["Play"]
        XCTAssert(playButton.isEnabled)
        
        playButton.tap()
        XCTAssertFalse(playButton.isEnabled)
        
        // TODO: This is kind of a crappy way of watching for the end of the
        // game. Do something better.
        while !playButton.isEnabled {
            sleep(5)
        }
        XCTAssert(true)
    }
}
