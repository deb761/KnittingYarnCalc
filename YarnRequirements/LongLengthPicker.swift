//
//  LongLengthPicker.swift
//  YarnRequirements
//
//  Created by Deb on 5/22/16.
//  Copyright © 2016 The Inquisitive Introvert. All rights reserved.
//

import UIKit

class LongLengthPicker: PickerView {

    // Set the delegate and dataSource
    override func loaded(_ del:UIPickerViewDelegate, tag:Int)
    {
        super.loaded(del, tag:tag)
        text = [NSLocalizedString("yards", value: "yards", comment: "Short string for picker that indicates using yards for inits of measure"),
                NSLocalizedString("meters", value: "meters", comment: "Short string for picker that indicates using meters for inits of measure")]
    }
}
