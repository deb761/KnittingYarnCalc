//
//  YarnWeight.swift
//  YarnRequirements
//
//  Created by Deb on 5/14/16.
//  Copyright © 2016 The Inquisitive Introvert. All rights reserved.
//

import Foundation
// Define a class for yarn weight data
public class YarnWeight
{
    var name: String
    // suggested needle sizes in US and international units
    var needles: String
    // Stitches per 4" or 10cm
    var gauge: String
    // Windings per inch
    var wpi: String
    // Density per 50 gm for wool
    var density: String
    
    // initialize the yarn weight values
    init(name: String, needles: String, gauge: String, wpi: String, density: String)
    {
        self.name = name;
        self.needles = needles;
        self.gauge = gauge;
        self.wpi = wpi;
        self.density = density
    }
}
