//
//  SockTests.swift
//  YarnRequirements
//
//  Created by Deborah Engelmeyer on 6/17/16.
//  Copyright © 2016 The Inquisitive Introvert. All rights reserved.
//

import XCTest
@testable import YarnRequirements

class SockTests: XCTestCase {
    
    var socks = Socks(name: "Socks", thumb: UIImage(named:"Socks")!, image: UIImage(named:"Socks")!)
    
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
        socks.gaugeUnits = .StsPerInch
        socks.sizeUnits = .Euro
        socks.yarnNeededUnits = .Yards
        
        let tests = [
            //
            PatternInfo(name: "Rose & Thorn Socks by Ronni Smith", gauge: 8, size: 38, yarn: 350),
            //
            PatternInfo(name: "Hermione's Everyday Socks by Erica Lueder", gauge: 9, size: 38, yarn: 350),
            // The Handy Knitter's Guide to Yarn Requirements
            PatternInfo(name: "Handy 2-4 years, gauge 5", gauge: 5, size: 24, yarn: 96),
            PatternInfo(name: "Handy 4-8 years, gauge 5", gauge: 5, size: 31, yarn: 138),
            PatternInfo(name: "Handy 8 years - woman's S, gauge 5", gauge: 5, size: 36, yarn: 188),
            PatternInfo(name: "Handy Woman's M, gauge 5", gauge: 5, size: 39, yarn: 224),
            PatternInfo(name: "Handy Woman's L, gauge 5", gauge: 5, size: 42.5, yarn: 252),
            PatternInfo(name: "Handy Man's S, gauge 5", gauge: 5, size: 45, yarn: 279),
            PatternInfo(name: "Handy Man's M, gauge 5", gauge: 5, size: 47, yarn: 310),
            PatternInfo(name: "Handy Man's L, gauge 5", gauge: 5, size: 49, yarn: 348),
            // 2-4 years
            PatternInfo(name: "Handy 2-4 years, gauge 9", gauge: 9, size: 24, yarn: 180),
            // 4-8 years
            PatternInfo(name: "Handy 4-8 years, gauge 9", gauge: 9, size: 31, yarn: 260),
            // 8 years - woman's S
            PatternInfo(name: "Handy 8 years - Woman's S, gauge 9", gauge: 9, size: 36, yarn: 353),
            // Woman's M
            PatternInfo(name: "Handy Woman's M, gauge 9", gauge: 9, size: 39, yarn: 422),
            // Woman's L
            PatternInfo(name: "Handy Woman's L, gauge 9", gauge: 9, size: 42.5, yarn: 475),
            // Man's S
            PatternInfo(name: "Handy Man's S, gauge 9", gauge: 9, size: 45, yarn: 524),
            // Man's M
            PatternInfo(name: "Handy Man's M, gauge 9", gauge: 9, size: 47, yarn: 584),
            // Man's L
            PatternInfo(name: "Handy Man's L, gauge 9", gauge: 9, size: 49, yarn: 654),
        ]
        
        for test in tests {
            socks.size = test.size
            socks.gauge = test.gauge
            socks.calcYarnRequired()
            
            XCTAssertGreaterThanOrEqual(socks.yarnNeeded, test.yarn, "\(test.name): Yarn calculated is less than expected")
            
        }
    }
    // Compare calculated number of balls to representative patterns
    func testBalls() {
        socks.gaugeUnits = .StsPer4inch
        socks.sizeUnits = .Euro
        socks.yarnNeededUnits = .Yards
        
        let tests = [
            PatternInfo(name: "Test 1", gauge: 32, size: 38, ballSize: 200, balls: 2),
        ]
        for test in tests {
            socks.size = test.size
            socks.gauge = test.gauge
            socks.ballSize = test.ballSize
            socks.calcYarnRequired()
            
            XCTAssertGreaterThanOrEqual(Int(ceil(socks.ballsNeeded)), test.balls, "\(test.name): Yarn calculated is less than expected")
        }
        
    }
    
}
