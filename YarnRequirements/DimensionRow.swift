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
    
    init(name:String, picker:UIPickerView, delegate:UITextFieldDelegate) {
        // Create the label and assign it the input text
        lblName = UILabel()
        lblName.text = name + ":"
        lblName.textColor = Colors.lblColor
        lblName.addConstraint(NSLayoutConstraint(item: lblName, attribute: .Width, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1, constant: 90))
        
        // Define the txtField with a defined width
        txtVal = UITextField(frame: CGRectMake(10, 10, 50, 20))
        txtVal.font = UIFont.systemFontOfSize(17)
        txtVal.borderStyle = UITextBorderStyle.RoundedRect
        txtVal.autocorrectionType = UITextAutocorrectionType.No
        txtVal.keyboardType = UIKeyboardType.DecimalPad
        txtVal.returnKeyType = UIReturnKeyType.Done
        txtVal.clearButtonMode = UITextFieldViewMode.WhileEditing;
        txtVal.contentVerticalAlignment = UIControlContentVerticalAlignment.Center
        txtVal.delegate = delegate
        // Set the text field to really wide and set it's comprossion resistance to low so it will shrink to fit on the smaller phones
        txtVal.addConstraint(NSLayoutConstraint(item: txtVal, attribute: .Width, relatedBy: .GreaterThanOrEqual, toItem: nil, attribute: .NotAnAttribute, multiplier: 1, constant: 150))
        txtVal.setContentHuggingPriority(UILayoutPriorityDefaultLow, forAxis: .Horizontal)
        txtVal.setContentCompressionResistancePriority(UILayoutPriorityDefaultLow, forAxis: .Horizontal)
        
        // Set up the picker
        self.picker = picker
        // Set the height and width of the picker so that it will not compress on smaller phones nor get much wider on large phones
        self.picker.addConstraint(NSLayoutConstraint(item: self.picker, attribute: .Height, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1, constant: 50))
        self.picker.addConstraint(NSLayoutConstraint(item: self.picker, attribute: .Width, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1, constant: 130))
        picker.setContentHuggingPriority(UILayoutPriorityDefaultLow, forAxis: .Horizontal)
        picker.setContentCompressionResistancePriority(UILayoutPriorityRequired, forAxis: .Horizontal)
        // Create the stackView and add the label, textField, and picker to it
        stack = UIStackView(arrangedSubviews: [lblName, txtVal, self.picker])
        
        // Set the stackview as horizontal and define how its elements are arranged
        stack.axis = .Horizontal
        stack.distribution = .FillProportionally
        stack.alignment = .Center
        stack.spacing = 7
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
