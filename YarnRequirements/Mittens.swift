//
//  Mittens.swift
//  YarnRequirements
//
//  Created by Deb on 5/22/16.
//  Copyright © 2016 The Inquisitive Introvert. All rights reserved.
//

import UIKit
import Foundation

// For now, treat mittens as a rectangle wrapped around the hand
class Mittens : Project {
    // hand size around palm
    var size:Double {
        get {
            return defs.doubleForKey("\(name)-size", def: defaults["size"] as! Double)
        }
        set {
            defs.setDouble(newValue, forKey: "\(name)-size")
        }
    }
    // Units for hand size
    var sizeUnits:ShortLengthUnits {
        get {
            return defs.shortLengthUnitsForKey("\(name)-sizeUnits",
                                              def: ShortLengthUnits(rawValue: defaults["sizeUnits"] as! Int)!)
        }
        set {
            defs.setObject(newValue.rawValue, forKey: "\(name)-sizeUnits")
        }
    }
    
    // provide a means of defining a project name and image
    override init(name:String, thumb:UIImage, image:UIImage) {
        super.init(name: name, thumb: thumb, image: image)
        controller = HandController()
        defaults["size"] = defaults["size"]
        defaults["sizeUnits"] = defaults["sizeUnits"]
        calcYarnRequired()
    }
    // Calculate the yarn required for a pair of mittens, where the length is
    // 1.3 * hand circumference
    override func calcYarnRequired()
    {
        var width = size;
        if (sizeUnits != ShortLengthUnits.CM)
        {
            width *= Project.inches2cm
        }
        let length = width * 1.33
        width *= 2
        calcYarnRequired(length, siWidth: width)
    }
}
// Gloves are like mittens, except they also wrap around the fingers
class Gloves : Mittens {
    // Calculate the yarn required for a pair of gloves, where the length is
    // 1.3 * hand circumference
    override func calcYarnRequired()
    {
        var width = size * 1.05 // add extra to go around fingers
        if (sizeUnits != ShortLengthUnits.CM)
        {
            width *= Project.inches2cm
        }
        let length = width * 1.2 // gloves fit more snuggly than mittens
        width *= 2
        calcYarnRequired(length, siWidth: width)
    }
}

