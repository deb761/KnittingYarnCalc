//
//  YarnRequirementsUITests.swift
//  YarnRequirementsUITests
//
//  Created by Deb on 5/14/16.
//  Copyright © 2016 The Inquisitive Introvert. All rights reserved.
//

import XCTest

class YarnRequirementsUITests: XCTestCase {
        
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testMittens() {
        
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        let app = XCUIApplication()
        app.collectionViews.images["Mittens"].tap()
        
        let scrollViewsQuery = app.scrollViews
        let element = scrollViewsQuery.childrenMatchingType(.Other).element
        let gauge = element.childrenMatchingType(.Other).elementBoundByIndex(1).childrenMatchingType(.TextField).element
        gauge.tap()
        
        let deleteKey = app.keys["Delete"]
        deleteKey.tap()
        deleteKey.tap()
        deleteKey.tap()
        deleteKey.tap()
        scrollViewsQuery.otherElements.textFields.containingType(.Button, identifier:"Clear text").element
        gauge.typeText("6.0")
        
        let yarn = element.childrenMatchingType(.Other).elementBoundByIndex(3).childrenMatchingType(.TextField).element
        yarn.tap()
        XCTAssertEqual(yarn.value as? String, "251")
        let balls = element.childrenMatchingType(.Other).elementBoundByIndex(5).childrenMatchingType(.TextField).element
        XCTAssertEqual(balls.value as? String, "2", "Balls do not match")
    }
    
    func testPickers() {
        
        let app = XCUIApplication()
        app.collectionViews.images["Mittens"].tap()
        
        let scrollViewsQuery = app.scrollViews
        let elementsQuery = scrollViewsQuery.otherElements
        let sizeUnits = elementsQuery.pickerWheels["sts/inch"]
        sizeUnits.adjustToPickerWheelValue("sts/4inch")
        
        XCTAssertEqual(sizeUnits.value as? String, "sts/4inch")
        
        let sts4inchPickerWheel = elementsQuery.pickerWheels["sts/4inch"]
        sts4inchPickerWheel.tap()
        
        let sts10cmPickerWheel = elementsQuery.pickerWheels["sts/10cm"]
        sts10cmPickerWheel.tap()
        sts10cmPickerWheel.tap()
        sts4inchPickerWheel.tap()
        elementsQuery.pickerWheels["inches"].tap()
        
        let cmPickerWheel = elementsQuery.pickerWheels["cm"]
        cmPickerWheel.tap()
        cmPickerWheel.tap()
        
        let element = scrollViewsQuery.childrenMatchingType(.Other).element
        element.childrenMatchingType(.Other).elementBoundByIndex(3).pickerWheels["yards"].tap()
        
        let metersPickerWheel = elementsQuery.pickerWheels["meters"]
        metersPickerWheel.tap()
        element.childrenMatchingType(.Other).elementBoundByIndex(4).pickerWheels["yards"].tap()
        metersPickerWheel.tap()
        element.tap()
        elementsQuery.pickerWheels["Whole"].tap()
        elementsQuery.pickerWheels["Partial"].tap()
        
    }
    
}
