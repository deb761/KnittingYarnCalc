//
//  Hat.swift
//  YarnRequirements
//
//  Created by Deb on 5/22/16.
//  Copyright © 2016 The Inquisitive Introvert. All rights reserved.
//

import UIKit
import Foundation

// For now, treat hats as a piece of fabric about like this:
//  /\
// |  |
//
class Toque : Project {
    // head size around brow
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
        sizeDimension = Dimension<Double, ShortLengthUnits>(key: "size", projectName: name, name: NSLocalizedString("head-size", value: "Head Size", comment: "Measurement around head for hat size"), unitNames: shortText, defaults: defaults)
        dimensions["size"] = sizeDimension!
        dimensionOrder.insert("size", at: 1)
        calcYarnRequired()
    }
    
    // Calculate the yarn required for a toque, where the total length is
    // 0.5 * head circumference and a cone on the top for the cap that
    // is 0.1 * head circumference.  Hat circumference is 0.93 of head circumference
    //
    // A=πr(r+sqrt(h^2+r^2))
    override func calcYarnRequired()
    {
        let tightness = 0.8
        let lengthCylF = 0.15
        let coneheightF = 0.5
        var width = size
        if (sizeUnits != ShortLengthUnits.cm)
        {
            width *= Project.inches2cm
        }
        let lengthCyl = width * lengthCylF
        // apply tightness factor
        width *= tightness
        let rad = width / Double.pi / 2.0
        let coneHeight = coneheightF * width
        // calculate cone area
        let coneArea = Double.pi * rad * (rad + sqrt(coneHeight * coneHeight + rad * rad))
        // calculate cylinder area
        let cylinderArea = lengthCyl * width
        // calculate relative length
        let length = (coneArea + cylinderArea) / width
        // use this relative length to calculate yarn
        calcYarnRequired(length, siWidth: width)
    }
}
// Tams are also hats, so base them off of Toques.  Toques are this shape:
//
//   ----
//  |    |
//   -__-
class Tam : Toque {
    // Calculate the yarn required for a tam
    // The size is the actual head size, the band will be smaller to fit snug
    // The width is bigger than the head to form a disk
    override func calcYarnRequired()
    {
        var width = size * 1.3
        if (sizeUnits != ShortLengthUnits.cm)
        {
            width *= Project.inches2cm
        }
        let length = width * 0.25
        // A tam has a disk top, so add the area of a circle to the top
        // A = πr^2;  πr = 1/2 width
        let rad = 0.5 / Double.pi
        let diskArea = Double.pi * rad * rad
        let diskLen = diskArea / width
        calcYarnRequired(length + diskLen, siWidth: width)
    }
}
