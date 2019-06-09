//
//  DimensionCell.swift
//  Knitting Yarn Calc
//
//  Created by Deborah Engelmeyer on 6/9/19.
//  Copyright © 2019 The Inquisitive Introvert. All rights reserved.
//

import UIKit

class DimensionCell: UITableViewCell, UIPickerViewDataSource {

    @IBOutlet weak var dimensionLabel: UILabel!
    @IBOutlet weak var valueField: UITextField!
    @IBOutlet weak var unitsField: UITextField!
    
    @IBOutlet weak var picker: UIPickerView!
    
    var units:[String]!
    
    func didCreate(controller: BaseProjectController, tag:Int) {
        valueField.delegate = controller
        picker.delegate = controller
        picker.dataSource = self
        picker.tag = tag
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return units.count
    }

    func setUnits(_ index: Int) {
        unitsField.text = units?[index]
        picker.selectRow(index, inComponent: 0, animated: false)
    }
}
