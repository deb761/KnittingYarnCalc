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
        text = [NSLocalizedString("us-child", value: "US Child", comment: "Short string for picker indicating US Child shoe sizes"),
                NSLocalizedString("us-youth", value: "US Youth", comment: "Short string for picker indicating US Youth shoe sizes"),
                NSLocalizedString("us-women", value: "US Women", comment: "Short string for picker indicating US Women shoe sizes"),
                NSLocalizedString("us-men", value: "US Men", comment: "Short string for picker indicating US Men shoe sizes"),
                NSLocalizedString("euro", value: "Euro", comment: "Short string for picker indicating European shoe sizes")]
    }
    
}
