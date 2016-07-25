//
//  YarnRequirementsTests.swift
//  YarnRequirementsTests
//
//  Created by Deb on 5/14/16.
//  Copyright © 2016 The Inquisitive Introvert. All rights reserved.
//

import XCTest
@testable import YarnRequirements

class ProjectTests: XCTestCase {
    
    var project:Project!
    let cmLength = 200.0 // cm
    let cmWidth = 30.0 // cm

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // set project to defaults
        project = Project(name: "Base", thumb:UIImage(named:"Blanket")!, image:UIImage(named:"Scarf")!)
        project.calcYarnRequired(cmLength, siWidth: cmWidth)
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testProjectDescriptors() {
        // Verify the correct project name and images are returned
        XCTAssertEqual("Base", project.name, "Project name does not match!")
        XCTAssertEqual(UIImage(named:"Blanket")!, project.thumb, "Thumb image does not match!")
        XCTAssertEqual(UIImage(named:"Scarf")!, project.image, "Larger image does not match!")
    }
    
    func testCalcAreaGaugeInch() {
        // Verify changing the gauge units updates the yarn required
        let yarnReq10 = project.yarnNeeded
        project.gaugeUnits = GaugeUnits.StsPerInch
        project.calcYarnRequired(cmLength, siWidth: cmWidth)
        
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        XCTAssertNotEqual(project.yarnNeeded, yarnReq10, "Yarn Needed did not change when Gauge units changed!")
    }
    
    func testCalcAreaGauge10cm() {
        // Verify changing the gauge units updates the yarn required
        let yarnReq4 = project.yarnNeeded
        project.gaugeUnits = GaugeUnits.StsPer10cm
        project.calcYarnRequired(cmLength, siWidth: cmWidth)
        
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        XCTAssertEqual(project.yarnNeeded, yarnReq4, "Yarn Needed changed when going from sts/4inch to sts/10cm!")
    }
    
    func testCalcAreaGauge4in() {
        // Verify changing the gauge units updates the yarn required
        let yarnReq4 = project.yarnNeeded
        project.gaugeUnits = GaugeUnits.StsPerInch
        project.calcYarnRequired(cmLength, siWidth: cmWidth)
        
        project.gaugeUnits = GaugeUnits.StsPer4inch
        project.calcYarnRequired(cmLength, siWidth: cmWidth)
        
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        XCTAssertEqual(project.yarnNeeded, yarnReq4, "Yarn Needed does not match original sts/4inch!")
    }
    
    func testCalcAreaGaugeChange() {
        // Verify changing the gauge units updates the yarn required
        let yarnReq4 = project.yarnNeeded
        project.gauge = 24
        project.calcYarnRequired(cmLength, siWidth: cmWidth)
        
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        XCTAssertNotEqual(project.yarnNeeded, yarnReq4, "Yarn Needed did not change when gauge changed!")
    }
    
    func testCalcAreaGauge0() {
        // Verify changing the gauge to 0 does not crash
        let yarnReq4 = project.yarnNeeded
        project.gauge = 0
        project.calcYarnRequired(cmLength, siWidth: cmWidth)
        
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        XCTAssertNotEqual(project.yarnNeeded, yarnReq4, "Yarn Needed did not change when gauge set to 0!")
    }
    
    func testCalcAreaWidth0() {
        // Verify changing the width to 0 does not crash
        let yarnReq4 = project.yarnNeeded
        project.calcYarnRequired(cmLength, siWidth: 0)
        
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        XCTAssertNotEqual(project.yarnNeeded, yarnReq4, "Yarn Needed did not change when width set to 0!")
    }
    
    func testCalcAreaLength0() {
        // Verify changing the length to 0 does not crash
        let yarnReq4 = project.yarnNeeded
        project.calcYarnRequired(0, siWidth: cmWidth)
        
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        XCTAssertNotEqual(project.yarnNeeded, yarnReq4, "Yarn Needed did not change when length set to 0!")
    }
    
