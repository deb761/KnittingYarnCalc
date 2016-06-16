//
//  Vest.swift
//  YarnRequirements
//
//  Created by Deborah Engelmeyer on 5/29/16.
//  Copyright © 2016 The Inquisitive Introvert. All rights reserved.
//

import UIKit

// A vest is modeled as a tube of fabric that is 1/2 as long as its circumference
// It is taken off sweater as it has the same size dimension
class Vest: Sweater {
    
    /* Results of linear fit of Length to hips by Chest size:
     (Intercept)      Chest
     Baby     -6.50000 0.60000000
     Child   -23.85854 0.78042063
     Man      47.67266 0.17445286
     Woman    52.32509 0.06000826
     Youth    14.99031 0.38372093
     
     Looks like the baby line will cover up to 80cm,
     Then we will jump to the Man line
    */
    let babyInt = -6.50000
    let babySlope = 0.60000000
    
    let sBreak = 80.0 //cm
    
    let manInt = 47.67266
    let manSlope = 0.17445286
    
    // Calculate the yarn required for a vest, where the length is
    // 1.2 * chest size
    override func calcYarnRequired()
    {
        var width = chestSize;
        if (chestUnits != ShortLengthUnits.CM)
        {
            width *= Project.inches2cm
        }
        var length:Double
        if (width < 80.0)
        {
            length = babyInt + babySlope * width
        } else {
            length = manInt + manSlope * width
        }
        calcYarnRequired(length, siWidth: width)
    }
}
