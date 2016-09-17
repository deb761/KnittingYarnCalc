//
//  MittensTests.swift
//  YarnRequirements
//
//  Created by Deborah Engelmeyer on 6/20/16.
//  Copyright © 2016 The Inquisitive Introvert. All rights reserved.
//

import XCTest
@testable import YarnRequirements

class MittensTests: XCTestCase {
    
    let mittens = Mittens(name: "Mittens", thumb:UIImage(named:"Mittens")!, image:UIImage(named:"Mittens")!)
    
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
        mittens.gaugeUnits = .stsPerInch
        mittens.sizeUnits = .inches
        mittens.yarnNeededUnits = .yards
        
        let tests = [
            PatternInfo(name: "Handy 2-4 years, gauge 4", gauge: 4, size: 5.5, yarn: 47),
            PatternInfo(name: "Handy 4-6 years, gauge 4", gauge: 4, size: 6, yarn: 63),
            PatternInfo(name: "Handy 6-8 years, gauge 4", gauge: 4, size: 6.5, yarn: 76),
            PatternInfo(name: "Handy 8 years - woman's S, gauge 4", gauge: 4, size: 7, yarn: 88),
            PatternInfo(name: "Handy woman's M, gauge 4", gauge: 4, size: 7.5, yarn: 104),
            PatternInfo(name: "Handy woman's M-man's S, gauge 4", gauge: 4, size: 8, yarn: 104),
            PatternInfo(name: "Handy man's M, gauge 4", gauge: 4, size: 8.5, yarn: 122),
            PatternInfo(name: "Handy man's L, gauge 4", gauge: 4, size: 9, yarn: 139),
            PatternInfo(name: "Handy 2-4 years, gauge 9", gauge: 9, size: 5.5, yarn: 111),
            PatternInfo(name: "Handy 4-6 years, gauge 9", gauge: 9, size: 6, yarn: 149),
            PatternInfo(name: "Handy 6-8 years, gauge 9", gauge: 9, size: 6.5, yarn: 179),
            PatternInfo(name: "Handy 8 years - woman's S, gauge 9", gauge: 9, size: 7, yarn: 208),
            PatternInfo(name: "Handy woman's M, gauge 9", gauge: 9, size: 7.5, yarn: 246),
            PatternInfo(name: "Handy woman's M-man's S, gauge 9", gauge: 9, size: 8, yarn: 289),
            PatternInfo(name: "Handy man's M, gauge 9", gauge: 9, size: 8.5, yarn: 330),
            PatternInfo(name: "Handy man's L, gauge 9", gauge: 9, size: 9, yarn: 372),
        ]
        
        for test in tests {
            mittens.size = test.size
            mittens.gauge = test.gauge
            mittens.calcYarnRequired()
            
            XCTAssertGreaterThanOrEqual(mittens.yarnNeeded, test.yarn, "\(test.name): Yarn calculated is less than expected")
            //XCTAssertEqualWithAccuracy(Double(mittens.yarnNeeded), Double(test.yarn), accuracy: Double(test.yarn) * 0.2, "\(test.name): Yarn calculated differed more than expected")
            
        }
    }
    // Compare calculated number of balls to representative patterns
    func testBalls() {
        mittens.gaugeUnits = .stsPer4inch
        mittens.sizeUnits = .inches
        mittens.yarnNeededUnits = .yards
        
        let tests = [
            PatternInfo(name: "Interweave Knits, Holiday 2012, Eze Beret", gauge: 20, size: 21, ballSize: 210, balls: 1),
            ]
        for test in tests {
            mittens.size = test.size
            mittens.gauge = test.gauge
            mittens.ballSize = test.ballSize
            mittens.calcYarnRequired()
            
            XCTAssertGreaterThanOrEqual(Int(mittens.ballsNeeded), test.balls, "\(test.name): Yarn calculated is less than expected")
        }
        
    }
}