    func testCalcAreaBallSize0() {
        // Verify changing the ball size to 0 does not crash
        project.ballSize = 0
        project.calcYarnRequired(cmLength, siWidth: cmWidth)
        
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        XCTAssertEqual(project.ballsNeeded, Double.infinity, "Balls Needed did not change to infinity when ball size set to 0!")
    }
    
    func testCalcAreaYarnUnitsYards() {
        // Verify changing the required units updates the yarn required amount
        let yarnReqM = project.yarnNeeded
        project.yarnNeededUnits = LongLengthUnits.Yards
        project.calcYarnRequired(cmLength, siWidth: cmWidth)
        
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        XCTAssertNotEqual(project.yarnNeeded, yarnReqM, "Yarn Needed did not change when units changed to yards!")
    }
    
    func testCalcAreaYarnUnitsMeters() {
        // Verify changing the yarn required units updates the yarn required amount
        project.yarnNeededUnits = LongLengthUnits.Meters
        project.calcYarnRequired(cmLength, siWidth: cmWidth)
        let yarnReqM = project.yarnNeeded
        project.yarnNeededUnits = LongLengthUnits.Yards
        project.calcYarnRequired(cmLength, siWidth: cmWidth)
        
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        XCTAssertNotEqual(project.yarnNeeded, yarnReqM, "Yarn Needed did not change when units changed to yards!")

        project.yarnNeededUnits = LongLengthUnits.Meters
        project.calcYarnRequired(cmLength, siWidth: cmWidth)
        
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        XCTAssertEqual(project.yarnNeeded, yarnReqM, "Yarn Needed does not match when changed back to meters!")
    }
    
    func testCalcAreaBallUnitsYards() {
        // Verify changing the ball size units to yards updates the balls needed for a large project
        // length and width here are inches
        project.ballSizeUnits = LongLengthUnits.Meters
        let length = 60 * Project.inches2cm
        let width = 60 * Project.inches2cm
        project.calcYarnRequired(length, siWidth: width)
        let ballsReqM = project.ballsNeeded
        
        project.ballSizeUnits = LongLengthUnits.Yards
        project.calcYarnRequired(length, siWidth: width)
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        XCTAssertNotEqual(project.ballsNeeded, ballsReqM, "Balls Needed did not change when units changed to yards!")
    }
    
    func testCalcAreaBallUnitsMeters() {
        // Verify changing the ball size units to meters updates the balls needed for a large project
        // length and width here are inches
        project.ballSizeUnits = LongLengthUnits.Yards
        let length = 60 * Project.inches2cm
        let width = 60 * Project.inches2cm
        project.calcYarnRequired(length, siWidth: width)
        let ballsReqY = project.ballsNeeded
        
        project.ballSizeUnits = LongLengthUnits.Meters
        project.calcYarnRequired(length, siWidth: width)
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        XCTAssertNotEqual(project.ballsNeeded, ballsReqY, "Balls Needed did not change when units changed to meters!")
    }
    
    func testCalcAreaBallSize() {
        // Verify changing the ball size updates the balls needed for a large project
        // length and width here are inches
        project.ballSizeUnits = LongLengthUnits.Yards
        let length = 60 * Project.inches2cm
        let width = 60 * Project.inches2cm
        project.calcYarnRequired(length, siWidth: width)
        let ballsReqY = project.ballsNeeded
        
        project.ballSizeUnits = LongLengthUnits.Meters
        project.calcYarnRequired(length, siWidth: width)
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        XCTAssertNotEqual(project.ballsNeeded, ballsReqY, "Yarn Needed did not change when units changed to meters!")
    }
    
