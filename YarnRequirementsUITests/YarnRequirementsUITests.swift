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
        let gaugeUnits = pickerQuery.elementBoundByIndex(0)
        let sizeUnits = pickerQuery.elementBoundByIndex(1)
        let yarnUnits = pickerQuery.elementBoundByIndex(2)
        let ballUnits = pickerQuery.elementBoundByIndex(3)
        let ballFract = pickerQuery.elementBoundByIndex(4)

        let textQuery = elementsQuery.textFields
        let gauge = textQuery.elementBoundByIndex(0)
        let size = textQuery.elementBoundByIndex(1)
        let yarn = textQuery.elementBoundByIndex(2)
        let ballSize = textQuery.elementBoundByIndex(3)
        let balls = textQuery.elementBoundByIndex(4)

        XCTAssertNotEqual(yarn.value as? String, "1000", "Yarn not updated")
        
        gauge.clearAndEnterText("6.0")
        gaugeUnits.adjustToPickerWheelValue("sts/10cm")
        gaugeUnits.adjustToPickerWheelValue("sts/inch")
        gaugeUnits.adjustToPickerWheelValue("sts/4inch")
        
        size.clearAndEnterText("22")
        sizeUnits.adjustToPickerWheelValue("inches")
        sizeUnits.adjustToPickerWheelValue("cm")
        
        yarnUnits.adjustToPickerWheelValue("meters")
        yarnUnits.adjustToPickerWheelValue("yards")
        ballSize.clearAndEnterText("210")
        ballUnits.adjustToPickerWheelValue("meters")
        ballUnits.adjustToPickerWheelValue("yards")
        
        ballFract.adjustToPickerWheelValue("Partial")
        ballFract.adjustToPickerWheelValue("Whole")
        
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
        let gaugeUnits = pickerQuery.elementBoundByIndex(0)
        let sizeUnits = pickerQuery.elementBoundByIndex(1)
        let yarnUnits = pickerQuery.elementBoundByIndex(2)
        let ballUnits = pickerQuery.elementBoundByIndex(3)
        let ballFract = pickerQuery.elementBoundByIndex(4)
        
        let textQuery = elementsQuery.textFields
        let gauge = textQuery.elementBoundByIndex(0)
        let size = textQuery.elementBoundByIndex(1)
        let yarn = textQuery.elementBoundByIndex(2)
        let ballSize = textQuery.elementBoundByIndex(3)
        let balls = textQuery.elementBoundByIndex(4)
        
        XCTAssertNotEqual(yarn.value as? String, "1000", "Yarn not updated")
        
        gauge.clearAndEnterText("7.25")
        gaugeUnits.adjustToPickerWheelValue("sts/4inch")
        gaugeUnits.adjustToPickerWheelValue("sts/10cm")
        gaugeUnits.adjustToPickerWheelValue("sts/inch")
        
        size.clearAndEnterText("7.0")
        sizeUnits.adjustToPickerWheelValue("cm")
        sizeUnits.adjustToPickerWheelValue("inches")
        
        yarnUnits.adjustToPickerWheelValue("meters")
        yarnUnits.adjustToPickerWheelValue("yards")
        ballSize.clearAndEnterText("200")
        ballUnits.adjustToPickerWheelValue("yards")
        ballUnits.adjustToPickerWheelValue("meters")
        
        ballFract.adjustToPickerWheelValue("Whole")
        ballFract.adjustToPickerWheelValue("Partial")
        
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
        let gaugeUnits = pickerQuery.elementBoundByIndex(0)
        let sizeUnits = pickerQuery.elementBoundByIndex(1)
        let yarnUnits = pickerQuery.elementBoundByIndex(2)
        let ballUnits = pickerQuery.elementBoundByIndex(3)
        let ballFract = pickerQuery.elementBoundByIndex(4)
        
        let textQuery = elementsQuery.textFields
        let gauge = textQuery.elementBoundByIndex(0)
        let size = textQuery.elementBoundByIndex(1)
        let yarn = textQuery.elementBoundByIndex(2)
        let ballSize = textQuery.elementBoundByIndex(3)
        let balls = textQuery.elementBoundByIndex(4)
        
        XCTAssertNotEqual(yarn.value as? String, "1000", "Yarn not updated")
        
        gauge.clearAndEnterText("9")
        gaugeUnits.adjustToPickerWheelValue("sts/4inch")
        gaugeUnits.adjustToPickerWheelValue("sts/10cm")
        gaugeUnits.adjustToPickerWheelValue("sts/inch")
        
        size.clearAndEnterText("49")
        sizeUnits.adjustToPickerWheelValue("US Child")
        sizeUnits.adjustToPickerWheelValue("US Youth")
        sizeUnits.adjustToPickerWheelValue("US Women")
        sizeUnits.adjustToPickerWheelValue("US Men")
        sizeUnits.adjustToPickerWheelValue("Euro")
        
        yarnUnits.adjustToPickerWheelValue("meters")
        yarnUnits.adjustToPickerWheelValue("yards")
        ballSize.clearAndEnterText("200")
        ballUnits.adjustToPickerWheelValue("yards")
        ballUnits.adjustToPickerWheelValue("meters")
        
        ballFract.adjustToPickerWheelValue("Whole")
        ballFract.adjustToPickerWheelValue("Partial")
        
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
        let gaugeUnits = pickerQuery.elementBoundByIndex(0)
        let sizeUnits = pickerQuery.elementBoundByIndex(1)
        let yarnUnits = pickerQuery.elementBoundByIndex(2)
        let ballUnits = pickerQuery.elementBoundByIndex(3)
        let ballFract = pickerQuery.elementBoundByIndex(4)
        
        let textQuery = elementsQuery.textFields
        let gauge = textQuery.elementBoundByIndex(0)
        let size = textQuery.elementBoundByIndex(1)
        let yarn = textQuery.elementBoundByIndex(2)
        let ballSize = textQuery.elementBoundByIndex(3)
        let balls = textQuery.elementBoundByIndex(4)
        
        XCTAssertNotEqual(yarn.value as? String, "1000", "Yarn not updated")
        
        gauge.clearAndEnterText("9")
        gaugeUnits.adjustToPickerWheelValue("sts/4inch")
        gaugeUnits.adjustToPickerWheelValue("sts/10cm")
        gaugeUnits.adjustToPickerWheelValue("sts/inch")
        
        size.clearAndEnterText("22")
        sizeUnits.adjustToPickerWheelValue("cm")
        sizeUnits.adjustToPickerWheelValue("inches")
        
        yarnUnits.adjustToPickerWheelValue("meters")
        yarnUnits.adjustToPickerWheelValue("yards")
        ballSize.clearAndEnterText("210")
        ballUnits.adjustToPickerWheelValue("yards")
        ballUnits.adjustToPickerWheelValue("meters")
        
        ballFract.adjustToPickerWheelValue("Whole")
        ballFract.adjustToPickerWheelValue("Partial")
        
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
        let gaugeUnits = pickerQuery.elementBoundByIndex(0)
        let sizeUnits = pickerQuery.elementBoundByIndex(1)
        let yarnUnits = pickerQuery.elementBoundByIndex(2)
        let ballUnits = pickerQuery.elementBoundByIndex(3)
        let ballFract = pickerQuery.elementBoundByIndex(4)
        
        let textQuery = elementsQuery.textFields
        let gauge = textQuery.elementBoundByIndex(0)
        let size = textQuery.elementBoundByIndex(1)
        let yarn = textQuery.elementBoundByIndex(2)
        let ballSize = textQuery.elementBoundByIndex(3)
        let balls = textQuery.elementBoundByIndex(4)
        
        XCTAssertNotEqual(yarn.value as? String, "1000", "Yarn not updated")
        
        gauge.clearAndEnterText("9")
        gaugeUnits.adjustToPickerWheelValue("sts/4inch")
        gaugeUnits.adjustToPickerWheelValue("sts/10cm")
        gaugeUnits.adjustToPickerWheelValue("sts/inch")
        
        size.clearAndEnterText("22")
        sizeUnits.adjustToPickerWheelValue("cm")
        sizeUnits.adjustToPickerWheelValue("inches")
        
        yarnUnits.adjustToPickerWheelValue("meters")
        yarnUnits.adjustToPickerWheelValue("yards")
        ballSize.clearAndEnterText("200")
        ballUnits.adjustToPickerWheelValue("yards")
        ballUnits.adjustToPickerWheelValue("meters")
        
        ballFract.adjustToPickerWheelValue("Whole")
        ballFract.adjustToPickerWheelValue("Partial")
        
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
        let gaugeUnits = pickerQuery.elementBoundByIndex(0)
        let sizeUnits = pickerQuery.elementBoundByIndex(1)
        let yarnUnits = pickerQuery.elementBoundByIndex(2)
        let ballUnits = pickerQuery.elementBoundByIndex(3)
        let ballFract = pickerQuery.elementBoundByIndex(4)
        
        let textQuery = elementsQuery.textFields
        let gauge = textQuery.elementBoundByIndex(0)
        let size = textQuery.elementBoundByIndex(1)
        let yarn = textQuery.elementBoundByIndex(2)
        let ballSize = textQuery.elementBoundByIndex(3)
        let balls = textQuery.elementBoundByIndex(4)
        
        XCTAssertNotEqual(yarn.value as? String, "1000", "Yarn not updated")
        
        gauge.clearAndEnterText("5")
        yarn.tap()
        gaugeUnits.adjustToPickerWheelValue("sts/4inch")
        gaugeUnits.adjustToPickerWheelValue("sts/10cm")
        gaugeUnits.adjustToPickerWheelValue("sts/inch")
        
        size.clearAndEnterText("38")
        sizeUnits.adjustToPickerWheelValue("cm")
        sizeUnits.adjustToPickerWheelValue("inches")
        
        yarnUnits.adjustToPickerWheelValue("meters")
        yarnUnits.adjustToPickerWheelValue("yards")
        ballSize.clearAndEnterText("120")
        ballUnits.adjustToPickerWheelValue("yards")
        ballUnits.adjustToPickerWheelValue("meters")
        
        ballFract.adjustToPickerWheelValue("Whole")
        ballFract.adjustToPickerWheelValue("Partial")
        
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
        let gaugeUnits = pickerQuery.elementBoundByIndex(0)
        let sizeUnits = pickerQuery.elementBoundByIndex(1)
        let yarnUnits = pickerQuery.elementBoundByIndex(2)
        let ballUnits = pickerQuery.elementBoundByIndex(3)
        let ballFract = pickerQuery.elementBoundByIndex(4)
        
        let textQuery = elementsQuery.textFields
        let gauge = textQuery.elementBoundByIndex(0)
        let size = textQuery.elementBoundByIndex(1)
        let yarn = textQuery.elementBoundByIndex(2)
        let ballSize = textQuery.elementBoundByIndex(3)
        let balls = textQuery.elementBoundByIndex(4)
        
        XCTAssertNotEqual(yarn.value as? String, "1000", "Yarn not updated")
        
        gauge.clearAndEnterText("28")
        yarn.tap()
        gaugeUnits.adjustToPickerWheelValue("sts/4inch")
        gaugeUnits.adjustToPickerWheelValue("sts/inch")
        gaugeUnits.adjustToPickerWheelValue("sts/10cm")
        
        size.clearAndEnterText("120")
        sizeUnits.adjustToPickerWheelValue("inches")
        sizeUnits.adjustToPickerWheelValue("cm")
        
        yarnUnits.adjustToPickerWheelValue("yards")
        yarnUnits.adjustToPickerWheelValue("meters")
        ballSize.clearAndEnterText("120")
        ballUnits.adjustToPickerWheelValue("yards")
        ballUnits.adjustToPickerWheelValue("meters")
        
        ballFract.adjustToPickerWheelValue("Whole")
        ballFract.adjustToPickerWheelValue("Partial")
        
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
        let gaugeUnits = pickerQuery.elementBoundByIndex(0)
        let lengthUnits = pickerQuery.elementBoundByIndex(1)
        let widthUnits = pickerQuery.elementBoundByIndex(2)
        let yarnUnits = pickerQuery.elementBoundByIndex(3)
        let ballUnits = pickerQuery.elementBoundByIndex(4)
        let ballFract = pickerQuery.elementBoundByIndex(5)
        
        let textQuery = elementsQuery.textFields
        let gauge = textQuery.elementBoundByIndex(0)
        let length = textQuery.elementBoundByIndex(1)
        let width = textQuery.elementBoundByIndex(2)
        let yarn = textQuery.elementBoundByIndex(3)
        let ballSize = textQuery.elementBoundByIndex(4)
        let balls = textQuery.elementBoundByIndex(5)
        
        XCTAssertNotEqual(yarn.value as? String, "1000", "Yarn not updated")
        
        gauge.clearAndEnterText("19")
        gaugeUnits.adjustToPickerWheelValue("sts/10cm")
        gaugeUnits.adjustToPickerWheelValue("sts/inch")
        gaugeUnits.adjustToPickerWheelValue("sts/4inch")
        
        length.clearAndEnterText("54")
        lengthUnits.adjustToPickerWheelValue("cm")
        lengthUnits.adjustToPickerWheelValue("inches")
        
        width.clearAndEnterText("8.5")
        widthUnits.adjustToPickerWheelValue("cm")
        widthUnits.adjustToPickerWheelValue("inches")
        
        yarnUnits.adjustToPickerWheelValue("meters")
        yarnUnits.adjustToPickerWheelValue("yards")
        ballSize.clearAndEnterText("120")
        ballUnits.adjustToPickerWheelValue("yards")
        ballUnits.adjustToPickerWheelValue("meters")
        
        ballFract.adjustToPickerWheelValue("Whole")
        ballFract.adjustToPickerWheelValue("Partial")
        
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
        let gaugeUnits = pickerQuery.elementBoundByIndex(0)
        let lengthUnits = pickerQuery.elementBoundByIndex(1)
        let widthUnits = pickerQuery.elementBoundByIndex(2)
        let yarnUnits = pickerQuery.elementBoundByIndex(3)
        let ballUnits = pickerQuery.elementBoundByIndex(4)
        let ballFract = pickerQuery.elementBoundByIndex(5)
        
        let textQuery = elementsQuery.textFields
        let gauge = textQuery.elementBoundByIndex(0)
        let length = textQuery.elementBoundByIndex(1)
        let width = textQuery.elementBoundByIndex(2)
        let yarn = textQuery.elementBoundByIndex(3)
        let ballSize = textQuery.elementBoundByIndex(4)
        let balls = textQuery.elementBoundByIndex(5)
        
        XCTAssertNotEqual(yarn.value as? String, "1000", "Yarn not updated")
        
        gauge.clearAndEnterText("20")
        gaugeUnits.adjustToPickerWheelValue("sts/10cm")
        gaugeUnits.adjustToPickerWheelValue("sts/inch")
        gaugeUnits.adjustToPickerWheelValue("sts/4inch")
        
        length.clearAndEnterText("72")
        lengthUnits.adjustToPickerWheelValue("cm")
        lengthUnits.adjustToPickerWheelValue("inches")
        
        width.clearAndEnterText("60")
        widthUnits.adjustToPickerWheelValue("cm")
        widthUnits.adjustToPickerWheelValue("inches")
        
        yarnUnits.adjustToPickerWheelValue("yards")
        yarnUnits.adjustToPickerWheelValue("meters")
        ballSize.clearAndEnterText("150")
        ballUnits.adjustToPickerWheelValue("yards")
        ballUnits.adjustToPickerWheelValue("meters")
        
        ballFract.adjustToPickerWheelValue("Whole")
        ballFract.adjustToPickerWheelValue("Partial")
        
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
        XCUIDevice.sharedDevice().orientation = .Portrait
        XCUIDevice.sharedDevice().orientation = .Portrait
        
        let url = app.otherElements["URL"]
        let exists = NSPredicate(format: "exists == true")
        expectationForPredicate(exists, evaluatedWithObject: url, handler: nil)
        
        waitForExpectationsWithTimeout(55, handler: nil)

        XCTAssertEqual(url.value as? String, "ww12.icons8.com", "Wrong URL")

        app.statusBars.buttons["Back to Yarn Reqmts"].tap()
        XCUIDevice.sharedDevice().orientation = .Portrait
        XCUIDevice.sharedDevice().orientation = .Portrait

        /*let copyright = app.staticTexts["© Deborah Engelmeyer, The Inquisitive Introvert, 2016"]
        XCTAssertNotNil(copyright)*/
        
    }
}
