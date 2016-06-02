//
//  HatController.swift
//  YarnRequirements
//
//  Created by Deborah Engelmeyer on 5/29/16.
//  Copyright © 2016 The Inquisitive Introvert. All rights reserved.
//

import UIKit

class HatController: BaseProjectController {
    
    // fourth row in the stack, chest size and units
    var sizeRow : DimensionRow?
    var txtSize: UITextField!
    var pkSizeUnits: ShortLengthPicker! = ShortLengthPicker()
    
    // keep a property for the sweater
    var hat:Toque!
    
    // Add the Chest Size row to the stack
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        sizeRow = DimensionRow(name: "Head Size", picker: pkSizeUnits, delegate: self)
        txtSize = sizeRow?.txtVal
        
        mainStack?.insertArrangedSubview((sizeRow?.stack)!, atIndex: 2)
        
        pkSizeUnits.loaded(self, tag: 4)
        
        hat = project as! Toque
        txtSize.text = String(hat.size)
        txtSize.addTarget(self, action: #selector(SweaterController.changeSize(_:)), forControlEvents: UIControlEvents.EditingDidEnd)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Update the units and recalculate the yarn needed
    override func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
        switch pickerView.tag {
        case 4:
            hat.sizeUnits = ShortLengthUnits(rawValue: row)!
        default:
            super.pickerView(pickerView, didSelectRow: row, inComponent: component)
        }
        project.calcYarnRequired()
        UpdateText()
    }

    // Recalc and update units when ball size changes
    func changeSize(sender: AnyObject) {
        hat.size = Double(txtSize.text!)!
        project.calcYarnRequired()
        UpdateText()
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
