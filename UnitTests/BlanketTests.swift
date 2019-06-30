//
//  BlanketTests.swift
//  YarnRequirements
//
//  Created by Deborah Engelmeyer on 6/15/16.
//  Copyright © 2019 The Inquisitive Introvert. All rights reserved.
//

import XCTest
@testable import KnittingYarnCalcPro

class BlanketTests: XCTestCase {
    
    var blanket:Blanket!
    let cmLength = 200.0 // cm
    let cmWidth = 30.0 // cm
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        blanket = Blanket(name: "Blanket")
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testYarn() {
        // Verify yarn needed is in the ballpark based on The Handy Knitter's Guide
        blanket.gaugeUnits = .stsPer4inch
        blanket.lengthUnits = .inches
        blanket.widthUnits = .inches
        blanket.yarnNeededUnits = .yards
        
        let tests = [
            // Lion Brand site yardage estimates
            PatternInfo(name: "Lion Brand site 1", gauge: 32, width: 20, length: 30, yarn: 583), //1/6 of larger
            PatternInfo(name: "Lion Brand site 2", gauge: 32, width: 60, length: 60, yarn: 3500),
            // Sport
            PatternInfo(name: "Lion Brand site 3", gauge: 24, width: 20, length: 30, yarn: 491),//1/6 of larger
            PatternInfo(name: "Lion Brand site 4", gauge: 24, width: 60, length: 60, yarn: 2950),
            // Worsted
            PatternInfo(name: "Lion Brand site 5", gauge: 20, width: 20, length: 30, yarn: 443),//1/6 of larger
            PatternInfo(name: "Lion Brand site 6", gauge: 20, width: 60, length: 60, yarn: 2660),
            // Bulky
            PatternInfo(name: "Lion Brand site 7", gauge: 12, width: 20, length: 30, yarn: 312),//1/6 of larger
            PatternInfo(name: "Lion Brand site 8", gauge: 12, width: 60, length: 60, yarn: 1875),
            //  (double stranded)
            PatternInfo(name: "Sideways Double Stranded Baby Blanket by Anne Hand", gauge: 16, width: 29, length: 35, yarn: 1176 / 2),
            PatternInfo(name: "Blanket by Amanda Griffiths", gauge: 13, width: 63, length: 59, yarn: 1242),
            PatternInfo(name: "Blanket #150 by Bernat Design Studio", gauge: 11, width: 27, length: 30, yarn: 400),
            PatternInfo(name: "2016 Blanket by Mari Chiba", gauge: 20, width: 52, length: 52, yarn: 2100),
            PatternInfo(name: "Blanketed in Squares - easy level by Lynn Venghaus", gauge: 18, width: 32, length: 48, yarn: 925),
            PatternInfo(name: "Harvest Moon Blanket by Aimee Alexander", gauge: 23, width: 16, length: 16, yarn: 250),
        ]
        
        for test in tests {
            blanket.length = test.length
            blanket.width = test.width
            blanket.gauge = test.gauge
            blanket.calcYarnRequired()
            
            XCTAssertGreaterThanOrEqual(blanket.yarnNeeded, test.yarn, "\(test.name): Yarn calculated is less than expected")
            /*XCTAssertEqualWithAccuracy(Double(blanket.yarnNeeded), Double(test.yarn), accuracy: Double(test.yarn) * 0.1, "Yarn calculated is more than 10% off from expected")*/
            
        }
    }
    // Compare calculated number of balls to representative patterns
    func testBalls() {
        blanket.gaugeUnits = .stsPer4inch
        blanket.lengthUnits = .inches
        blanket.widthUnits = .inches
        blanket.yarnNeededUnits = .yards
        
        let tests = [
            // 2 strands held thoughout, so 1/2 the ballSize
            PatternInfo(name: "Stitch Mountain, Spider Blanket", gauge: 12, width: 54, length: 60, ballSize: 128, balls: 12),
            //PatternInfo(name: "Creative Knitting, Jul 2007, Honeycomb Afghan", gauge: 20, width: 36, length: 48, ballSize: 210, balls: 12),
            // 1 ball for fringe, still 1 ball short
            PatternInfo(name: "Creative Knitting, Mar 2007, Seaside Throw", gauge: 9, width: 44, length: 55, ballSize: 49, balls: 21),
            PatternInfo(name: "Creative Knitting, Jan 2008, Time Flies Throw", gauge: 17, width: 60, length: 48, ballSize: 312, balls: 7),
            PatternInfo(name: "Corner to Corner Seed St Blanket by Bernat Design Studio", gauge: 8.5, width: 35, length: 35, ballSize:86, balls: 6),
            PatternInfo(name: "Sunny Baby Blanket by Lucie Sinkler", gauge: 17, width: 30.25, length: 34, ballSize: 200, balls: 4),
        ]
        for test in tests {
            blanket.length = test.length
            blanket.width = test.width
            blanket.gauge = test.gauge
            blanket.ballSize = test.ballSize
            blanket.calcYarnRequired()
            
            XCTAssertGreaterThanOrEqual(Int(blanket.ballsNeeded), test.balls, "\(test.name): Yarn calculated is less than expected")
        }
        
    }
}
