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
    case stsPerInch = 0, stsPer4inch, stsPer10cm
}
enum ShortLengthUnits: Int {
    case inches = 0, cm
}
enum LongLengthUnits: Int {
    case yards = 0, meters
}
// Base class for a project
class Project {
    // name of the plist for this project
    var plist:String = "project"
    // settings for the project.
    var defaults:[String:AnyObject] = [:]  //our data
    // name of the project type shown to the user
    var name:String = "Project"
    var thumb:UIImage = UIImage(named:"Sweater")!
    var image:UIImage = UIImage(named:"SweaterImg")!
    var controller:BaseProjectController!
    
    let defs = UserDefaults.standard

    // guage of the project
    var gauge:Double {
        get {
            return defs.doubleForKey("\(name)-gauge", def: defaults["gauge"] as! Double)
        }
        set {
            defs.set(newValue, forKey: "\(name)-gauge")
        }
    }
    // units for the gauge
    var gaugeUnits:GaugeUnits {
        get {
            return defs.gaugeUnitsForKey("\(name)-gaugeUnits", def: GaugeUnits(rawValue: defaults["gaugeUnits"] as! Int)!)
        }
        set {
            defs.set(newValue.rawValue, forKey: "\(name)-gaugeUnits")
        }
    }
    // The units for yarn needed
    var yarnNeededUnits:LongLengthUnits {
        get {
            return defs.longLengthUnitsForKey("\(name)-yarnNeededUnits",
                                              def: LongLengthUnits(rawValue: defaults["yarnNeededUnits"] as! Int)!)
        }
        set {
            defs.set(newValue.rawValue, forKey: "\(name)-yarnNeededUnits")
        }
    }
    // The ball size in ballSizeUnits
    var ballSize:Int {
        get {
            return defs.integerForKey("\(name)-ballSize", def: defaults["ballSize"] as! Int)
        }
        set {
            defs.set(newValue, forKey: "\(name)-ballSize")
        }
    }
    // The units for ball size
    var ballSizeUnits:LongLengthUnits {
        get {
            return defs.longLengthUnitsForKey("\(name)-ballSizeUnits",
                                              def: LongLengthUnits(rawValue: defaults["ballSizeUnits"] as! Int)!)
        }
        set {
            defs.set(newValue.rawValue, forKey: "\(name)-ballSizeUnits")
        }
    }
    // True when the user wants to see whole and partial balls needed
    var partialBalls:Bool {
        get {
            return defs.bool(forKey: "\(name)-partialBalls")
        }
        set {
            defs.set(newValue, forKey: "\(name)-partialBalls")
        }
    }
    
    // The yarn needed using yarnNeededUnits for the project
    var yarnNeeded:Int = 1000
    // The number of balls needed
    var ballsNeeded:Double = 4

    // provide a means of defining a project name and image
    init(name:String, thumb:UIImage, image:UIImage) {
        self.name = name
        self.image = image
        self.thumb = thumb
        self.controller = BaseProjectController()
        /*defaults = [ "gauge" : 20.0, "gaugeUnits" : GaugeUnits.StsPer4inch.rawValue, "yarnNeededUnits" : LongLengthUnits.Meters.rawValue,
                     "ballSize" : 150, "ballSizeUnits" : LongLengthUnits.Meters.rawValue, "partialBalls" : false ]*/
        readPlist()
    }
    // Read the plist for this project and fill in the settings
    func readPlist() {
        var format = PropertyListSerialization.PropertyListFormat.xml //format of the property list
        let code = name.lowercased() + "-plist"
        let root = NSLocalizedString(code, value: name + "-im", comment: "Defaults for the project")
        let plistPath:String? = Bundle.main.path(forResource: root, ofType: "plist")!
        let plistXML = FileManager.default.contents(atPath: plistPath!)!
        do {
            defaults = try PropertyListSerialization.propertyList(from: plistXML, options: .mutableContainersAndLeaves, format: &format)
                as! [String:AnyObject]
        }
        catch {
            print("Error reading plist: \(error), format: \(format)")
        }
    }

    static let inches2cm:Double = 2.54;
    static let yards2meters:Double = 0.9144;
    
    func calcYarnRequired() {}
    
    // Calculate the yarn required for a piece of knitted fabric with length and width in cm
    func calcYarnRequired(_ siLength:Double, siWidth:Double) {
        
        guard gauge > 0 else {
            yarnNeeded = 0
            ballsNeeded = 0
            return
        }
        var siGauge:Double = gauge
        
        // First, put values into SI units
        if (gaugeUnits == GaugeUnits.stsPerInch) {
            siGauge *= 4;
        }
        
        // Change to stitches per cm
        siGauge /= 10
        
        var siballSize:Double = Double(ballSize)
        if (ballSizeUnits == LongLengthUnits.yards) {
            siballSize *= Project.yards2meters;
        }
        let stitches:Int = Int(ceil(siGauge * siWidth));
        let rowGauge:Double = siGauge * 1.5;
        let rows:Int = Int(ceil(rowGauge * siLength));
        
        let totalStitches:Int = stitches * (rows + 2); // 2 for cast on and bind off.
        
        // calculate meters and add 20%
        let meters = getStitchLength(siGauge, cmWidth: siWidth, cmLength: siLength) * Double(totalStitches) * 1.2
        
        // Now convert the yarn required into the desired units
        if (yarnNeededUnits != LongLengthUnits.meters) {
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
    // Compute the length of a stitch in m, treating the row of stitches as a helix
    fileprivate func getStitchLength(_ cmGauge:Double, cmWidth:Double, cmLength:Double) -> Double {
        let stitchWidth = 1.0 / cmGauge
        let stitchCir = M_PI * stitchWidth
        // The stitch actually goes halfway into the neighboring stitch on each side
        let span = 2 * stitchWidth
        // use equation to calculate helical length, where the diameter is the stitchWidth and the
        // length is twice the stitchWidth, and convert to meters
        return sqrt(span * span + stitchCir * stitchCir) / 100.0
    }
    // Calculate the number of balls needed, taking into account the selected units
    func calcballsNeeded()
    {
        if (yarnNeededUnits == ballSizeUnits) {
            ballsNeeded = Double(yarnNeeded) / Double(ballSize)
        }
        else {
            let yarn:Double = (yarnNeededUnits == LongLengthUnits.meters) ? Double(yarnNeeded) :
                Double(yarnNeeded) * Project.yards2meters
            let ballMeters:Double = (ballSizeUnits == LongLengthUnits.meters) ? Double(ballSize) :
                Double(ballSize) * Project.yards2meters
            ballsNeeded = yarn / ballMeters
        }

        if !partialBalls {
            ballsNeeded = ceil(ballsNeeded)
        }
    }

}
