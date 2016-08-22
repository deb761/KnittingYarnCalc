//
//  GaugePicker.swift
//  YarnRequirements
//
//  Created by Deb on 5/22/16.
//  Copyright © 2016 The Inquisitive Introvert. All rights reserved.
//

import UIKit

class GaugePicker: PickerView {

    // Set the delegate and dataSource
    override func loaded(del:UIPickerViewDelegate, tag:Int)
    {
        super.loaded(del, tag:tag)
        text = [NSLocalizedString("sts/inch", value: "sts/inch", comment: "Stitches per inch to determine yarn gauge"),
                NSLocalizedString("sts/4inch", value: "sts/4inch", comment: "Stitches per 4 inches to determine yarn gauge"),
                NSLocalizedString("sts/10cm", value: "sts/10cm", comment: "Stitches per 10 cm to determine yarn gauge")]
    }
    
}
