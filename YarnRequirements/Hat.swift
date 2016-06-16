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
class Toque : Project {
    
    // Finished size around the head
    var size:Double = 23.0;
    // Units for head size
    var sizeUnits:ShortLengthUnits = ShortLengthUnits.Inches;
    
    // provide a means of defining a project name and image
    override init(name:String, thumb:UIImage, image:UIImage, control:String) {
        super.init(name: name, thumb: thumb, image: image, control: control)
        controller = HatController()
    }
    
    // Calculate the yarn required for a toque, where the length is
    // 1.3 * hand circumference
    override func calcYarnRequired()
    {
        var width = size;
        if (sizeUnits != ShortLengthUnits.CM)
        {
            width *= Project.inches2cm
        }
        let length = width * 0.25
        calcYarnRequired(length, siWidth: width)
    }
}
// Tams are also hats, so base them off of Toques.  Toques are this shape:
//    /\
//   /  \
//  |    |   Actually, this diagram is stretched a bit vertically
//  \____/
class Tam : Toque {
    // Calculate the yarn required for a tam
    override func calcYarnRequired()
    {
        var width = size * 1.3; // tams need to have a brim smaller than the head to fit snug
        if (sizeUnits != ShortLengthUnits.CM)
        {
            width *= Project.inches2cm
        }
        let length = width * 0.325
        calcYarnRequired(length, siWidth: width)
    }
}
