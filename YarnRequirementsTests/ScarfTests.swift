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
        scarf = Scarf(name: "Base", thumb:UIImage(named:"Scarf")!, image:UIImage(named:"Scarf")!)
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testYarn() {
        // Verify yarn needed is in the ballpark based on The Handy Knitter's Guide
        scarf.gaugeUnits = .StsPerInch
        scarf.lengthUnits = .Inches
        scarf.widthUnits = .Inches
        scarf.yarnNeededUnits = .Yards
        
        let tests = [
            PatternInfo(name: "Handy 1", gauge: 3, width: 6, length: 40, yarn: 114),
            PatternInfo(name: "Handy 2", gauge: 3, width: 10, length: 51, yarn: 162),
            PatternInfo(name: "Handy 3", gauge: 5, width: 6, length: 40, yarn: 204),
            PatternInfo(name: "Handy 4", gauge: 6, width: 6, length: 40, yarn: 288),
            PatternInfo(name: "Handy 5", gauge: 7, width: 6, length: 40, yarn: 317),
            PatternInfo(name: "Handy 6", gauge: 3, width: 10, length: 56, yarn: 265),
            PatternInfo(name: "Handy 7", gauge: 4, width: 10, length: 56, yarn: 376),
            PatternInfo(name: "Handy 8", gauge: 5, width: 10, length: 56, yarn: 475),
            PatternInfo(name: "Handy 9", gauge: 6, width: 10, length: 56, yarn: 672),
            PatternInfo(name: "Handy 10", gauge: 7, width: 10, length: 56, yarn: 740),
            PatternInfo(name: "Handy 11", gauge: 3, width: 14, length: 70, yarn: 464),
            PatternInfo(name: "Handy 12", gauge: 4, width: 14, length: 70, yarn: 658),
            PatternInfo(name: "Handy 13", gauge: 5, width: 14, length: 70, yarn: 831),
            PatternInfo(name: "Handy 14", gauge: 6, width: 14, length: 70, yarn: 1176),
            PatternInfo(name: "Handy 15", gauge: 7, width: 14, length: 70, yarn: 1294),
        ]
        
        for test in tests {
            scarf.length = test.length
            scarf.width = test.width
            scarf.gauge = test.gauge
            scarf.calcYarnRequired()
            
            XCTAssertGreaterThanOrEqual(scarf.yarnNeeded + Int(Double(test.yarn) * 0.05), test.yarn, "\(test.name): Yarn calculated is less than expected")
        }
    }
    // Compare calculated number of balls to representative patterns
    func testBalls() {
        scarf.gaugeUnits = .StsPer4inch
        scarf.lengthUnits = .Inches
        scarf.widthUnits = .Inches
        scarf.yarnNeededUnits = .Yards
        
        let tests = [
            PatternInfo(name: "Stitch Mountain, reversible cable scarf", gauge: 12, width: 10, length: 51, ballSize: 151, balls: 2),
            // added ruffled edge, about 4" either side
            PatternInfo(name: "Stitch Mountain, Ruffle scarf", gauge: 20, width: 9, length: 61, ballSize: 120, balls: 4),
            PatternInfo(name: "Stitch Mountain, Diamond Cowl", gauge: 12, width: 56, length: 9, ballSize: 229, balls: 2),
            PatternInfo(name: "Creative Knitting, Jan 2007, Beaded Neck Cozy", gauge: 15, width: 7.25, length: 28.5, ballSize: 103, balls: 1),
            PatternInfo(name: " Creative Knitting, Mar 2006, Pure Lux Scarf", gauge: 12.5, width: 9, length: 56, ballSize: 80, balls: 2),
            PatternInfo(name: "Creative Knitting, Jan 2006, Heley Moley Scarf", gauge: 25, width: 4, length: 59, ballSize: 114, balls: 2),
            PatternInfo(name: "Creative Knitting, Jan 2006, To Dye For, pattern includes toque",
                gauge: 19, width: 8, length: 50, ballSize: 210, balls: 2),
            PatternInfo(name: "Creative Knitting, Jul 2007, Plush Pink Scarf", gauge: 8.5, width: 6.5, length: 50, ballSize: 82, balls: 2),
            PatternInfo(name: "Creative Knitting, Jan 2008, Chattahoochee Scarf, has cables", gauge: 12, width: 6, length: 60, ballSize: 155, balls: 2),
            PatternInfo(name: "Creative Knitting, Sep 2007, Self-Fringed Scarf, add 1inch to width", gauge: 18, width: 12, length: 55, ballSize: 150, balls: 4),
            PatternInfo(name: "Interweave Knits, Holiday Gifts 2012 Ipswich Scarf", gauge: 28, width: 7, length: 63, ballSize: 200, balls: 2)

        ]
        for test in tests {
            scarf.length = test.length
            scarf.width = test.width
            scarf.gauge = test.gauge
            scarf.ballSize = test.ballSize
            scarf.calcYarnRequired()
            
            XCTAssertGreaterThanOrEqual(Int(scarf.ballsNeeded), test.balls, "\(test.name): Yarn calculated is less than expected")
        }
        
    }
    
}
