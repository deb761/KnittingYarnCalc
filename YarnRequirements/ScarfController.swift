//
//  ScarfController.swift
//  YarnRequirements
//
//  Created by Deborah Engelmeyer on 5/29/16.
//  Copyright © 2016 The Inquisitive Introvert. All rights reserved.
//

import UIKit

class ScarfController: BaseProjectController {

    // fourth row in the stack, length and units
    var lengthRow : DimensionRow?
    var txtLength: UITextField!
    var pkLengthUnits: ShortLengthPicker! = ShortLengthPicker()
    
    // fourth row in the stack, width and units
    var widthRow : DimensionRow?
    var txtWidth: UITextField!
    var pkWidthUnits: ShortLengthPicker! = ShortLengthPicker()
    
    // keep a property for the scarf
    var scarf:Scarf!
    
    // Add the length and width rows to the main stack
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        // Add the length row
        lengthRow = DimensionRow(name: NSLocalizedString("length", value: "Length", comment: "Label for length of an item"), picker: pkLengthUnits, delegate: self)
        txtLength = lengthRow?.txtVal        
        mainStack?.insertArrangedSubview((lengthRow?.stack)!, at: 2)
        
        // Add the width row
        widthRow = DimensionRow(name: NSLocalizedString("width", value: "Width", comment: "Label for width of an item"), picker: pkWidthUnits, delegate: self)
        txtWidth = widthRow?.txtVal
        mainStack?.insertArrangedSubview((widthRow?.stack)!, at: 3)
        
        pkLengthUnits.loaded(self, tag: 5)
        pkWidthUnits.loaded(self, tag: 6)
        
        scarf = project as! Scarf
        txtLength.text = String(scarf.length)
        txtLength.addTarget(self, action: #selector(ScarfController.changeLength(_:)), for: UIControlEvents.editingDidEnd)

        txtWidth.text = String(scarf.width)
        txtWidth.addTarget(self, action: #selector(ScarfController.changeWidth(_:)), for: UIControlEvents.editingDidEnd)

        // Set initial value for pickers
        pkLengthUnits.selectRow(scarf.lengthUnits.rawValue, inComponent: 0, animated: false)
        pkWidthUnits.selectRow(scarf.widthUnits.rawValue, inComponent: 0, animated: false)
    }

    
    // Update the units and recalculate the yarn needed
    override func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
        switch pickerView.tag {
        case 5:
            scarf.lengthUnits = ShortLengthUnits(rawValue: row)!
        case 6:
            scarf.widthUnits = ShortLengthUnits(rawValue: row)!
        default:
            super.pickerView(pickerView, didSelectRow: row, inComponent: component)
        }
        txtGauge.endEditing(true)
        txtLength.endEditing(true)
        txtWidth.endEditing(true)
        txtBallSize.endEditing(true)
        project.calcYarnRequired()
        UpdateText()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Recalc and update units when ball size changes
    func changeLength(_ sender: AnyObject) {
        if let length = Double(txtLength.text!) {
            scarf.length = length
        } else {
            txtLength.text = String(scarf.length)
        }
        project.calcYarnRequired()
        UpdateText()
    }
    
    // Recalc and update units when ball size changes
    func changeWidth(_ sender: AnyObject) {
        if let width = Double(txtWidth.text!) {
            scarf.width = width
        } else {
            txtWidth.text = String(scarf.width)
        }
        
        project.calcYarnRequired()
        UpdateText()
    }

}
