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
    
    /* Test the Mittens page to verify that all the pickers work as expected and the correct label
       and image are shown. */
    func testMittens() {
        
        let app = XCUIApplication()
        app.collectionViews.images["Mittens"].tap()
        
        let scrollViewsQuery = app.scrollViews
        let elementsQuery = scrollViewsQuery.otherElements
        
        XCTAssertNotNil(elementsQuery.staticTexts["Mittens"])
        XCTAssertNotNil(elementsQuery.images["Mittens"])
        
        let pickerQuery = elementsQuery.pickerWheels
        let gaugeUnits = pickerQuery.element(boundBy: 0)
        let sizeUnits = pickerQuery.element(boundBy: 1)
        let yarnUnits = pickerQuery.element(boundBy: 2)
        let ballUnits = pickerQuery.element(boundBy: 3)
        let ballFract = pickerQuery.element(boundBy: 4)

        let textQuery = elementsQuery.textFields
        let gauge = textQuery.element(boundBy: 0)
        let size = textQuery.element(boundBy: 1)
        let yarn = textQuery.element(boundBy: 2)
        let ballSize = textQuery.element(boundBy: 3)
        let balls = textQuery.element(boundBy: 4)

        XCTAssertNotEqual(yarn.value as? String, "1000", "Yarn not updated")
        
        gauge.clearAndEnterText("6.0")
        yarn.tap()
        gauge.clearAndEnterText("..")
        yarn.tap()
        XCTAssertEqual(gauge.value as? String, "6.0")
        gaugeUnits.adjust(toPickerWheelValue: "sts/10cm")
        gaugeUnits.adjust(toPickerWheelValue: "sts/inch")
        gaugeUnits.adjust(toPickerWheelValue: "sts/4inch")
        
        size.clearAndEnterText("22")
        yarn.tap()
        size.clearAndEnterText("..")
        yarn.tap()
        XCTAssertEqual(size.value as? String, "22.0")
        sizeUnits.adjust(toPickerWheelValue: "inches")
        sizeUnits.adjust(toPickerWheelValue: "cm")
        
        yarnUnits.adjust(toPickerWheelValue: "meters")
        yarnUnits.adjust(toPickerWheelValue: "yards")
        ballSize.clearAndEnterText("210")
        yarn.tap()
        ballSize.clearAndEnterText("..")
        yarn.tap()
        XCTAssertEqual(ballSize.value as? String, "210")
        ballUnits.adjust(toPickerWheelValue: "meters")
        ballUnits.adjust(toPickerWheelValue: "yards")
        
        ballFract.adjust(toPickerWheelValue: "Partial")
        ballFract.adjust(toPickerWheelValue: "Whole")
        
        XCTAssertEqual(yarn.value as? String, "64", "Yarn does not match")
        XCTAssertEqual(balls.value as? String, "1", "Num Balls do not match")
        
    }
    
    /* Test the Gloves page to verify that all the pickers work as expected and the correct label
     and image are shown. */
    func testGloves() {
        
        let app = XCUIApplication()
        app.collectionViews.images["Gloves"].tap()
        
        let scrollViewsQuery = app.scrollViews
        let elementsQuery = scrollViewsQuery.otherElements
        
        XCTAssertNotNil(elementsQuery.staticTexts["Gloves"])
        XCTAssertNotNil(elementsQuery.images["Gloves"])
        
        let pickerQuery = elementsQuery.pickerWheels
        let gaugeUnits = pickerQuery.element(boundBy: 0)
        let sizeUnits = pickerQuery.element(boundBy: 1)
        let yarnUnits = pickerQuery.element(boundBy: 2)
        let ballUnits = pickerQuery.element(boundBy: 3)
        let ballFract = pickerQuery.element(boundBy: 4)
        
        let textQuery = elementsQuery.textFields
        let gauge = textQuery.element(boundBy: 0)
        let size = textQuery.element(boundBy: 1)
        let yarn = textQuery.element(boundBy: 2)
        let ballSize = textQuery.element(boundBy: 3)
        let balls = textQuery.element(boundBy: 4)
        
        XCTAssertNotEqual(yarn.value as? String, "1000", "Yarn not updated")
        
        gauge.clearAndEnterText("7.25")
        yarn.tap()
        gauge.clearAndEnterText("..")
        yarn.tap()
        XCTAssertEqual(gauge.value as? String, "7.25")
        gaugeUnits.adjust(toPickerWheelValue: "sts/4inch")
        gaugeUnits.adjust(toPickerWheelValue: "sts/10cm")
        gaugeUnits.adjust(toPickerWheelValue: "sts/inch")
        
        size.clearAndEnterText("7.0")
        yarn.tap()
        size.clearAndEnterText("..")
        yarn.tap()
        XCTAssertEqual(size.value as? String, "7.0")
        sizeUnits.adjust(toPickerWheelValue: "cm")
        sizeUnits.adjust(toPickerWheelValue: "inches")
        
        yarnUnits.adjust(toPickerWheelValue: "meters")
        yarnUnits.adjust(toPickerWheelValue: "yards")
        ballSize.clearAndEnterText("200")
        yarn.tap()
        ballSize.clearAndEnterText("..")
        yarn.tap()
        XCTAssertEqual(ballSize.value as? String, "200")
        ballUnits.adjust(toPickerWheelValue: "yards")
        ballUnits.adjust(toPickerWheelValue: "meters")
        
        ballFract.adjust(toPickerWheelValue: "Whole")
        ballFract.adjust(toPickerWheelValue: "Partial")
        
        XCTAssertEqual(yarn.value as? String, "184", "Yarn does not match")
        XCTAssertEqual(balls.value as? String, "0.8", "Num Balls do not match")
    }
    
    /* Test the Socks page to verify that all the pickers work as expected and the correct label
     and image are shown. */
    func testSocks() {
        
        let app = XCUIApplication()
        app.collectionViews.images["Socks"].tap()
        
        let scrollViewsQuery = app.scrollViews
        let elementsQuery = scrollViewsQuery.otherElements
        
        XCTAssertNotNil(elementsQuery.staticTexts["Socks"])
        XCTAssertNotNil(elementsQuery.images["Socks"])
        
        let pickerQuery = elementsQuery.pickerWheels
        let gaugeUnits = pickerQuery.element(boundBy: 0)
        let sizeUnits = pickerQuery.element(boundBy: 1)
        let yarnUnits = pickerQuery.element(boundBy: 2)
        let ballUnits = pickerQuery.element(boundBy: 3)
        let ballFract = pickerQuery.element(boundBy: 4)
        
        let textQuery = elementsQuery.textFields
        let gauge = textQuery.element(boundBy: 0)
        let size = textQuery.element(boundBy: 1)
        let yarn = textQuery.element(boundBy: 2)
        let ballSize = textQuery.element(boundBy: 3)
        let balls = textQuery.element(boundBy: 4)
        
        XCTAssertNotEqual(yarn.value as? String, "1000", "Yarn not updated")
        
        gauge.clearAndEnterText("9")
        yarn.tap()
        gauge.clearAndEnterText("..")
        yarn.tap()
        XCTAssertEqual(gauge.value as? String, "9.0")
        gaugeUnits.adjust(toPickerWheelValue: "sts/4inch")
        gaugeUnits.adjust(toPickerWheelValue: "sts/10cm")
        gaugeUnits.adjust(toPickerWheelValue: "sts/inch")
        
        size.clearAndEnterText("49")
        yarn.tap()
        size.clearAndEnterText("..")
        yarn.tap()
        XCTAssertEqual(size.value as? String, "49.0")
        sizeUnits.adjust(toPickerWheelValue: "US Child")
        sizeUnits.adjust(toPickerWheelValue: "US Youth")
        sizeUnits.adjust(toPickerWheelValue: "US Women")
        sizeUnits.adjust(toPickerWheelValue: "US Men")
        sizeUnits.adjust(toPickerWheelValue: "Euro")
        
        yarnUnits.adjust(toPickerWheelValue: "meters")
        yarnUnits.adjust(toPickerWheelValue: "yards")
        ballSize.clearAndEnterText("200")
        yarn.tap()
        ballSize.clearAndEnterText("..")
        yarn.tap()
        XCTAssertEqual(ballSize.value as? String, "200")
        ballUnits.adjust(toPickerWheelValue: "yards")
        ballUnits.adjust(toPickerWheelValue: "meters")
        
        ballFract.adjust(toPickerWheelValue: "Whole")
        ballFract.adjust(toPickerWheelValue: "Partial")
        
        XCTAssertEqual(yarn.value as? String, "574", "Yarn does not match")
        XCTAssertEqual(balls.value as? String, "2.6", "Num Balls do not match")
    }
    
    /* Test the Tam page to verify that all the pickers work as expected and the correct label
     and image are shown. */
    func testTam() {
        
        let app = XCUIApplication()
        app.collectionViews.images["Tam"].tap()
        
        let scrollViewsQuery = app.scrollViews
        let elementsQuery = scrollViewsQuery.otherElements
        
        XCTAssertNotNil(elementsQuery.staticTexts["Tam"])
        XCTAssertNotNil(elementsQuery.images["Tam"])
        
        let pickerQuery = elementsQuery.pickerWheels
        let gaugeUnits = pickerQuery.element(boundBy: 0)
        let sizeUnits = pickerQuery.element(boundBy: 1)
        let yarnUnits = pickerQuery.element(boundBy: 2)
        let ballUnits = pickerQuery.element(boundBy: 3)
        let ballFract = pickerQuery.element(boundBy: 4)
        
        let textQuery = elementsQuery.textFields
        let gauge = textQuery.element(boundBy: 0)
        let size = textQuery.element(boundBy: 1)
        let yarn = textQuery.element(boundBy: 2)
        let ballSize = textQuery.element(boundBy: 3)
        let balls = textQuery.element(boundBy: 4)
        
        XCTAssertNotEqual(yarn.value as? String, "1000", "Yarn not updated")
        
        gauge.clearAndEnterText("9")
        yarn.tap()
        gauge.clearAndEnterText("..")
        yarn.tap()
        XCTAssertEqual(gauge.value as? String, "9.0")
        gaugeUnits.adjust(toPickerWheelValue: "sts/4inch")
        gaugeUnits.adjust(toPickerWheelValue: "sts/10cm")
        gaugeUnits.adjust(toPickerWheelValue: "sts/inch")
        
        size.clearAndEnterText("22")
        yarn.tap()
        size.clearAndEnterText("..")
        yarn.tap()
        XCTAssertEqual(size.value as? String, "22.0")
        sizeUnits.adjust(toPickerWheelValue: "cm")
        sizeUnits.adjust(toPickerWheelValue: "inches")
        
        yarnUnits.adjust(toPickerWheelValue: "meters")
        yarnUnits.adjust(toPickerWheelValue: "yards")
        ballSize.clearAndEnterText("210")
        yarn.tap()
        ballSize.clearAndEnterText("..")
        yarn.tap()
        XCTAssertEqual(ballSize.value as? String, "210")
        ballUnits.adjust(toPickerWheelValue: "yards")
        ballUnits.adjust(toPickerWheelValue: "meters")
        
        ballFract.adjust(toPickerWheelValue: "Whole")
        ballFract.adjust(toPickerWheelValue: "Partial")
        
        XCTAssertEqual(yarn.value as? String, "360", "Yarn does not match")
        XCTAssertEqual(balls.value as? String, "1.6", "Num Balls do not match")
    }
    
    /* Test the Toque page to verify that all the pickers work as expected and the correct label
     and image are shown. */
    func testToque() {
        
        let app = XCUIApplication()
        app.collectionViews.images["Toque"].tap()
        
        let scrollViewsQuery = app.scrollViews
        let elementsQuery = scrollViewsQuery.otherElements
        
        XCTAssertNotNil(elementsQuery.staticTexts["Toque"])
        XCTAssertNotNil(elementsQuery.images["Toque"])
        
        let pickerQuery = elementsQuery.pickerWheels
        let gaugeUnits = pickerQuery.element(boundBy: 0)
        let sizeUnits = pickerQuery.element(boundBy: 1)
        let yarnUnits = pickerQuery.element(boundBy: 2)
        let ballUnits = pickerQuery.element(boundBy: 3)
        let ballFract = pickerQuery.element(boundBy: 4)
        
        let textQuery = elementsQuery.textFields
        let gauge = textQuery.element(boundBy: 0)
        let size = textQuery.element(boundBy: 1)
        let yarn = textQuery.element(boundBy: 2)
        let ballSize = textQuery.element(boundBy: 3)
        let balls = textQuery.element(boundBy: 4)
        
        XCTAssertNotEqual(yarn.value as? String, "1000", "Yarn not updated")
        
        gauge.clearAndEnterText("9")
        yarn.tap()
        gauge.clearAndEnterText("..")
        yarn.tap()
        XCTAssertEqual(gauge.value as? String, "9.0")
        gaugeUnits.adjust(toPickerWheelValue: "sts/4inch")
        gaugeUnits.adjust(toPickerWheelValue: "sts/10cm")
        gaugeUnits.adjust(toPickerWheelValue: "sts/inch")
        
        size.clearAndEnterText("22")
        yarn.tap()
        size.clearAndEnterText("..")
        yarn.tap()
        XCTAssertEqual(size.value as? String, "22.0")
        sizeUnits.adjust(toPickerWheelValue: "cm")
        sizeUnits.adjust(toPickerWheelValue: "inches")
        
        yarnUnits.adjust(toPickerWheelValue: "meters")
        yarnUnits.adjust(toPickerWheelValue: "yards")
        ballSize.clearAndEnterText("200")
        yarn.tap()
        ballSize.clearAndEnterText("..")
        yarn.tap()
        XCTAssertEqual(ballSize.value as? String, "200")
        ballUnits.adjust(toPickerWheelValue: "yards")
        ballUnits.adjust(toPickerWheelValue: "meters")
        
        ballFract.adjust(toPickerWheelValue: "Whole")
        ballFract.adjust(toPickerWheelValue: "Partial")
        
        XCTAssertEqual(yarn.value as? String, "285", "Yarn does not match")
        XCTAssertEqual(balls.value as? String, "1.3", "Num Balls do not match")
    }
    
    /* Test the Sweater page to verify that all the pickers work as expected and the correct label
     and image are shown. */
    func testSweater() {
        
        let app = XCUIApplication()
        app.collectionViews.images["Sweater"].tap()
        
        let scrollViewsQuery = app.scrollViews
        let elementsQuery = scrollViewsQuery.otherElements
        
        XCTAssertNotNil(elementsQuery.staticTexts["Sweater"])
        XCTAssertNotNil(elementsQuery.images["Sweater"])
        
        let pickerQuery = elementsQuery.pickerWheels
        let gaugeUnits = pickerQuery.element(boundBy: 0)
        let sizeUnits = pickerQuery.element(boundBy: 1)
        let yarnUnits = pickerQuery.element(boundBy: 2)
        let ballUnits = pickerQuery.element(boundBy: 3)
        let ballFract = pickerQuery.element(boundBy: 4)
        
        let textQuery = elementsQuery.textFields
        let gauge = textQuery.element(boundBy: 0)
        let size = textQuery.element(boundBy: 1)
        let yarn = textQuery.element(boundBy: 2)
        let ballSize = textQuery.element(boundBy: 3)
        let balls = textQuery.element(boundBy: 4)
        
        XCTAssertNotEqual(yarn.value as? String, "1000", "Yarn not updated")
        
        gauge.clearAndEnterText("5")
        yarn.tap()
        gauge.clearAndEnterText("..")
        yarn.tap()
        XCTAssertEqual(gauge.value as? String, "5.0")
        gaugeUnits.adjust(toPickerWheelValue: "sts/4inch")
        gaugeUnits.adjust(toPickerWheelValue: "sts/10cm")
        gaugeUnits.adjust(toPickerWheelValue: "sts/inch")
        
        size.clearAndEnterText("38")
        yarn.tap()
        size.clearAndEnterText("..")
        yarn.tap()
        XCTAssertEqual(size.value as? String, "38.0")
        sizeUnits.adjust(toPickerWheelValue: "cm")
        sizeUnits.adjust(toPickerWheelValue: "inches")
        
        yarnUnits.adjust(toPickerWheelValue: "meters")
        yarnUnits.adjust(toPickerWheelValue: "yards")
        ballSize.clearAndEnterText("120")
        yarn.tap()
        ballSize.clearAndEnterText("..")
        yarn.tap()
        XCTAssertEqual(ballSize.value as? String, "120")
        ballUnits.adjust(toPickerWheelValue: "yards")
        ballUnits.adjust(toPickerWheelValue: "meters")
        
        ballFract.adjust(toPickerWheelValue: "Whole")
        ballFract.adjust(toPickerWheelValue: "Partial")
        
        XCTAssertEqual(yarn.value as? String, "1504", "Yarn does not match")
        XCTAssertEqual(balls.value as? String, "11.5", "Num Balls do not match")
    }
    
    /* Test the Vest page to verify that all the pickers work as expected and the correct label
     and image are shown. */
    func testVest() {
        
        let app = XCUIApplication()
        app.collectionViews.images["Vest"].tap()
        
        let scrollViewsQuery = app.scrollViews
        let elementsQuery = scrollViewsQuery.otherElements
        
        XCTAssertNotNil(elementsQuery.staticTexts["Vest"])
        XCTAssertNotNil(elementsQuery.images["Vest"])
        
        let pickerQuery = elementsQuery.pickerWheels
        let gaugeUnits = pickerQuery.element(boundBy: 0)
        let sizeUnits = pickerQuery.element(boundBy: 1)
        let yarnUnits = pickerQuery.element(boundBy: 2)
        let ballUnits = pickerQuery.element(boundBy: 3)
        let ballFract = pickerQuery.element(boundBy: 4)
        
        let textQuery = elementsQuery.textFields
        let gauge = textQuery.element(boundBy: 0)
        let size = textQuery.element(boundBy: 1)
        let yarn = textQuery.element(boundBy: 2)
        let ballSize = textQuery.element(boundBy: 3)
        let balls = textQuery.element(boundBy: 4)
        
        XCTAssertNotEqual(yarn.value as? String, "1000", "Yarn not updated")
        
        gauge.clearAndEnterText("28")
        yarn.tap()
        gauge.clearAndEnterText("..")
        yarn.tap()
        XCTAssertEqual(gauge.value as? String, "28.0")
        gaugeUnits.adjust(toPickerWheelValue: "sts/4inch")
        gaugeUnits.adjust(toPickerWheelValue: "sts/inch")
        gaugeUnits.adjust(toPickerWheelValue: "sts/10cm")
        
        size.clearAndEnterText("120")
        yarn.tap()
        size.clearAndEnterText("..")
        yarn.tap()
        XCTAssertEqual(size.value as? String, "120.0")
        sizeUnits.adjust(toPickerWheelValue: "inches")
        sizeUnits.adjust(toPickerWheelValue: "cm")
        
        yarnUnits.adjust(toPickerWheelValue: "yards")
        yarnUnits.adjust(toPickerWheelValue: "meters")
        ballSize.clearAndEnterText("120")
        yarn.tap()
        ballSize.clearAndEnterText("..")
        yarn.tap()
        XCTAssertEqual(ballSize.value as? String, "120")
        ballUnits.adjust(toPickerWheelValue: "yards")
        ballUnits.adjust(toPickerWheelValue: "meters")
        
        ballFract.adjust(toPickerWheelValue: "Whole")
        ballFract.adjust(toPickerWheelValue: "Partial")
        
        XCTAssertEqual(yarn.value as? String, "1561", "Yarn does not match")
        XCTAssertEqual(balls.value as? String, "13.0", "Num Balls do not match")
    }
    
    /* Test the Scarf page to verify that all the pickers work as expected and the correct label
     and image are shown. */
    func testScarf() {
        
        let app = XCUIApplication()
        app.collectionViews.images["Scarf"].tap()
        
        let scrollViewsQuery = app.scrollViews
        let elementsQuery = scrollViewsQuery.otherElements
        
        XCTAssertNotNil(elementsQuery.staticTexts["Scarf"])
        XCTAssertNotNil(elementsQuery.images["Scarf"])
        
        let pickerQuery = elementsQuery.pickerWheels
        let gaugeUnits = pickerQuery.element(boundBy: 0)
        let lengthUnits = pickerQuery.element(boundBy: 1)
        let widthUnits = pickerQuery.element(boundBy: 2)
        let yarnUnits = pickerQuery.element(boundBy: 3)
        let ballUnits = pickerQuery.element(boundBy: 4)
        let ballFract = pickerQuery.element(boundBy: 5)
        
        let textQuery = elementsQuery.textFields
        let gauge = textQuery.element(boundBy: 0)
        let length = textQuery.element(boundBy: 1)
        let width = textQuery.element(boundBy: 2)
        let yarn = textQuery.element(boundBy: 3)
        let ballSize = textQuery.element(boundBy: 4)
        let balls = textQuery.element(boundBy: 5)
        
        XCTAssertNotEqual(yarn.value as? String, "1000", "Yarn not updated")
        
        gauge.clearAndEnterText("19")
        yarn.tap()
        gauge.clearAndEnterText("..")
        yarn.tap()
        XCTAssertEqual(gauge.value as? String, "19.0")
        gaugeUnits.adjust(toPickerWheelValue: "sts/10cm")
        gaugeUnits.adjust(toPickerWheelValue: "sts/inch")
        gaugeUnits.adjust(toPickerWheelValue: "sts/4inch")
        
        length.clearAndEnterText("54")
        yarn.tap()
        length.clearAndEnterText("..")
        yarn.tap()
        XCTAssertEqual(length.value as? String, "54.0")
        lengthUnits.adjust(toPickerWheelValue: "cm")
        lengthUnits.adjust(toPickerWheelValue: "inches")
        
        width.clearAndEnterText("8.5")
        yarn.tap()
        width.clearAndEnterText("..")
        yarn.tap()
        XCTAssertEqual(width.value as? String, "8.5")
        widthUnits.adjust(toPickerWheelValue: "cm")
        widthUnits.adjust(toPickerWheelValue: "inches")
        
        yarnUnits.adjust(toPickerWheelValue: "meters")
        yarnUnits.adjust(toPickerWheelValue: "yards")
        ballSize.clearAndEnterText("120")
        yarn.tap()
        ballSize.clearAndEnterText("..")
        yarn.tap()
        XCTAssertEqual(ballSize.value as? String, "120")
        ballUnits.adjust(toPickerWheelValue: "yards")
        ballUnits.adjust(toPickerWheelValue: "meters")
        
        ballFract.adjust(toPickerWheelValue: "Whole")
        ballFract.adjust(toPickerWheelValue: "Partial")
        
        XCTAssertEqual(yarn.value as? String, "425", "Yarn does not match")
        XCTAssertEqual(balls.value as? String, "3.2", "Num Balls do not match")
    }
    
    /* Test the Blanket page to verify that all the pickers work as expected and the correct label
     and image are shown. */
    func testBlanket() {
        
        let app = XCUIApplication()
        app.collectionViews.images["Blanket"].tap()
        
        let scrollViewsQuery = app.scrollViews
        let elementsQuery = scrollViewsQuery.otherElements
        
        XCTAssertNotNil(elementsQuery.staticTexts["Blanket"])
        XCTAssertNotNil(elementsQuery.images["Blanket"])
        
        let pickerQuery = elementsQuery.pickerWheels
        let gaugeUnits = pickerQuery.element(boundBy: 0)
        let lengthUnits = pickerQuery.element(boundBy: 1)
        let widthUnits = pickerQuery.element(boundBy: 2)
        let yarnUnits = pickerQuery.element(boundBy: 3)
        let ballUnits = pickerQuery.element(boundBy: 4)
        let ballFract = pickerQuery.element(boundBy: 5)
        
        let textQuery = elementsQuery.textFields
        let gauge = textQuery.element(boundBy: 0)
        let length = textQuery.element(boundBy: 1)
        let width = textQuery.element(boundBy: 2)
        let yarn = textQuery.element(boundBy: 3)
        let ballSize = textQuery.element(boundBy: 4)
        let balls = textQuery.element(boundBy: 5)
        
        XCTAssertNotEqual(yarn.value as? String, "1000", "Yarn not updated")
        
        gauge.clearAndEnterText("20")
        yarn.tap()
        gauge.clearAndEnterText("..")
        yarn.tap()
        XCTAssertEqual(gauge.value as? String, "20.0")
        gaugeUnits.adjust(toPickerWheelValue: "sts/10cm")
        gaugeUnits.adjust(toPickerWheelValue: "sts/inch")
        gaugeUnits.adjust(toPickerWheelValue: "sts/4inch")
        
        length.clearAndEnterText("72")
        yarn.tap()
        length.clearAndEnterText("..")
        yarn.tap()
        XCTAssertEqual(length.value as? String, "72.0")
        lengthUnits.adjust(toPickerWheelValue: "cm")
        lengthUnits.adjust(toPickerWheelValue: "inches")
        
        width.clearAndEnterText("60")
        yarn.tap()
        width.clearAndEnterText("..")
        yarn.tap()
        XCTAssertEqual(width.value as? String, "60.0")
        widthUnits.adjust(toPickerWheelValue: "cm")
        widthUnits.adjust(toPickerWheelValue: "inches")
        
        yarnUnits.adjust(toPickerWheelValue: "yards")
        yarnUnits.adjust(toPickerWheelValue: "meters")
        ballSize.clearAndEnterText("150")
        yarn.tap()
        ballSize.clearAndEnterText("..")
        yarn.tap()
        XCTAssertEqual(ballSize.value as? String, "150")
        ballUnits.adjust(toPickerWheelValue: "yards")
        ballUnits.adjust(toPickerWheelValue: "meters")
        
        ballFract.adjust(toPickerWheelValue: "Whole")
        ballFract.adjust(toPickerWheelValue: "Partial")
        
        XCTAssertEqual(yarn.value as? String, "4507", "Yarn does not match")
        XCTAssertEqual(balls.value as? String, "30.0", "Num Balls do not match")
    }
    /* Verify the navigation elements work */
    func testNavigation() {
    
        let app = XCUIApplication()
        let projectsStaticText = app.navigationBars["Projects"].staticTexts["Projects"]
        XCTAssertNotNil(projectsStaticText)
        
        let tabBarsQuery = app.tabBars
        tabBarsQuery.buttons["Weights"].tap()
        XCTAssertNotNil(app.tables.staticTexts["Fingering"])

        tabBarsQuery.buttons["Info"].tap()
        let copyright = app.staticTexts["© Deborah Engelmeyer, The Inquisitive Introvert, 2016"]
        XCTAssertNotNil(copyright)
        
        tabBarsQuery.buttons["Home"].tap()
        XCTAssertNotNil(projectsStaticText)
    
    }
    /* This is my attempt at automating verifying the icon8 link on the info page.
       The test does not work - it gets hung when the app passes to Safari */
    func testIcons() {
        
        let app = XCUIApplication()
        app.tabBars.buttons["Info"].tap()
        app.buttons["Icon8"].tap()
        XCUIDevice.shared().orientation = .portrait
        XCUIDevice.shared().orientation = .portrait
        
        let url = app.otherElements["URL"]
        let exists = NSPredicate(format: "exists == true")
        expectation(for: exists, evaluatedWith: url, handler: nil)
        
        waitForExpectations(timeout: 55, handler: nil)

        XCTAssertEqual(url.value as? String, "ww12.icons8.com", "Wrong URL")

        app.statusBars.buttons["Back to Yarn Reqmts"].tap()
        XCUIDevice.shared().orientation = .portrait

        let copyright = app.staticTexts["© Deborah Engelmeyer, The Inquisitive Introvert, 2016"]
        XCTAssertNotNil(copyright)
        
    }
}
