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
            return settings["length"] as! Double
        }
        set {
            settings["length"] = newValue
        }
    }
    // Units for length
    //var lengthUnits:ShortLengthUnits = ShortLengthUnits.Inches;
    var lengthUnits:ShortLengthUnits {
        get {
            return ShortLengthUnits(rawValue: settings["lengthUnits"] as! Int)!
        }
        set {
            settings["lengthUnits"] = newValue.rawValue
        }
    }
    
    // width of the scarf
    var width:Double {
        get {
            return settings["width"] as! Double
        }
        set {
            settings["width"] = newValue
        }
    }
    // Units for length
    var widthUnits:ShortLengthUnits {
        get {
            return ShortLengthUnits(rawValue: settings["widthUnits"] as! Int)!
        }
        set {
            settings["widthUnits"] = newValue.rawValue
        }
    }

    // Track the scarf object
    var scarf:Scarf?
    
    // provide a means of defining a project name and image
    override init(name:String, thumb:UIImage, image:UIImage) {
        super.init(name: name, thumb: thumb, image: image)
        controller = ScarfController()
    }
    // Fill in settings in case there is an error with the plist file
    override func settingsToDefault() {
        super.settingsToDefault()
        settings["length"] = 72.0
        settings["lengthUnits"] = 0
        settings["width"] = 12.0
        settings["widthUnits"] = 0
    }
    // A blanket is a rectangle, so calculate yarn required using length and width
    override func calcYarnRequired()
    {
        var siLength = length
        if (lengthUnits != ShortLengthUnits.CM)
        {
            siLength = length * Project.inches2cm
        }
        var siWidth = width
        if (widthUnits != ShortLengthUnits.CM)
        {
            siWidth = width * Project.inches2cm
        }
        super.calcYarnRequired(siLength, siWidth: siWidth)
    }
    
}
// A blanket is basically a wide scarf, so just change the default width
class Blanket : Scarf {

    // provide a means of defining a project name and image
    override init(name:String, thumb:UIImage, image:UIImage) {
        super.init(name: name, thumb: thumb, image: image)
    }
    // Fill in settings in case there is an error with the plist file
    override func settingsToDefault() {
        super.settingsToDefault()
        settings["width"] = 60.0
    }
    // Blankets consistently need more yarn
    override func calcYarnRequired() {
        super.calcYarnRequired()
        
        yarnNeeded = Int(1.2 * Double(yarnNeeded)) // Add 20% to estimate
        calcballsNeeded()
    }
}

