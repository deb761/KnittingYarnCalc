//
//  DimensionRow.swift
//  YarnRequirements
//
//  Created by Deb on 5/25/16.
//  Copyright © 2016 The Inquisitive Introvert. All rights reserved.
//

import UIKit

class DimensionRow {
    
    var stack:UIStackView!
    var lblName:UILabel!
    var txtVal:UITextField!
    var picker:UIPickerView!
    
    init(name:String, picker:UIPickerView, delegate:UITextFieldDelegate) {
        lblName = UILabel()
        lblName.text = name + ":"
        lblName.addConstraint(NSLayoutConstraint(item: lblName, attribute: .Width, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1, constant: 110))
        
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
//        txtVal.addConstraint(NSLayoutConstraint(item: txtVal, attribute: .Height, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1, constant: 20))
        
        self.picker = picker
        self.picker.addConstraint(NSLayoutConstraint(item: self.picker, attribute: .Height, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1, constant: 60))
        stack = UIStackView(arrangedSubviews: [lblName, txtVal, self.picker])
        
        stack.axis = .Horizontal
        stack.distribution = .FillProportionally
        stack.alignment = .Fill
        stack.spacing = 10
        stack.translatesAutoresizingMaskIntoConstraints = false
    }

}
