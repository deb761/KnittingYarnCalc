//
//  GlovesTests.swift
//  YarnRequirements
//
//  Created by Deborah Engelmeyer on 6/20/16.
//  Copyright © 2016 The Inquisitive Introvert. All rights reserved.
//

import XCTest
@testable import YarnRequirements

class GlovesTests: XCTestCase {
    
    let gloves = Gloves(name: "Gloves", thumb:UIImage(named:"Gloves")!, image:UIImage(named:"Gloves")!)
    
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
        gloves.gaugeUnits = .StsPerInch
        gloves.sizeUnits = .Inches
        gloves.yarnNeededUnits = .Yards
        
        let tests = [
            PatternInfo(name: "Handy 4-6 years, gauge 5", gauge: 5, size: 6, yarn: 78),
            PatternInfo(name: "Handy 6-8 years, gauge 5", gauge: 5, size: 6.5, yarn: 93),
            PatternInfo(name: "Handy 8 years - woman's S, gauge 5", gauge: 5, size: 7, yarn: 109),
            PatternInfo(name: "Handy woman's M, gauge 5", gauge: 5, size: 7.5, yarn: 126),
            PatternInfo(name: "Handy woman's L-man's S, gauge 5", gauge: 5, size: 8, yarn: 145),
            PatternInfo(name: "Handy man's M, gauge 5", gauge: 5, size: 8.5, yarn: 169),
            PatternInfo(name: "Handy man's L, gauge 5", gauge: 5, size: 9, yarn: 191),
            PatternInfo(name: "Handy 4-6 years, gauge 9", gauge: 9, size: 6, yarn: 146),
            PatternInfo(name: "Handy 6-8 years, gauge 9", gauge: 9, size: 6.5, yarn: 175),
            PatternInfo(name: "Handy 8 years - woman's S, gauge 9", gauge: 9, size: 7, yarn: 205),
            PatternInfo(name: "Handy woman's M, gauge 9", gauge: 9, size: 7.5, yarn: 237),
            PatternInfo(name: "Handy woman's L-man's S, gauge 9", gauge: 9, size: 8, yarn: 272),
            PatternInfo(name: "Handy man's M, gauge 9", gauge: 9, size: 8.5, yarn: 317),
            PatternInfo(name: "Handy man's L, gauge 9", gauge: 9, size: 9, yarn: 359),
            //PatternInfo(name: "Gloves by Erika Knight", gauge: 25.0 / 4.0, size: 7.5, yarn: 284),
            PatternInfo(name: "Gloves No. 207 by Bernhard Ulmann Co.", gauge: 7, size: 8.5, yarn: 180),
            PatternInfo(name: "Gloves for Kids by Lise-Anne Michel", gauge: 18.0 / 4.0, size: 6, yarn: 84),
            //PatternInfo(name: "Basic Gloves - Medium Worsted by Patons", gauge: 5.5, size: 6.5, yarn: 192),
            PatternInfo(name: "Gloves by Sirdar Spinning Ltd.", gauge: 6.5, size: 8.5, yarn: 224),
            PatternInfo(name: "Classic Gloves by Vogue Knitting", gauge: 6.75, size: 8, yarn: 203),
            PatternInfo(name: "Kid's Gloves by Sarah E. White", gauge: 7.25, size: 6, yarn: 88),
            PatternInfo(name: "Kid's Gloves by Sarah E. White", gauge: 7.25, size: 7, yarn: 110),
        ]
        
        for test in tests {
            gloves.size = test.size
            gloves.gauge = test.gauge
            gloves.calcYarnRequired()
            
            XCTAssertGreaterThanOrEqual(gloves.yarnNeeded, test.yarn, "\(test.name): Yarn calculated is less than expected")
            //XCTAssertEqualWithAccuracy(Double(gloves.yarnNeeded), Double(test.yarn), accuracy: Double(test.yarn) * 0.2, "\(test.name): Yarn calculated differed more than expected")
            
        }
    }
    // Compare calculated number of balls to representative patterns
    func testBalls() {
        gloves.gaugeUnits = .StsPer4inch
        gloves.sizeUnits = .Inches
        gloves.yarnNeededUnits = .Yards
        
        let tests = [
            PatternInfo(name: "Kid's Gloves by Sarah E. White", gauge: 29, size: 7, ballSize: 200, balls: 1),
        ]
        for test in tests {
            gloves.size = test.size
            gloves.gauge = test.gauge
            gloves.ballSize = test.ballSize
            gloves.calcYarnRequired()
            
            XCTAssertGreaterThanOrEqual(Int(gloves.ballsNeeded), test.balls, "\(test.name): Yarn calculated is less than expected")
        }
        
    }
}
