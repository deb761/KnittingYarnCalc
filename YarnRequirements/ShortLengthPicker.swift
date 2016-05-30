//
//  ShortLengthPicker.swift
//  YarnRequirements
//
//  Created by Deb on 5/22/16.
//  Copyright © 2016 The Inquisitive Introvert. All rights reserved.
//

import UIKit

class ShortLengthPicker: PickerView {

    // Set the delegate and dataSource
    override func loaded(del:UIPickerViewDelegate, tag:Int)
    {
        super.loaded(del, tag:tag)
        text = ["inches", "cm"]
    }
}
