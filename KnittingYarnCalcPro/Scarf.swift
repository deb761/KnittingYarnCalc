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
    var lengthDimension: Dimension<Double, ShortLengthUnits>?
    var length:Double {
        get {
            return lengthDimension!.value
        }
        set {
            lengthDimension!.value = newValue
        }
    }
    // Units for length
    //var lengthUnits:ShortLengthUnits = ShortLengthUnits.Inches;
    var lengthUnits:ShortLengthUnits {
        get {
            return lengthDimension!.unit
        }
        set {
            lengthDimension!.unit = newValue
        }
    }
    
    // width of the scarf
    var widthDimension: Dimension<Double, ShortLengthUnits>?
    var width:Double {
        get {
            return widthDimension!.value
        }
        set {
            widthDimension!.value = newValue
        }
    }
    // Units for length
    var widthUnits:ShortLengthUnits {
        get {
            return widthDimension!.unit
        }
        set {
            widthDimension!.unit = newValue
        }
    }

    // Track the scarf object
    var scarf:Scarf?
    
    // provide a means of defining a project name and image
    override init(name:String) {
        super.init(name: name)
        
        lengthDimension = Dimension<Double, ShortLengthUnits>(key: "length", projectName: name, name: NSLocalizedString("length", value: "Length", comment: "Label for length of an item"), unitNames: shortText, defaults: defaults)
        widthDimension = Dimension<Double, ShortLengthUnits>(key: "width", projectName: name, name: NSLocalizedString("width", value: "Width", comment: "Label for width of an item"), unitNames: shortText, defaults: defaults)
        dimensions["length"] = lengthDimension as! DimensionProtocol
        dimensions["width"] = widthDimension as! DimensionProtocol
        dimensionOrder.insert("length", at: 1)
        dimensionOrder.insert("width", at: 2)
        //calcYarnRequired()
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
    override init(name:String) {
        super.init(name: name)
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

