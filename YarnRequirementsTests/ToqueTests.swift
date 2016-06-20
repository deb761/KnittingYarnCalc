//
//  ToqueTests.swift
//  YarnRequirements
//
//  Created by Deborah Engelmeyer on 6/17/16.
//  Copyright © 2016 The Inquisitive Introvert. All rights reserved.
//

import XCTest
@testable import YarnRequirements

class ToqueTests: XCTestCase {
    
    let toque = Toque(name: "Toque", thumb:UIImage(named:"Toque")!, image:UIImage(named:"Toque")!)

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testYarn() {
        // Verify yarn needed is in the ballpark based on The Handy Knitter's Guide
        toque.gaugeUnits = .StsPerInch
        toque.sizeUnits = .Inches
        toque.yarnNeededUnits = .Yards
        
        let tests = [
            // Lion Brand site yardage estimates
            PatternInfo(name: "Handy preemie, gauge 3", gauge: 3, size: 15, yarn: 38),
            PatternInfo(name: "Handy 0-6 months, gauge 3", gauge: 3, size: 16.5, yarn: 47),
            PatternInfo(name: "Handy 6-18 months, gauge 3", gauge: 3, size: 18.5, yarn: 68),
            PatternInfo(name: "Handy 18 months - 4 years, gauge 3", gauge: 3, size: 20, yarn: 88),
            PatternInfo(name: "Handy 4 years - adult S, gauge 3", gauge: 3, size: 21, yarn: 107),
            PatternInfo(name: "Handy adult M-L, gauge 3", gauge: 3, size: 23, yarn: 131),
            PatternInfo(name: "Handy preemie, gauge 9", gauge: 9, size: 15, yarn: 126),
            PatternInfo(name: "Handy 0-6 months, gauge 9", gauge: 9, size: 16.5, yarn: 158),
            PatternInfo(name: "Handy 6-18 months, gauge 9", gauge: 9, size: 18.5, yarn: 229),
            PatternInfo(name: "Handy 18 months - 4 years, gauge 9", gauge: 9, size: 20, yarn: 296),
            //PatternInfo(name: "Handy 4 years - adult S, gauge 9", gauge: 9, size: 21, yarn: 361), //other calculations are greater, most >20% more
            //PatternInfo(name: "Handy adult M-L, gauge 9", gauge: 9, size: 23, yarn: 441), //others calculations are greater
        ]
        
        for test in tests {
            toque.size = test.size
            toque.gauge = test.gauge
            toque.calcYarnRequired()
            
            XCTAssertGreaterThanOrEqual(toque.yarnNeeded, test.yarn, "\(test.name): Yarn calculated is less than expected")
            //XCTAssertEqualWithAccuracy(Double(toque.yarnNeeded), Double(test.yarn), accuracy: Double(test.yarn) * 0.2, "\(test.name): Yarn calculated is more than 10% off from expected")
            
        }
    }
    // Compare calculated number of balls to representative patterns
    func testBalls() {
        toque.gaugeUnits = .StsPer4inch
        toque.sizeUnits = .Inches
        toque.yarnNeededUnits = .Yards
        
        let tests = [
            PatternInfo(name: "Stitch Mountain, Variegated Hat", gauge: 17, size: 22, ballSize: 151, balls: 2),
            PatternInfo(name: "Stitch Mountain, Ribbed Ski Cap", gauge: 20, size: 21, ballSize: 120, balls: 1),
            PatternInfo(name: "Stitch Mountain, Sparkle Slouchy Hat", gauge: 18, size: 21, ballSize: 153, balls: 1),
            PatternInfo(name: "Interweave Knits, Holiday 2012, Braided Toque", gauge: 37, size: 21, ballSize: 210, balls: 1),
            PatternInfo(name: "Interweave Knits, Holiday 2012, Snow Time Hat, S", gauge: 41, size: 12.75 / 0.93, ballSize: 462, balls: 1),
            PatternInfo(name: "Interweave Knits, Holiday 2012, Snow Time Hat, M", gauge: 41, size: 14.5 / 0.93, ballSize: 462, balls: 1),
            PatternInfo(name: "Interweave Knits, Holiday 2012, Snow Time Hat, L", gauge: 41, size: 16.5 / 0.93, ballSize: 462, balls: 1),
            ]
        for test in tests {
            toque.size = test.size
            toque.gauge = test.gauge
            toque.ballSize = test.ballSize
            toque.calcYarnRequired()
            
            XCTAssertGreaterThanOrEqual(Int(toque.ballsNeeded), test.balls, "\(test.name): Yarn calculated is less than expected")
        }
        
    }
}
