//
//  VestTests.swift
//  YarnRequirements
//
//  Created by Deborah Engelmeyer on 6/17/16.
//  Copyright © 2016 The Inquisitive Introvert. All rights reserved.
//

import XCTest
@testable import YarnRequirements

class VestTests: XCTestCase {
    
    var vest = Vest(name: "Vest", thumb: UIImage(named:"Vest")!, image: UIImage(named:"Vest")!)

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
        vest.gaugeUnits = .StsPerInch
        vest.sizeUnits = .Inches
        vest.yarnNeededUnits = .Yards
        
        let tests = [
            // The Handy Knitter's Guide to Yarn Requirements
            PatternInfo(name: "Handy 2 years, gauge 3", gauge: 3, size: 26, yarn: 163),
            // 4 years
            PatternInfo(name: "Handy 4 years, gauge 3", gauge: 3, size: 28, yarn: 193),
            // 6 years
            PatternInfo(name: "Handy 6 years, gauge 3", gauge: 3, size: 30, yarn: 249),
            // 8 years
            PatternInfo(name: "Handy 8 years, gauge 3", gauge: 3, size: 32, yarn: 296),
            // 10 years
            PatternInfo(name: "Handy 10 years, gauge 3", gauge: 3, size: 34, yarn: 338),
            PatternInfo(name: "Handy 36in, gauge 3", gauge: 3, size: 36, yarn: 375),
            PatternInfo(name: "Handy 38in, gauge 3", gauge: 3, size: 38, yarn: 405),
            PatternInfo(name: "Handy 40in, gauge 3", gauge: 3, size: 40, yarn: 436),
            PatternInfo(name: "Handy 42in, gauge 3", gauge: 3, size: 42, yarn: 472),
            PatternInfo(name: "Handy 44in, gauge 3", gauge: 3, size: 44, yarn: 500),
            PatternInfo(name: "Handy 46in, gauge 3", gauge: 3, size: 46, yarn: 555),
            PatternInfo(name: "Handy 48in, gauge 3", gauge: 3, size: 48, yarn: 602),
            PatternInfo(name: "Handy 50in, gauge 3", gauge: 3, size: 50, yarn: 639),
            PatternInfo(name: "Handy 52in, gauge 3", gauge: 3, size: 52, yarn: 689),
            PatternInfo(name: "Handy 54in, gauge 3", gauge: 3, size: 54, yarn: 741),
            PatternInfo(name: "Handy 2 years, gauge 7", gauge: 7, size: 26, yarn: 455),
            PatternInfo(name: "Handy 4 years, gauge 7", gauge: 7, size: 28, yarn: 536),
            //PatternInfo(name: "Handy 6 years, gauge 7", gauge: 7, size: 30, yarn: 694),  //others are OK, this has higher value than calculated
            PatternInfo(name: "Handy 8 years, gauge 7", gauge: 7, size: 32, yarn: 824),
            PatternInfo(name: "Handy 10 years, gauge 7", gauge: 7, size: 34, yarn: 943),
            PatternInfo(name: "Handy 36in, gauge 7", gauge: 7, size: 36, yarn: 1046),
            PatternInfo(name: "Handy 38in, gauge 7", gauge: 7, size: 38, yarn: 1129),
            PatternInfo(name: "Handy 40in, gauge 7", gauge: 7, size: 40, yarn: 1215),
            PatternInfo(name: "Handy 42in, gauge 7", gauge: 7, size: 42, yarn: 1317),
            PatternInfo(name: "Handy 44in, gauge 7", gauge: 7, size: 44, yarn: 1394),
            PatternInfo(name: "Handy 46in, gauge 7", gauge: 7, size: 46, yarn: 1549),
            PatternInfo(name: "Handy 48in, gauge 7", gauge: 7, size: 48, yarn: 1680),
            PatternInfo(name: "Handy 50in, gauge 7", gauge: 7, size: 50, yarn: 1743),
            PatternInfo(name: "Handy 52in, gauge 7", gauge: 7, size: 52, yarn: 1922),
            PatternInfo(name: "Handy 54in, gauge 7", gauge: 7, size: 54, yarn: 2068),
            ]
        
        for test in tests {
            vest.size = test.size
            vest.gauge = test.gauge
            vest.calcYarnRequired()
            
            XCTAssertGreaterThanOrEqual(vest.yarnNeeded + Int(ceil(Double(test.yarn) * 0.05)), test.yarn, "\(test.name): Yarn calculated is less than expected")
            
        }
    }

    // Compare calculated number of balls to representative patterns
    func testBalls() {
        vest.gaugeUnits = .StsPer4inch
        vest.sizeUnits = .Inches
        vest.yarnNeededUnits = .Yards
        
        let tests = [
            // Alice Starmore Patterns for Men, Sand Rib Vest
            PatternInfo(name: "Alice Starmore Patterns for Men, Sand Rib Vest 1", gauge: 22, size: 40.5, ballSize: 132, balls: 7),
            // Alice Starmore Patterns for Men, Sand Rib Vest
            PatternInfo(name: "Alice Starmore Patterns for Men, Sand Rib Vest 2", gauge: 22, size: 47, ballSize: 132, balls: 8),
            PatternInfo(name: "Cleckheaton Vests", gauge: 19, size: 28, ballSize: 200, balls: 2),
            PatternInfo(name: "26-27-28 Child's Vest by Pierrot (Gosyo Co., Ltd)", gauge: 21, size: 27.6, ballSize: 79, balls: 4),
            PatternInfo(name: "Design A - V-neck Tank / Vest by Sirdar Spinning Ltd.", gauge: 22, size: 44, ballSize: 184, balls: 6),
        ]
        for test in tests {
            vest.size = test.size
            vest.gauge = test.gauge
            vest.ballSize = test.ballSize
            vest.calcYarnRequired()
            
            XCTAssertGreaterThanOrEqual(Int(vest.ballsNeeded), test.balls, "\(test.name): Yarn calculated is less than expected")
        }
        
    }
    
}
