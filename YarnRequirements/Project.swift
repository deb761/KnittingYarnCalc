//
//  Project.swift
//  YarnRequirements
//
//  Created by Deb on 5/22/16.
//  Copyright © 2016 The Inquisitive Introvert. All rights reserved.
//

import Foundation
import UIKit

enum GaugeUnits : Int {
    case StsPerInch = 0, StsPer4inch, StsPer10cm
}
enum ShortLengthUnits: Int {
    case Inches = 0, CM
}
enum LongLengthUnits: Int {
    case Yards = 0, Meters
}
// Base class for a project
class Project {
    var name:String = "Project"
    var gauge:Double = 20.0
    var gaugeUnits:GaugeUnits = GaugeUnits.StsPer4inch
    var thumb:UIImage = UIImage(named:"Sweater")!
    var image:UIImage = UIImage(named:"SweaterImg")!
    //var controlName:String?
    var controller:BaseProjectController!
    
    // The yarn needed using yarnNeededUnits for the project
    var yarnNeeded:Int = 1000
    // The units for yarn needed
    var yarnNeededUnits:LongLengthUnits = LongLengthUnits.Meters
    // The ball size in ballSizeUnits
    var ballSize:Int = 150
    // The units for ball size
    var ballSizeUnits:LongLengthUnits = LongLengthUnits.Meters
    // The number of balls needed
    var ballsNeeded:Double = 4
    // True when the user wants to see whole and partial balls needed
    var partialBalls:Bool = false

    // provide a means of defining a project name and image
    init(name:String, thumb:UIImage, image:UIImage) {
        self.name = name
        self.image = image
        self.thumb = thumb
        self.controller = BaseProjectController()
        calcYarnRequired()
    }

    static let inches2cm:Double = 2.54;
    static let yards2meters:Double = 0.9144;
    
    func calcYarnRequired() {}
    
    // Calculations borrowed from http://www.thedietdiary.com/knittingfiend/tools/EstimatingYardageRectangles.html
    // copyright Lucia Liljegren 2005.
    func calcYarnRequired(siLength:Double, siWidth:Double) {
        
        guard gauge > 0 else {
            yarnNeeded = 0
            ballsNeeded = 0
            return
        }
        var siGauge:Double = gauge
        
        // First, put values into SI units
        if (gaugeUnits == GaugeUnits.StsPerInch) {
            siGauge *= 4;
        }
        
        // Change to stitches per cm
        siGauge /= 10
        
        var siballSize:Double = Double(ballSize)
        if (ballSizeUnits == LongLengthUnits.Yards) {
            siballSize *= Project.yards2meters;
        }
        let stitches:Int = Int(ceil(siGauge * siWidth));
        let rowGauge:Double = siGauge * 1.2;
        let rows:Int = Int(ceil(rowGauge * siLength));
        
        let totalStitches:Int = stitches * (rows + 2); // 2 for cast on and bind off.
        
        let cmPerStitch:Double = 1.0 / siGauge;
        let cmPerRow:Double = 1.0 / rowGauge;
        
        let normalizedCm:Double = sqrt(cmPerStitch * cmPerStitch + cmPerRow * cmPerRow);
        
        let loopFactor:Double = M_PI * 1.02 * 1.02;
        var meters:Double = loopFactor * normalizedCm * Double(totalStitches) / 100;
        // Add 10% for safety
        meters *= 1.1;
        
        // Now convert the yarn required into the desired units
        if (yarnNeededUnits != LongLengthUnits.Meters) {
            yarnNeeded = Int(ceil(meters / Project.yards2meters));
        }
        else {
            yarnNeeded = Int(ceil(meters));
        }
        
        ballsNeeded = meters / siballSize
        
        if !partialBalls {
            ballsNeeded = ceil(ballsNeeded)
        }
        
    }
    // Calculate the number of balls needed, taking into account the selected units
    func calcballsNeeded()
    {
        if (yarnNeededUnits == ballSizeUnits) {
            ballsNeeded = Double(yarnNeeded) / Double(ballSize)
        }
        else {
            let yarn:Double = (yarnNeededUnits == LongLengthUnits.Meters) ? Double(yarnNeeded) :
                Double(yarnNeeded) * Project.yards2meters
            let ballMeters:Double = (ballSizeUnits == LongLengthUnits.Meters) ? Double(ballSize) :
                Double(ballSize) * Project.yards2meters
            ballsNeeded = yarn / ballMeters
        }

        if !partialBalls {
            ballsNeeded = ceil(ballsNeeded)
        }
    }

}