//
//  pickerView.swift
//  YarnRequirements
//
//  Created by Deb on 5/25/16.
//  Copyright © 2016 The Inquisitive Introvert. All rights reserved.
//

import UIKit

class PickerView: UIPickerView, UIPickerViewDataSource {

    var text = ["inches", "cm"]
    
    // Set the delegate and dataSource
    func loaded(_ del:UIPickerViewDelegate, tag:Int)
    {
        self.dataSource = self
        self.delegate = del
        self.tag = tag
    }
    // The number of columns of data
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // The number of rows of data
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return text.count
    }

}
