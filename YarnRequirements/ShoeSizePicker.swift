//
//  ShoeSizePicker.swift
//  YarnRequirements
//
//  Created by Deb on 5/22/16.
//  Copyright © 2016 The Inquisitive Introvert. All rights reserved.
//

import UIKit

class ShoeSizePicker: PickerView {

    // Set the delegate and dataSource
    override func loaded(del:UIPickerViewDelegate, tag:Int)
    {
        super.loaded(del, tag:tag)
        text = ["US Child", "US Youth", "US Women", "US Men", "Euro"]
    }
    
}
