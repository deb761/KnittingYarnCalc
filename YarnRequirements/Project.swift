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
    var Gauge:Double = 20.0
    var gaugeUnits:GaugeUnits = GaugeUnits.StsPer4inch
    var thumb:UIImage = UIImage(named:"Sweater")!
    var image:UIImage = UIImage(named:"SweaterImg")!
    var segue = "SweaterSegue"
    
    //private  Class<?> aClass;
    var YarnNeeded:Int = 1000
    var YarnNeededUnits:LongLengthUnits = LongLengthUnits.Meters
    var BallSize:Int = 150
    var BallSizeUnits:LongLengthUnits = LongLengthUnits.Meters
    var BallsNeeded:Int = 4

    // provide a means of defining a project name and image
    init(name:String, thumb:UIImage, image:UIImage, segue:String) {
        self.name = name
        self.image = image
        self.thumb = thumb
        self.segue = segue
    }

    let inches2cm:Double = 2.54;
    let yards2meters:Double = 0.9144;
    
    func calcYarnRequired() {}
    
    // Calculations borrowed from http://www.thedietdiary.com/knittingfiend/tools/EstimatingYardageRectangles.html
    // copyright Lucia Liljegren 2005.
    func calcYarnRequired(siLength:Double, siWidth:Double) {
        var siGauge:Double = Gauge
        
        // First, put values into SI units
        if (gaugeUnits == GaugeUnits.StsPerInch) {
            siGauge *= 4;
        }
        
        var siBallSize:Double = Double(BallSize)
        if (BallSizeUnits == LongLengthUnits.Yards) {
            siBallSize *= yards2meters;
        }
        let stitches:Int = Int(ceil(Gauge * siWidth / 10));
        let rowGauge:Double = Gauge * 1.2;
        let rows:Int = Int(ceil(rowGauge * siLength / 10));
        
        let totalStitches:Int = stitches * (rows + 2); // 2 for cast on and bind off.
        
        let cmPerStitch:Double = 10.0 / Gauge;
        let cmPerRow:Double = 10.0 / rowGauge;
        
        let normalizedCm:Double = sqrt(cmPerStitch * cmPerStitch + cmPerRow * cmPerRow);
        
        let meterFactor:Double = M_PI * 1.02 * 1.02;
        var meters:Double = meterFactor * normalizedCm * Double(totalStitches) / 100;
        // Add 10% for safety
        meters *= 1.1;
        
        // Now convert the yarn required into the desired units
        if (YarnNeededUnits != LongLengthUnits.Meters) {
            YarnNeeded = Int(ceil(meters / yards2meters));
        }
        else {
            YarnNeeded = Int(ceil(meters));
        }
        
        BallsNeeded = Int(ceil(meters / siBallSize));
        
    }
    // Calculate the number of balls needed, taking into account the selected units
    func calcBallsNeeded()
    {
        if (YarnNeededUnits == BallSizeUnits) {
            BallsNeeded = Int(ceil(Double(YarnNeeded) / Double(BallSize)))
        }
        else {
            let yarn:Double = (YarnNeededUnits == LongLengthUnits.Meters) ? Double(YarnNeeded) :
                Double(YarnNeeded) * yards2meters
            let ballMeters:Double = (BallSizeUnits == LongLengthUnits.Meters) ? Double(BallSize) :
                Double(BallSize) * yards2meters
            BallsNeeded = Int(ceil(yarn / ballMeters))
        }
    }

}