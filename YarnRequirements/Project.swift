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
enum WholePartial: Int {
    case whole = 0, partial
}
// Base class for a project
class Project {
    // name of the plist for this project
    var plist:String = "project"
    // settings for the project.
    var defaults:[String:AnyObject] = [:]  //our data
    // name of the project type shown to the user
    var name:String = "Project"
    var image:UIImage = UIImage(named:"SweaterImg")!
    var controller:ProjectController!
    
    let defs = UserDefaults.standard

    var gaugeDimension: Dimension<Double, GaugeUnits>!
    var ballSizeDimension: Dimension<Int, LongLengthUnits>!
    var yarnDimension: Dimension<Int, LongLengthUnits>!
    var ballsDimension: Dimension<Double, WholePartial>!
    
    // guage of the project
    var gauge:Double {
        get {
            return gaugeDimension.value
        }
        set {
            gaugeDimension.value = newValue
        }
    }
    // units for the gauge
    var gaugeUnits:GaugeUnits {
        get {
            return gaugeDimension.unit
        }
        set {
            gaugeDimension.unit = newValue
        }
    }
    // The units for yarn needed
    var yarnNeededUnits:LongLengthUnits {
        get {
            return yarnDimension.unit
        }
        set {
            yarnDimension.unit = newValue
        }
    }
    // The ball size in ballSizeUnits
    var ballSize:Int {
        get {
            return ballSizeDimension.value
        }
        set {
            ballSizeDimension.value = newValue
        }
    }
    // The units for ball size
    var ballSizeUnits:LongLengthUnits {
        get {
            return ballSizeDimension.unit
        }
        set {
            ballSizeDimension.unit = newValue
        }
    }
    // True when the user wants to see whole and partial balls needed
    var partialBalls:WholePartial {
        get {
            return ballsDimension.unit
        }
        set {
            ballsDimension.unit = newValue
        }
    }
    
    // The yarn needed using yarnNeededUnits for the project
    var yarnNeeded:Int {
        get {
            return yarnDimension.value
        }
        set {
            yarnDimension.value = newValue
        }
    }
    // The number of balls needed
    var ballsNeeded:Double {
        get {
            return ballsDimension.value
        }
        set {
            ballsDimension.value = newValue
        }
    }

    let guageText = [NSLocalizedString("sts/inch", value: "sts/inch", comment: "Stitches per inch to determine yarn gauge"),
                     NSLocalizedString("sts/4inch", value: "sts/4inch", comment: "Stitches per 4 inches to determine yarn gauge"),
                     NSLocalizedString("sts/10cm", value: "sts/10cm", comment: "Stitches per 10 cm to determine yarn gauge")]
    
    let ballText = [NSLocalizedString("whole", value: "Whole", comment: "A whole ball of yarn"),
                    NSLocalizedString("partial", value: "Partial", comment: "A partial ball of yarn")]
    
    let longText = [NSLocalizedString("yards", value: "yards", comment: "Short string for picker that indicates using yards for units of measure"),
                    NSLocalizedString("meters", value: "meters", comment: "Short string for picker that indicates using meters for units of measure")]
    
    let shortText = [NSLocalizedString("inches", value: "inches", comment: "Short string for picker that indicates using inches for units"),
                     NSLocalizedString("cm", value: "cm", comment: "Short string for picker that indicates using cm for units")]

    var dimensions:[String : DimensionProtocol]!
    var dimensionOrder:[String] = ["gauge", "yarn", "ballSize", "balls"]

    // provide a means of defining a project name and image
    init(name:String, image:UIImage) {
        self.name = name
        self.image = image
        self.controller = ProjectController()

        readPlist()

        // set dimensions
        gaugeDimension = Dimension<Double, GaugeUnits>(key: "gauge", projectName: name, name: NSLocalizedString("gauge", value: "Gauge", comment: "Density of knitted stitches per inch or cm"), unitNames: guageText, defaults: defaults)
        yarnDimension = Dimension<Int, LongLengthUnits>(key: "yarn", projectName: name, name: NSLocalizedString("yarn-req-label", value: "Yarn Req",
                                                                                                                comment: "Label next to field showing how much yarn is estimated for a project; needs to be short"), unitNames: longText, defaults: defaults)
        ballSizeDimension = Dimension<Int, LongLengthUnits>(key: "ballSize", projectName: name, name: NSLocalizedString("ball-size", value: "Ball Size", comment: "Length of yarn in ball"), unitNames: longText, defaults: defaults)
        ballsDimension = Dimension<Double, WholePartial>(key: "balls", projectName: name, name: NSLocalizedString("num-balls", value: "Num Balls", comment: "Number of balls needed for a project; needs to be short"), unitNames: ballText, defaults: defaults)
        dimensions = [
            "gauge" : gaugeDimension as DimensionProtocol,
            "yarn" : yarnDimension as DimensionProtocol,
            "ballSize" : ballSizeDimension as DimensionProtocol,
            "balls" : ballsDimension as DimensionProtocol]
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
        
        if partialBalls == WholePartial.whole {
            ballsNeeded = ceil(ballsNeeded)
        }
    }
    // Compute the length of a stitch in m, treating the row of stitches as a helix
    fileprivate func getStitchLength(_ cmGauge:Double, cmWidth:Double, cmLength:Double) -> Double {
        let stitchWidth = 1.0 / cmGauge
        let stitchCir = Double.pi * stitchWidth
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

        if partialBalls == .whole {
            ballsNeeded = ceil(ballsNeeded)
        }
    }

}
