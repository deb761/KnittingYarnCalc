//
//  YarnWeight.swift
//  YarnRequirements
//
//  Created by Deb on 5/14/16.
//  Copyright © 2016 The Inquisitive Introvert. All rights reserved.
//

import Foundation
// Define a class for yarn weight data
open class YarnWeight
{
    var name: String
    // suggested needle sizes in US and international units
    var needles: String
    // Stitches per 4" or 10cm
    var gauge: Int
    var gaugeHigh: Int
    // Windings per inch
    var wpi: Int
    var wpiHigh: Int
    // Density per 50 gm for wool
    var length: Int
    // ball weight in grams
    var weight: Int
    
    // initialize the yarn weight values
    init(name: String, needles: String, gauge: Int, gaugeHigh: Int = 0, wpi: Int, wpiHigh: Int = 0, length: Int, weight: Int)
    {
        self.name = name
        self.needles = needles
        self.gauge = gauge
        self.gaugeHigh = gaugeHigh
        self.wpi = wpi
        self.wpiHigh = wpiHigh
        self.length = length
        self.weight = weight
    }
}
