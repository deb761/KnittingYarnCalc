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
    
    // Finished size around the hand
    var size:Double = 8.0;
    // Units for hand size
    var sizeUnits:ShortLengthUnits = ShortLengthUnits.Inches;
    
    // provide a means of defining a project name and image
    override init(name:String, thumb:UIImage, image:UIImage, control:String) {
        super.init(name: name, thumb: thumb, image: image, control: control)
        controller = HandController()
    }
    
    // Calculate the yarn required for a pair of mittens, where the length is
    // 1.3 * hand circumference
    override func calcYarnRequired()
    {
        var width = size;
        if (sizeUnits != ShortLengthUnits.CM)
        {
            width *= inches2cm
        }
        let length = width * 1.5
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
        var width = size * 1.3; // add extra to go around fingers
        if (sizeUnits != ShortLengthUnits.CM)
        {
            width *= inches2cm
        }
        let length = width * 1.5
        width *= 2
        calcYarnRequired(length, siWidth: width)
    }
}

