//
//  ScarfTests.swift
//  YarnRequirements
//
//  Created by Deborah Engelmeyer on 6/15/16.
//  Copyright © 2016 The Inquisitive Introvert. All rights reserved.
//

import XCTest
@testable import YarnRequirements

class ScarfTests: XCTestCase {
    
    var scarf:Scarf!
    let cmLength = 200.0 // cm
    let cmWidth = 30.0 // cm
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        scarf = Scarf(name: "Base", thumb:UIImage(named:"Scarf")!, image:UIImage(named:"Scarf")!, control:"")
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testYardage() {
        // Verify yarn needed is in the ballpark based on The Handy Knitter's Guide
        scarf.gaugeUnits = .StsPerInch
        scarf.lengthUnits = .Inches
        scarf.widthUnits = .Inches
        scarf.yarnNeededUnits = .Yards
        
        let tests = [
            PatternInfo(gauge: 3, width: 6, length: 40, yarn: 114),
            PatternInfo(gauge: 3, width: 10, length: 51, yarn: 162),//159
         //   PatternInfo(gauge: 5, width: 6, length: 40, yarn: 204),//196
         //   PatternInfo(gauge: 6, width: 6, length: 40, yarn: 288),//233
         //   PatternInfo(gauge: 7, width: 6, length: 40, yarn: 317),//271
            PatternInfo(gauge: 3, width: 10, length: 56, yarn: 265),
         //   PatternInfo(gauge: 4, width: 10, length: 56, yarn: 376),//362
         //   PatternInfo(gauge: 5, width: 10, length: 56, yarn: 475),//449
         //   PatternInfo(gauge: 6, width: 10, length: 56, yarn: 672),
         //   PatternInfo(gauge: 7, width: 10, length: 56, yarn: 740),//632
            PatternInfo(gauge: 3, width: 14, length: 70, yarn: 464),
         //   PatternInfo(gauge: 4, width: 14, length: 70, yarn: 658),//628
         //   PatternInfo(gauge: 5, width: 14, length: 70, yarn: 831),//791
         //   PatternInfo(gauge: 6, width: 14, length: 70, yarn: 1176),//945
         //   PatternInfo(gauge: 7, width: 14, length: 70, yarn: 1294),//1097
        ]
        
        for test in tests {
            scarf.length = test.length
            scarf.width = test.width
            scarf.gauge = test.gauge
            scarf.calcYarnRequired()
            
            XCTAssertGreaterThanOrEqual(scarf.yarnNeeded, test.yarn, "Yarn calculated is less than expected")
            
        }
    }
    // Compare calculated number of balls to representative patterns
    func testBalls() {
        scarf.gaugeUnits = .StsPer4inch
        scarf.lengthUnits = .Inches
        scarf.widthUnits = .Inches
        scarf.yarnNeededUnits = .Yards
        
        let tests = [
            // Stitch Mountain, reversible cable scarf
            PatternInfo(gauge: 12, width: 10, length: 51, ballSize: 151, balls: 2),
            // Stitch Mountain, Ruffle scarf, added ruffled edge, about 4" either side
            PatternInfo(gauge: 20, width: 9, length: 61, ballSize: 120, balls: 4),
            // Stitch Mountain, Diamond Cowl
            PatternInfo(gauge: 12, width: 56, length: 9, ballSize: 229, balls: 2),
            // Creative Knitting, Jan 2007, Beaded Neck Cozy
            PatternInfo(gauge: 15, width: 7.25, length: 28.5, ballSize: 103, balls: 1),
            // Creative Knitting, Mar 2006, Pure Lux Scarf
            PatternInfo(gauge: 12.5, width: 9, length: 56, ballSize: 80, balls: 2),
            // Creative Knitting, Jan 2006, Heley Moley Scarf
            PatternInfo(gauge: 25, width: 4, length: 59, ballSize: 114, balls: 2),
            // Creative Knitting, Jan 2006, To Dye For, pattern includes toque
            PatternInfo(gauge: 19, width: 8, length: 50, ballSize: 210, balls: 2),
            // Creative Knitting, Jul 2007, Plush Pink Scarf
            PatternInfo(gauge: 8.5, width: 6.5, length: 50, ballSize: 82, balls: 2),
            // Creative Knitting, Jan 2008, Chattahoochee Scarf, has cables
            PatternInfo(gauge: 12, width: 6, length: 60, ballSize: 155, balls: 2),
            // Creative Knitting, Sep 2007, Self-Fringed Scarf, add 1" to width
            //PatternInfo(gauge: 18, width: 12, length: 55, ballSize: 150, balls: 4),
            // Interweave Knits, Holiday Gifts 2012 Ipswich Scarf
            PatternInfo(gauge: 28, width: 7, length: 63, ballSize: 200, balls: 2)

        ]
        for test in tests {
            scarf.length = test.length
            scarf.width = test.width
            scarf.gauge = test.gauge
            scarf.ballSize = test.ballSize
            scarf.calcYarnRequired()
            
            XCTAssertGreaterThanOrEqual(Int(scarf.ballsNeeded), test.balls, "Yarn calculated is less than expected")
        }
        
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock {
            // Put the code you want to measure the time of here.
        }
    }
    
}
