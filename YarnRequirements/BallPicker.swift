//
//  BallPicker.swift
//  YarnRequirements
//
//  Created by Deb on 6/14/16.
//  Copyright © 2016 The Inquisitive Introvert. All rights reserved.
//

import UIKit

// This picker allows the user to select between whole balls and partial balls
// when the number of balls is displayed
class BallPicker: PickerView {

    // Set the delegate and dataSource
    override func loaded(_ del:UIPickerViewDelegate, tag:Int)
    {
        super.loaded(del, tag:tag)
        text = [NSLocalizedString("whole", value: "Whole", comment: "A whole ball of yarn"),
                NSLocalizedString("partial", value: "Partial", comment: "A partial ball of yarn")]
    }
    
}
