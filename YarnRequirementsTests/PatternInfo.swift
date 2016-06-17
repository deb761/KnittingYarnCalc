//
//  PatternInfo.swift
//  YarnRequirements
//
//  Created by Deborah Engelmeyer on 6/16/16.
//  Copyright © 2016 The Inquisitive Introvert. All rights reserved.
//

import Foundation
// Parameters to use in pattern comparison tests
struct PatternInfo {
    var gauge:Double = 3
    var width:Double = 6
    var length:Double = 40
    var yarn:Int = 0
    var ballSize = 0
    var balls:Int = 0
    // init the structure with certain values
    init(gauge:Double, width:Double, length:Double, yarn:Int) {
        self.gauge = gauge
        self.width = width
        self.length = length
        self.yarn = yarn
    }
    // init the struct with paremeters for balls check
    init(gauge:Double, width:Double, length:Double, ballSize:Int, balls:Int) {
        self.gauge = gauge
        self.width = width
        self.length = length
        self.ballSize = ballSize
        self.balls = balls
    }
}
