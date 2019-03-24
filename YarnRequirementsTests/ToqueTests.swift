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
        toque.gaugeUnits = .stsPerInch
        toque.sizeUnits = .inches
        toque.yarnNeededUnits = .yards
        
        let tests = [
            // Lion Brand site yardage estimates
            PatternInfo(name: "Handy preemie, gauge 3", gauge: 3, size: 15, yarn: 38),
            PatternInfo(name: "Handy 0-6 months, gauge 3", gauge: 3, size: 16.5, yarn: 47),
            // http://stitcheryprojects.com/2011/03/21/basic-baby-hat/ size 12
            PatternInfo(name: "Basic baby hat sample, 12 month, gauge 3", gauge: 3, size: 18.5, yarn: 60),
            // http://stitcheryprojects.com/2011/03/21/basic-baby-hat/ size Toddler
            PatternInfo(name: "Basic baby hat sample, toddler, gauge 3", gauge: 3, size: 20, yarn: 70),
            PatternInfo(name: "Basic baby hat sample, youth estimate, gauge 3", gauge: 3, size: 21, yarn: 80),
            PatternInfo(name: "My Favorite Ribbed Hat, gauge 4.25", gauge: 4.25, size: 24, yarn: 138),
            PatternInfo(name: "Basic baby hat sample, gauge 9", gauge: 9, size: 12, yarn: 87),
            //PatternInfo(name: "Handy 0-6 months, gauge 9", gauge: 9, size: 16.5, yarn: 158),
            //PatternInfo(name: "Handy 6-18 months, gauge 9", gauge: 9, size: 18.5, yarn: 229),
            //PatternInfo(name: "Handy 18 months - 4 years, gauge 9", gauge: 9, size: 20, yarn: 296),
            //PatternInfo(name: "Handy 4 years - adult S, gauge 9", gauge: 9, size: 21, yarn: 361), //other calculations are greater, most >20% more
            //PatternInfo(name: "Handy adult M-L, gauge 9", gauge: 9, size: 23, yarn: 441), //others calculations are greater
        ]
        
        for test in tests {
            toque.size = test.size
            toque.gauge = test.gauge
            toque.calcYarnRequired()
            
            XCTAssertGreaterThanOrEqual(toque.yarnNeeded, test.yarn, "\(test.name): Yarn calculated is less than expected")
            XCTAssertEqual(Double(toque.yarnNeeded), Double(test.yarn), accuracy: Double(test.yarn) * 0.1,
                           "\(test.name): Yarn calculated is more than 10% off from expected")
            
        }
    }
    // Compare calculated number of balls to representative patterns
    func testBalls() {
        toque.gaugeUnits = .stsPer4inch
        toque.sizeUnits = .inches
        toque.yarnNeededUnits = .yards
        
        let tests = [
            // I knitted this one myself, and only needed about about 100 yds (I did not make the pom-pom, but that is < 50 yds
            PatternInfo(name: "Stitch Mountain, Variegated Hat", gauge: 17, size: 22, ballSize: 151, balls: 1),
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
            
            XCTAssertGreaterThanOrEqual(Int(ceil(toque.ballsNeeded)), test.balls, "\(test.name): Balls needed are less than expected")
        }
        
    }
}
