//
//  DimensionRow.swift
//  YarnRequirements
//
//  Created by Deb on 5/25/16.
//  Copyright © 2016 The Inquisitive Introvert. All rights reserved.
//

import UIKit

// This class defines a horizontal stack with a label, a textField, and a PickerView
class DimensionRow {
    
    var stack:UIStackView!
    var lblName:UILabel!
    var txtVal:UITextField!
    var picker:UIPickerView!
    // 020459
    static let lblColor = UIColor(colorLiteralRed: 2.0/255.0, green: 4.0/255.0, blue: Float(0x59)/255.0, alpha: 1.0)
    
    init(name:String, picker:UIPickerView, delegate:UITextFieldDelegate) {
        // Create the label and assign it the input text
        lblName = UILabel()
        lblName.text = name + ":"
        lblName.textColor = DimensionRow.lblColor
        lblName.addConstraint(NSLayoutConstraint(item: lblName, attribute: .Width, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1, constant: 110))
        
        // Define the txtField with a defined width
        txtVal = UITextField(frame: CGRectMake(10, 10, 80, 20))
        txtVal.font = UIFont.systemFontOfSize(17)
        txtVal.borderStyle = UITextBorderStyle.RoundedRect
        txtVal.autocorrectionType = UITextAutocorrectionType.No
        txtVal.keyboardType = UIKeyboardType.DecimalPad
        txtVal.returnKeyType = UIReturnKeyType.Done
        txtVal.clearButtonMode = UITextFieldViewMode.WhileEditing;
        txtVal.contentVerticalAlignment = UIControlContentVerticalAlignment.Center
        txtVal.delegate = delegate
        txtVal.addConstraint(NSLayoutConstraint(item: txtVal, attribute: .Width, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1, constant: 80))
        
        // Set up the picker
        self.picker = picker
        self.picker.addConstraint(NSLayoutConstraint(item: self.picker, attribute: .Height, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1, constant: 60))
        // Create the stackView and add the label, textField, and picker to it
        stack = UIStackView(arrangedSubviews: [lblName, txtVal, self.picker])
        
        // Set the stackview ash horizontal and define how its elements are arranged
        stack.axis = .Horizontal
        stack.distribution = .FillProportionally
        stack.alignment = .Center
        stack.spacing = 10
        stack.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func viewDidLoad() {
        // Make the txtVal like a textField
        txtVal.layer.cornerRadius = 5
        txtVal.layer.borderColor = UIColor.blackColor().colorWithAlphaComponent(0.5).CGColor
        txtVal.layer.borderWidth = 0.5
        txtVal.clipsToBounds = true        
    }

}
