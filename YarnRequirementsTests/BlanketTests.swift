//
//  BlanketTests.swift
//  YarnRequirements
//
//  Created by Deborah Engelmeyer on 6/15/16.
//  Copyright © 2016 The Inquisitive Introvert. All rights reserved.
//

import XCTest
@testable import YarnRequirements

class BlanketTests: XCTestCase {
    
    var blanket:Blanket!
    let cmLength = 200.0 // cm
    let cmWidth = 30.0 // cm
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        blanket = Blanket(name: "Base", thumb:UIImage(named:"Blanket")!, image:UIImage(named:"Blanket")!, control:"")
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testYardage() {
        // Verify yarn needed is in the ballpark based on The Handy Knitter's Guide
        blanket.gaugeUnits = .StsPer4inch
        blanket.lengthUnits = .Inches
        blanket.widthUnits = .Inches
        blanket.yarnNeededUnits = .Yards
        
        let tests = [
            // Lion Brand site yardage estimates
            //PatternInfo(gauge: 32, width: 20, length: 30, yarn: 1351),
            PatternInfo(gauge: 32, width: 60, length: 60, yarn: 3500),
            // Sport
            //PatternInfo(gauge: 24, width: 20, length: 30, yarn: 1150),
            PatternInfo(gauge: 24, width: 60, length: 60, yarn: 2950),
            // Worsted
            //PatternInfo(gauge: 20, width: 20, length: 30, yarn: 1000),
            PatternInfo(gauge: 20, width: 60, length: 60, yarn: 2660),
            // Bulky
            //PatternInfo(gauge: 12, width: 20, length: 30, yarn: 850),
            PatternInfo(gauge: 12, width: 60, length: 60, yarn: 1875),
            
            // Sideways Double Stranded Baby Blanket by Anne Hand (double stranded)
            PatternInfo(gauge: 16, width: 29, length: 35, yarn: 1176 / 2),
            // Blanket by Amanda Griffiths
            PatternInfo(gauge: 13, width: 63, length: 59, yarn: 1242),
            // Blanket #150 by Bernat Design Studio
            PatternInfo(gauge: 11, width: 27, length: 30, yarn: 400),
            // 2016 Blanket by Mari Chiba
            PatternInfo(gauge: 20, width: 52, length: 52, yarn: 2100),
            // Blanketed in Squares - easy level by Lynn Venghaus
            PatternInfo(gauge: 18, width: 32, length: 48, yarn: 925),
            // Harvest Moon Blanket by Aimee Alexander
            PatternInfo(gauge: 23, width: 16, length: 16, yarn: 250),
        ]
        
        for test in tests {
            blanket.length = test.length
            blanket.width = test.width
            blanket.gauge = test.gauge
            blanket.calcYarnRequired()
            
            XCTAssertGreaterThanOrEqual(blanket.yarnNeeded, test.yarn, "Yarn calculated is less than expected")
            /*XCTAssertEqualWithAccuracy(Double(blanket.yarnNeeded), Double(test.yarn), accuracy: Double(test.yarn) * 0.1, "Yarn calculated is more than 10% off from expected")*/
            
        }
    }
    // Compare calculated number of balls to representative patterns
    func testBalls() {
        blanket.gaugeUnits = .StsPer4inch
        blanket.lengthUnits = .Inches
        blanket.widthUnits = .Inches
        blanket.yarnNeededUnits = .Yards
        
        let tests = [
            // Stitch Mountain, Spider Blanket -- 2 strands held thoughout, so 1/2 the ballSize
            PatternInfo(gauge: 12, width: 54, length: 60, ballSize: 128, balls: 12),
            // Creative Knitting, Jul 2007, Honeycomb Afghan
            //PatternInfo(gauge: 20, width: 36, length: 48, ballSize: 210, balls: 12),
            // Creative Knitting, Mar 2007, Seaside Throw, 1 ball for fringe, still 1 ball short
            //PatternInfo(gauge: 9, width: 44, length: 55, ballSize: 49, balls: 21),
            // Creative Knitting, Jan 2008, Time Flies Throw
            PatternInfo(gauge: 17, width: 60, length: 48, ballSize: 312, balls: 7),
            // Corner to Corner Seed St Blanket by Bernat Design Studio
            PatternInfo(gauge: 8.5, width: 35, length: 35, ballSize:86, balls: 6),
            // Sunny Baby Blanket by Lucie Sinkler
            PatternInfo(gauge: 17, width: 30.25, length: 34, ballSize: 200, balls: 4),
        ]
        for test in tests {
            blanket.length = test.length
            blanket.width = test.width
            blanket.gauge = test.gauge
            blanket.ballSize = test.ballSize
            blanket.calcYarnRequired()
            
            XCTAssertGreaterThanOrEqual(Int(blanket.ballsNeeded), test.balls, "Yarn calculated is less than expected")
        }
        
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock {
            // Put the code you want to measure the time of here.
        }
    }
    
}