    func testCalcYarnReqValuesSi() {
        // Verify calculations are correct using SI units
        project.gaugeUnits = GaugeUnits.StsPer10cm
        project.yarnNeededUnits = LongLengthUnits.Meters
        project.ballSize = 100
        project.ballSizeUnits = LongLengthUnits.Meters
        project.partialBalls = true
        let tests = [
            CalcVar(gauge:1.0, length: 1.0, width: 1.0, yarn: 2, balls: 0.02),
            CalcVar(gauge:4.0, length: 100.0, width: 100.0, yarn: 282, balls: 2.82),
            CalcVar(gauge:6.0, length: 100.0, width: 100.0, yarn: 412, balls: 4.12),
            CalcVar(gauge:8.5, length: 100.0, width: 100.0, yarn: 581, balls: 5.81),
            CalcVar(gauge:12.0, length: 100.0, width: 100.0, yarn: 814, balls: 8.14),
            CalcVar(gauge:16.0, length: 100.0, width: 100.0, yarn: 1086, balls: 10.86),
            CalcVar(gauge:20.0, length: 10.0, width: 10.0, yarn: 15, balls: 0.15),
            CalcVar(gauge:24.0, length: 100.0, width: 100.0, yarn: 1618, balls: 16.18),
            CalcVar(gauge:28.0, length: 100.0, width: 100.0, yarn: 1886, balls: 18.86),
            CalcVar(gauge:38.0, length: 100.0, width: 100.0, yarn: 2557, balls: 25.57),
            ]
        
        for test in tests {
            project.gauge = test.gauge
            project.calcYarnRequired(test.length, siWidth: test.width)
            // Use XCTAssert and related functions to verify your tests produce the correct results.
            XCTAssertEqual(project.yarnNeeded, test.yarn, "Yarn Needed does not match!")

            XCTAssertEqualWithAccuracy(project.ballsNeeded, test.balls, accuracy: 0.01, "Balls Needed does not match!")
        }
   }
    
    func testCalcYarnReqValuesImp() {
        // Verify calculations are correct using SI units
        project.gaugeUnits = GaugeUnits.StsPer4inch
        project.yarnNeededUnits = LongLengthUnits.Yards
        project.ballSize = 100
        project.ballSizeUnits = LongLengthUnits.Yards
        project.partialBalls = true
        let tests = [
            CalcVar(gauge:1.0, length: 1.0, width: 1.0, yarn: 2, balls: 0.02),
            CalcVar(gauge:4.0, length: 100.0, width: 100.0, yarn: 1932, balls: 19.32),
            CalcVar(gauge:6.0, length: 100.0, width: 100.0, yarn: 2879, balls: 28.79),
            CalcVar(gauge:8.0, length: 100.0, width: 100.0, yarn: 3827, balls: 38.27),
            CalcVar(gauge:12.0, length: 100.0, width: 100.0, yarn: 5715, balls: 57.15),
            CalcVar(gauge:16.0, length: 100.0, width: 100.0, yarn: 7609, balls: 76.09),
            CalcVar(gauge:20.0, length: 10.0, width: 10.0, yarn: 99, balls: 0.99),
            CalcVar(gauge:24.0, length: 40.0, width: 40.0, yarn: 1829, balls: 18.29),
            CalcVar(gauge:28.0, length: 40.0, width: 40.0, yarn: 2135, balls: 21.35),
            CalcVar(gauge:38.0, length: 40.0, width: 40.0, yarn: 2897, balls: 28.97),
            ]
        
        for test in tests {
            project.gauge = test.gauge
            project.calcYarnRequired(test.length * Project.inches2cm, siWidth: test.width * Project.inches2cm)
            // Use XCTAssert and related functions to verify your tests produce the correct results.
            XCTAssertEqual(project.yarnNeeded, test.yarn, "Yarn Needed does not match!")
            
            XCTAssertEqualWithAccuracy(project.ballsNeeded, test.balls, accuracy: 0.01, "Balls Needed does not match!")
        }
    }
    // Verify that balls needed is infinity when ball size is 0
    func testBallsNeededBallSize0() {
        // Verify the app doesn't crash with a ball size of 0
        project.ballSize = 0
        project.calcballsNeeded()
        
        XCTAssertEqual(project.ballsNeeded, Double.infinity, "Balls needed not infinity with ball size 0")
    }
    
