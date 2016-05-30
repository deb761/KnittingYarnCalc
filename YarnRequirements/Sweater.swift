//
//  Sweater.swift
//  YarnRequirements
//
//  Created by Deb on 5/22/16.
//  Copyright © 2016 The Inquisitive Introvert. All rights reserved.
//

import Foundation
import UIKit

// self class defines the parameters and performs the calculations for a sweater project
class Sweater : Project {
    // Finished size around the chest
    var ChestSize:Double = 40.0;
    // Units for chest size
    var ChestUnits:ShortLengthUnits = ShortLengthUnits.Inches;
    
    // provide a means of defining a project name and image
    override init(name:String, thumb:UIImage, image:UIImage, control:String) {
        super.init(name: name, thumb: thumb, image: image, control: control)
        controller = SweaterController()
    }
    
    // A class to hold each end of our interpolation table
    class SizeData {
        // Finished size around the chest
        var Chest:Double = 81
        // Meters needed with 32 sts per 10cm
        var Sts32:Double = 1500
        // Meters needed with 18 sts per 10cm
        var Sts18:Double = 950
        init (chest:Double, sts32:Double, sts18:Double)
        {
            self.Chest = chest
            self.Sts32 = sts32
            self.Sts18 = sts18
        }
    }
    // Small miss end of the table
    let smallMiss:SizeData = SizeData(chest: 81, sts32: 1500, sts18: 950)
    // Large miss end of the table
    let largeMiss:SizeData = SizeData(chest: 101, sts32: 1700, sts18: 1200)
    
    // Calculate the yarn required for an adult size sweater
    override func calcYarnRequired()
    {
        var gauge:Double = Gauge
        var chest:Double = ChestSize
        // First, put values into SI units
        if (gaugeUnits == GaugeUnits.StsPerInch) {
            gauge *= 4
        }
        if (ChestUnits == ShortLengthUnits.Inches) {
            chest *= inches2cm
        }
        var ballSize:Double = Double(BallSize)
        if (BallSizeUnits == LongLengthUnits.Yards) {
            ballSize *= yards2meters;
        }
        // See where the selected gauge falls between our two gauges
        let gratio:Double = (gauge - 18) / (gauge - 32);
        // See how many meters are needed for self gauge for our two sizes
        let smallMeters:Double = gratio * (smallMiss.Sts32 - smallMiss.Sts18) + smallMiss.Sts18;
        let bigMeters:Double = gratio * (largeMiss.Sts32 - largeMiss.Sts18) + largeMiss.Sts18;
        
        // Now, see where the selected size is with respect to the smallMiss and largeMiss sizes
        let sRatio:Double = (chest - smallMiss.Chest) / (largeMiss.Chest - smallMiss.Chest);
        // Finally, use the size ratio to get the meters of yarn needed
        let meters:Double = sRatio * (bigMeters - smallMeters) + smallMeters;
        
        // Now convert the yarn required into the desired units
        if (YarnNeededUnits != LongLengthUnits.Meters) {
            YarnNeeded = Int(ceil(meters / yards2meters))
        }
        else {
            YarnNeeded = Int(ceil(meters))
        }
        
        BallsNeeded = Int(ceil(meters / ballSize))
        
    }
}

