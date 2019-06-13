//
//  DimensionCell.swift
//  Knitting Yarn Calc
//
//  Created by Deborah Engelmeyer on 6/9/19.
//  Copyright © 2019 The Inquisitive Introvert. All rights reserved.
//

import UIKit

protocol DimensionCellDelegate {
    func didChangeDimension()
}

class DimensionCell: UITableViewCell, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {

    @IBOutlet weak var dimensionLabel: UILabel!
    @IBOutlet weak var valueField: UITextField!
    @IBOutlet weak var unitsField: UITextField!
    
    var picker: UIPickerView!
    
    var units:[String]!
    var dimension:DimensionProtocol?
    var delegate:DimensionCellDelegate!
    
    func didCreate(controller: BaseProjectController, dimension:DimensionProtocol, tag:Int) {
        valueField.delegate = self
        self.delegate = controller
        self.dimension = dimension
        picker = UIPickerView()
        picker.delegate = self
        picker.dataSource = self
        picker.tag = tag
        unitsField.inputView = picker
        unitsField.delegate = self
        setValues()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    // MARK: - PickerView delegate

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return units.count
    }

    func pickerView( _ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return units[row]
    }

    // Update the units and recalculate the yarn needed
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
        unitsField.text = units[row]
        picker.isHidden = true
    }
    
    // MARK: Text Field Delegate
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        picker.isHidden = false
        return true
    }
    
    func setValues() {
        unitsField.text = units?[dimension!.unitIndex]
        valueField.text = dimension!.valueString
        picker.selectRow(dimension!.unitIndex, inComponent: 0, animated: false)
    }
}
