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
    
    // keep a property for the sweater
    var scarf:Scarf!
    
    // Add the length and width rows to the main stack
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        // Add the length row
        lengthRow = DimensionRow(name: "Length", picker: pkLengthUnits, delegate: self)
        txtLength = lengthRow?.txtVal        
        mainStack?.insertArrangedSubview((lengthRow?.stack)!, atIndex: 3)
        
        // Add the width row
        widthRow = DimensionRow(name: "Width", picker: pkWidthUnits, delegate: self)
        txtWidth = widthRow?.txtVal
        mainStack?.insertArrangedSubview((widthRow?.stack)!, atIndex: 4)
        
        pkLengthUnits.loaded(self, tag: 4)
        pkWidthUnits.loaded(self, tag: 5)
        
        scarf = project as! Scarf
        txtLength.text = String(scarf.length)
        txtLength.addTarget(self, action: #selector(ScarfController.changeLength(_:)), forControlEvents: UIControlEvents.EditingDidEndOnExit)

        txtWidth.text = String(scarf.width)
        txtWidth.addTarget(self, action: #selector(ScarfController.changeWidth(_:)), forControlEvents: UIControlEvents.EditingDidEndOnExit)
    }

    
    // Update the units and recalculate the yarn needed
    override func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
        switch pickerView.tag {
        case 4:
            scarf.lengthUnits = ShortLengthUnits(rawValue: row)!
        case 5:
            scarf.widthUnits = ShortLengthUnits(rawValue: row)!
        default:
            super.pickerView(pickerView, didSelectRow: row, inComponent: component)
        }
        project.calcYarnRequired()
        UpdateText()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Recalc and update units when ball size changes
    func changeLength(sender: AnyObject) {
        scarf.length = Double(txtLength.text!)!
        project.calcYarnRequired()
        UpdateText()
    }
    
    // Recalc and update units when ball size changes
    func changeWidth(sender: AnyObject) {
        scarf.width = Double(txtWidth.text!)!
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
