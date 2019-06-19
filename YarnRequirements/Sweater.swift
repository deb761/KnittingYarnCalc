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
    var sizeDimension: Dimension<Double, ShortLengthUnits>?
    var size:Double {
        get {
            return sizeDimension!.value
        }
        set {
            sizeDimension!.value = newValue
        }
    }
    // Units for chest size
    var sizeUnits:ShortLengthUnits {
        get {
            return sizeDimension!.unit
        }
        set {
            sizeDimension!.unit = newValue
        }
    }
    
    // provide a means of defining a project name and image
    override init(name:String) {
        super.init(name: name)
        sizeDimension = Dimension<Double, ShortLengthUnits>(key: "size", projectName: name, name: NSLocalizedString("chest-size", value: "Chest Size", comment: "Measurement around a sweater at the wearer's chest"), unitNames: shortText, defaults: defaults)
        dimensions["size"] = sizeDimension! as DimensionProtocol
        dimensionOrder.insert("size", at: 1)

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
        if (sizeUnits == .inches) {
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

