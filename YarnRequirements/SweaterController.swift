//
//  SweaterController.swift
//  YarnRequirements
//
//  Created by Deborah Engelmeyer on 5/29/16.
//  Copyright © 2016 The Inquisitive Introvert. All rights reserved.
//

import UIKit

class SweaterController: OldProjectController {
    
    // fourth row in the stack, chest size and units
    var sizeRow : DimensionRow?
    var txtSize: UITextField!
    var pkSizeUnits: ShortLengthPicker! = ShortLengthPicker()
    
    // keep a property for the sweater
    var sweater:Sweater!
    
    // Add the Chest Size row to the stack
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        sizeRow = DimensionRow(name: NSLocalizedString("chest-size", value: "Chest Size", comment: "Measurement around a sweater at the wearer's chest"),
                               picker: pkSizeUnits, delegate: self)
        txtSize = sizeRow?.txtVal
        
        mainStack?.insertArrangedSubview((sizeRow?.stack)!, at: 2)
        
        pkSizeUnits.loaded(self, tag: 5)
        
        sweater = project as? Sweater
        txtSize.text = String(sweater.size)
        txtSize.addTarget(self, action: #selector(SweaterController.changeSize(_:)), for: UIControl.Event.editingDidEnd)

        // Set initial value for pickers
        pkSizeUnits.selectRow(sweater.sizeUnits.rawValue, inComponent: 0, animated: false)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Update the units and recalculate the yarn needed
    override func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
        switch pickerView.tag {
        case 5:
            sweater.sizeUnits = ShortLengthUnits(rawValue: row)!
        default:
            super.pickerView(pickerView, didSelectRow: row, inComponent: component)
        }
        txtGauge.endEditing(true)
        txtSize.endEditing(true)
        txtBallSize.endEditing(true)
        project.calcYarnRequired()
        UpdateText()
    }

    // Recalc and update units when ball size changes
    @IBAction func changeSize(_ sender: AnyObject) {
        if let size = Double(txtSize.text!) {
            sweater.size = size
        } else {
            txtSize.text = String(sweater.size)
        }
        project.calcYarnRequired()
        UpdateText()
    }
    
}
