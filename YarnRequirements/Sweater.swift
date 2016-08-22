//
//  Sweater.swift
//  YarnRequirements
//
//  Created by Deb on 5/22/16.
//  Copyright © 2016 The Inquisitive Introvert. All rights reserved.
//

import Foundation
import UIKit

// This class defines the parameters and performs the calculations for a sweater project
class Sweater : Project {
    // chest size
    var size:Double {
        get {
            return defs.doubleForKey("\(name)-size", def: defaults["size"] as! Double)
        }
        set {
            defs.setDouble(newValue, forKey: "\(name)-size")
        }
    }
    // Units for chest size
    var sizeUnits:ShortLengthUnits {
        get {
            return defs.shortLengthUnitsForKey("\(name)-sizeUnits", def: ShortLengthUnits(rawValue: defaults["sizeUnits"] as! Int)!)
        }
        set {
            defs.setObject(newValue.rawValue, forKey: "\(name)-sizeUnits")
        }
    }
    
    // provide a means of defining a project name and image
    override init(name:String, thumb:UIImage, image:UIImage) {
        super.init(name: name, thumb: thumb, image: image)
        controller = SweaterController()
        calcYarnRequired()
    }

    // Calculate the yarn required for an adult size sweater.  Based on calculating the area
    // of a basic t-shaped sweater using a loose fit and standard body measurements from
    // YarnStandards.com.  The area is fairly linear with respect to finished chest measurement,
    // although Men's sweaters are about 10% larger due to men having longer torsos and arms
    // than women.  The linear equation used here includes a 10% increase in the value to account
    // for this, so the estimate should still be high enough for men while not being way too much
    // for women.
    override func calcYarnRequired()
    {
        var chest = size
        if (sizeUnits == .Inches) {
            chest *= Project.inches2cm
        }
        let intercept = -5559.8 // cm
        let slope = 162.1 // cm^2
        let area = intercept + slope * chest
        // let the sleeves be a trapezoid with max width 0.5 * width, and min width being 0.25 * width
        // let the length match the body length (which are really long sleeves), and add the average width
        // of the two sleeves to the body width
        let width = chest * 1.75
        let length = area / width
        
        super.calcYarnRequired(length, siWidth: width)
    }
}

