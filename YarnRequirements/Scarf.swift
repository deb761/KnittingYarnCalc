//
//  Scarf.swift
//  YarnRequirements
//
//  Created by Deborah Engelmeyer on 5/29/16.
//  Copyright © 2016 The Inquisitive Introvert. All rights reserved.
//

import UIKit

// A scarf is a retangular bit of knitted fabric
class Scarf: Project {

    // length of the scarf
    var length:Double {
        get {
            return defs.doubleForKey("\(name)-length", def: defaults["length"] as! Double)
        }
        set {
            defs.set(newValue, forKey: "\(name)-length")
        }
    }
    // Units for length
    //var lengthUnits:ShortLengthUnits = ShortLengthUnits.Inches;
    var lengthUnits:ShortLengthUnits {
        get {
            return defs.shortLengthUnitsForKey("\(name)-lengthUnits", def: ShortLengthUnits(rawValue: defaults["lengthUnits"] as! Int)!)
        }
        set {
            defs.set(newValue.rawValue, forKey: "\(name)-lengthUnits")
        }
    }
    
    // width of the scarf
    var width:Double {
        get {
            return defs.doubleForKey("\(name)-width", def: defaults["width"] as! Double)
        }
        set {
            defs.set(newValue, forKey: "\(name)-width")
        }
    }
    // Units for length
    var widthUnits:ShortLengthUnits {
        get {
            return defs.shortLengthUnitsForKey("\(name)-widthUnits", def: ShortLengthUnits(rawValue: defaults["widthUnits"] as! Int)!)
        }
        set {
            defs.set(newValue.rawValue, forKey: "\(name)-widthUnits")
        }
    }

    // Track the scarf object
    var scarf:Scarf?
    
    // provide a means of defining a project name and image
    override init(name:String, image:UIImage) {
        super.init(name: name, image: image)
        
        calcYarnRequired()
    }
    // A blanket is a rectangle, so calculate yarn required using length and width
    override func calcYarnRequired()
    {
        var siLength = length
        if (lengthUnits != ShortLengthUnits.cm)
        {
            siLength = length * Project.inches2cm
        }
        var siWidth = width
        if (widthUnits != ShortLengthUnits.cm)
        {
            siWidth = width * Project.inches2cm
        }
        super.calcYarnRequired(siLength, siWidth: siWidth)
    }
    
}
// A blanket is basically a wide scarf, so just change the default width
class Blanket : Scarf {

    // provide a means of defining a project name and image
    override init(name:String, image:UIImage) {
        super.init(name: name, image: image)
        defaults["width"] = 60.0 as AnyObject?
        calcYarnRequired()
    }
    // Blankets consistently need more yarn
    override func calcYarnRequired() {
        super.calcYarnRequired()
        
        yarnNeeded = Int(1.2 * Double(yarnNeeded)) // Add 20% to estimate
        calcballsNeeded()
    }
}

