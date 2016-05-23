//
//  ShortLengthPicker.swift
//  YarnRequirements
//
//  Created by Deb on 5/22/16.
//  Copyright © 2016 The Inquisitive Introvert. All rights reserved.
//

import UIKit

class ShortLengthPicker: UIPickerView, UIPickerViewDelegate, UIPickerViewDataSource {

    let text = ["inches", "cm"]
    var project:Project! = nil
    var mfield:ShortLengthUnits! = nil

    // Set the delegate and dataSource
    func loaded(proj:Project, inout mfield:ShortLengthUnits)
    {
        self.delegate = self
        self.dataSource = self
        self.project = proj
        self.mfield = mfield
    }
    // The number of columns of data
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // The number of rows of data
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return text.count
    }
    
    // The data to return for the row and component (column) that's being passed in
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return text[row]
    }
    // Update the gauge units and recalculate the yarn needed
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
        mfield = ShortLengthUnits(rawValue: row)!
        project.calcYarnRequired()
    }
}
