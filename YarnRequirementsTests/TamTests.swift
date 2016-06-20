//
//  TamTests.swift
//  YarnRequirements
//
//  Created by Deborah Engelmeyer on 6/20/16.
//  Copyright © 2016 The Inquisitive Introvert. All rights reserved.
//

import XCTest
@testable import YarnRequirements

class TamTests: XCTestCase {
    
    let tam = Tam(name: "Tam", thumb:UIImage(named:"Tam")!, image:UIImage(named:"Tam")!)
    
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
        tam.gaugeUnits = .StsPerInch
        tam.sizeUnits = .Inches
        tam.yarnNeededUnits = .Yards
        
        let tests = [
            PatternInfo(name: "Handy 0-6 months, gauge 4", gauge: 4, size: 16.5, yarn: 71),
            PatternInfo(name: "Handy 6-18 months, gauge 4", gauge: 4, size: 18.5, yarn: 86),
            PatternInfo(name: "Handy 18 months - 4 years, gauge 4", gauge: 4, size: 20, yarn: 101),
            PatternInfo(name: "Handy 4 years - adult S, gauge 4", gauge: 4, size: 21, yarn: 125),
            PatternInfo(name: "Handy adult M, gauge 4", gauge: 4, size: 22, yarn: 146),
            PatternInfo(name: "Handy adult L, gauge 4", gauge: 4, size: 23, yarn: 174),
            PatternInfo(name: "Handy 0-6 months, gauge 9", gauge: 9, size: 16.5, yarn: 168),
            PatternInfo(name: "Handy 6-18 months, gauge 9", gauge: 9, size: 18.5, yarn: 203),
            PatternInfo(name: "Handy 18 months - 4 years, gauge 9", gauge: 9, size: 20, yarn: 240),
            PatternInfo(name: "Handy 4 years - adult S, gauge 9", gauge: 9, size: 21, yarn: 297),
            PatternInfo(name: "Handy adult M, gauge 9", gauge: 9, size: 22, yarn: 347),
            //PatternInfo(name: "Handy adult L, gauge 9", gauge: 9, size: 23, yarn: 412), //other calculations are greater
        ]
        
        for test in tests {
            tam.size = test.size
            tam.gauge = test.gauge
            tam.calcYarnRequired()
            
            XCTAssertGreaterThanOrEqual(tam.yarnNeeded, test.yarn, "\(test.name): Yarn calculated is less than expected")
            //XCTAssertEqualWithAccuracy(Double(tam.yarnNeeded), Double(test.yarn), accuracy: Double(test.yarn) * 0.2, "\(test.name): Yarn calculated differed more than expected")
            
        }
    }
    // Compare calculated number of balls to representative patterns
    func testBalls() {
        tam.gaugeUnits = .StsPer4inch
        tam.sizeUnits = .Inches
        tam.yarnNeededUnits = .Yards
        
        let tests = [
            PatternInfo(name: "Interweave Knits, Holiday 2012, Eze Beret", gauge: 20, size: 21, ballSize: 210, balls: 1),
            ]
        for test in tests {
            tam.size = test.size
            tam.gauge = test.gauge
            tam.ballSize = test.ballSize
            tam.calcYarnRequired()
            
            XCTAssertGreaterThanOrEqual(Int(tam.ballsNeeded), test.balls, "\(test.name): Yarn calculated is less than expected")
        }
        
    }
    
}
