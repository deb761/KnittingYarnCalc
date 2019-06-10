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
    var dimension:DimensionProtocol?
    
    func didCreate(controller: BaseProjectController, dimension:DimensionProtocol, tag:Int) {
        valueField.delegate = controller
        self.dimension = dimension
        picker.delegate = controller
        picker.dataSource = self
        picker.tag = tag
        setValues()
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

    func setValues() {
        unitsField.text = units?[dimension!.unitIndex]
        valueField.text = dimension!.valueString
        picker.selectRow(dimension!.unitIndex, inComponent: 0, animated: false)
    }
}