    // Verify that balls needed is calculated correctly when yarnNeeded and ballSize are both in meters
    func testBallsNeededMeters() {
        project.yarnNeededUnits = LongLengthUnits.Meters
        project.ballSize = 111
        project.ballSizeUnits = LongLengthUnits.Meters
       
        let tests = [0, 1234, 2345, 3456, 7890]
        
        for test in tests {
            project.partialBalls = true
            project.yarnNeeded = test
            let balls = Double(test) / Double(project.ballSize)
            project.calcballsNeeded()
            
            XCTAssertEqualWithAccuracy(project.ballsNeeded, balls, accuracy: 0.01,
                                       "Balls needed does not match expected")
            // retest with whole balls
            project.partialBalls = false
            project.calcballsNeeded()
            
            XCTAssertEqualWithAccuracy(project.ballsNeeded, ceil(balls), accuracy: 0.01,
                                       "Balls needed does not match expected")
        }
    }
    // Verify that balls needed is calculated correctly when yarnNeeded and ballSize are both in yards
    func testBallsNeededYards() {
        project.yarnNeededUnits = LongLengthUnits.Yards
        project.ballSize = 111
        project.ballSizeUnits = LongLengthUnits.Yards
        
        let tests = [0, 1234, 2345, 3456, 7890]
        
        for test in tests {
            project.partialBalls = true
            project.yarnNeeded = test
            let balls = Double(test) / Double(project.ballSize)
            project.calcballsNeeded()
            
            XCTAssertEqualWithAccuracy(project.ballsNeeded, balls, accuracy: 0.01,
                                       "Balls needed does not match expected")
            // retest with whole balls
            project.partialBalls = false
            project.calcballsNeeded()
            
            XCTAssertEqualWithAccuracy(project.ballsNeeded, ceil(balls), accuracy: 0.01,
                                       "Balls needed does not match expected")
        }
    }
    // Verify that balls needed is calculated correctly when yarnNeeded is in yards and ballSize is in meters
    func testBallsNeededMixed() {
        project.yarnNeededUnits = LongLengthUnits.Yards
        project.ballSize = 111
        project.ballSizeUnits = LongLengthUnits.Meters
        
        let tests = [0, 1234, 2345, 3456, 7890]
        
        for test in tests {
            project.partialBalls = true
            project.yarnNeeded = test
            let balls = Double(test) * Project.yards2meters / Double(project.ballSize)
            project.calcballsNeeded()
            
            XCTAssertEqualWithAccuracy(project.ballsNeeded, balls, accuracy: 0.01,
                                       "Balls needed does not match expected")
            // retest with whole balls
            project.partialBalls = false
            project.calcballsNeeded()
            
            XCTAssertEqualWithAccuracy(project.ballsNeeded, ceil(balls), accuracy: 0.01,
                                       "Balls needed does not match expected")
        }
    }
    // Verify that balls needed is calculated correctly when yarnNeeded is in meters and ballSize is in yards
    func testBallsNeededMixed2() {
        project.yarnNeededUnits = LongLengthUnits.Meters
        project.ballSize = 123
        project.ballSizeUnits = LongLengthUnits.Yards
        
        let tests = [0, 1234, 2345, 3456, 7890]
        
        for test in tests {
            project.partialBalls = true
            project.yarnNeeded = test
            let balls = Double(test) / (Double(project.ballSize) * Project.yards2meters)
            project.calcballsNeeded()
            
            XCTAssertEqualWithAccuracy(project.ballsNeeded, balls, accuracy: 0.01,
                                       "Balls needed does not match expected")
            // retest with whole balls
            project.partialBalls = false
            project.calcballsNeeded()
            
            XCTAssertEqualWithAccuracy(project.ballsNeeded, ceil(balls), accuracy: 0.01,
                                       "Balls needed does not match expected")
        }
    }
    

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock {
            // Put the code you want to measure the time of here.
        }
    }
    
}
class CalcVar {
    var gauge:Double = 1.0
    var length:Double = 0.0
    var width:Double = 0.0
    var yarn:Int = 0
    var balls:Double = 0.0
    
    init(gauge mgauge:Double, length:Double, width:Double, yarn:Int, balls:Double) {
        self.gauge = mgauge
        self.length = length
        self.width = width
        self.yarn = yarn
        self.balls = balls
    }
}
