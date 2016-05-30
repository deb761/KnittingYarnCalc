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
    // Calculate the yarn required for a vest, where the length is
    // 1z2 * chest size
    override func calcYarnRequired()
    {
        var width = ChestSize;
        if (ChestUnits != ShortLengthUnits.CM)
        {
            width *= inches2cm
        }
        let length = width * 0.5
        calcYarnRequired(length, siWidth: width)
    }
}
