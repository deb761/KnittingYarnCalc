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
    override func loaded(_ del:UIPickerViewDelegate, tag:Int)
    {
        super.loaded(del, tag:tag)
        text = [NSLocalizedString("inches", value: "inches", comment: "Short string for picker that indicates using inches for units"),
                NSLocalizedString("cm", value: "cm", comment: "Short string for picker that indicates using cm for units")]
    }
}
