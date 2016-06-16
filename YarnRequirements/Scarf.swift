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
    var length:Double = 72.0;
    // Units for length
    var lengthUnits:ShortLengthUnits = ShortLengthUnits.Inches;
    
    // width of the scarf
    var width:Double = 12.0;
    // Units for length
    var widthUnits:ShortLengthUnits = ShortLengthUnits.Inches;
    
    // Track the scarf object
    var scarf:Scarf?
    
    // provide a means of defining a project name and image
    override init(name:String, thumb:UIImage, image:UIImage, control:String) {
        super.init(name: name, thumb: thumb, image: image, control: control)
        controller = ScarfController()
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
    override init(name:String, thumb:UIImage, image:UIImage, control:String) {
        super.init(name: name, thumb: thumb, image: image, control: control)
        width = 60.0;
    }
    
}

