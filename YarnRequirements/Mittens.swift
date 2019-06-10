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
    override init(name:String, image:UIImage) {
        super.init(name: name, image: image)
        sizeDimension = Dimension<Double, ShortLengthUnits>(key: "size", projectName: name, name: NSLocalizedString("hand-size", value: "Hand Size", comment: "Measurement around the palm"), unitNames: shortText, defaults: defaults)
        dimensions["size"] = sizeDimension! as DimensionProtocol
        dimensionOrder.insert("size", at: 1)
        calcYarnRequired()
    }
    // Calculate the yarn required for a pair of mittens, where the length is
    // 1.3 * hand circumference
    override func calcYarnRequired()
    {
        var width = size;
        if (sizeUnits != ShortLengthUnits.cm)
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
        if (sizeUnits != ShortLengthUnits.cm)
        {
            width *= Project.inches2cm
        }
        let length = width * 1.2 // gloves fit more snuggly than mittens
        width *= 2
        calcYarnRequired(length, siWidth: width)
    }
}

