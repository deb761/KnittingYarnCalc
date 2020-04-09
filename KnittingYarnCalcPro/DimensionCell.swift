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
    
    func didCreate(controller: ProjectController, dimension:DimensionProtocol) {
        self.delegate = controller
        self.dimension = dimension
        if (dimension.readOnly) {
            valueField.borderStyle = UITextField.BorderStyle.none
            valueField.isEnabled = false
        }
        else {
            valueField.delegate = self
        }
        picker = UIPickerView()
        picker.delegate = self
        picker.dataSource = self
        picker.backgroundColor = UIColor(named: "Background")

        //init toolbar
        let toolbar:UIToolbar = UIToolbar(frame: CGRect(x: 0, y: 0,  width: frame.size.width, height: 30))
        //create left side empty space so that done button set on right side
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneBtn: UIBarButtonItem = UIBarButtonItem(title: "Cancel", style: .done, target: self, action: #selector(doneButtonAction))
        toolbar.setItems([flexSpace, doneBtn], animated: false)
        toolbar.sizeToFit()
        //setting toolbar as inputAccessoryView
        unitsField.inputAccessoryView = toolbar

        unitsField.inputView = picker
        unitsField.delegate = self
        setValues()
    }

    @objc
    func doneButtonAction() {
        unitsField.endEditing(true)
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
        unitsField.endEditing(true)
        dimension!.unitIndex = row
        delegate.didChangeDimension()
    }
    
    // MARK: Text Field Delegate
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        dimension?.valueString = valueField.text!
        // the value might not change, update the text if it didn't
        valueField.text = dimension!.valueString
        delegate.didChangeDimension()
    }
    
    func setValues() {
        unitsField.text = units?[dimension!.unitIndex]
        valueField.text = dimension!.valueString
        picker.selectRow(dimension!.unitIndex, inComponent: 0, animated: false)
        delegate.didChangeDimension()
    }
}
