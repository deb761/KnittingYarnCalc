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
        lblName.addConstraint(NSLayoutConstraint(item: lblName, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 90))
        
        // Define the txtField with a defined width
        txtVal = UITextField(frame: CGRect(x: 10, y: 10, width: 50, height: 20))
        txtVal.font = UIFont.systemFont(ofSize: 17)
        txtVal.borderStyle = UITextField.BorderStyle.roundedRect
        txtVal.autocorrectionType = UITextAutocorrectionType.no
        txtVal.keyboardType = UIKeyboardType.decimalPad
        txtVal.returnKeyType = UIReturnKeyType.done
        txtVal.clearButtonMode = UITextField.ViewMode.whileEditing;
        txtVal.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        txtVal.delegate = delegate
        // Set the text field to really wide and set it's comprossion resistance to low so it will shrink to fit on the smaller phones
        txtVal.addConstraint(NSLayoutConstraint(item: txtVal, attribute: .width, relatedBy: .greaterThanOrEqual, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 150))
        txtVal.setContentHuggingPriority(UILayoutPriority.defaultLow, for: .horizontal)
        txtVal.setContentCompressionResistancePriority(UILayoutPriority.defaultLow, for: .horizontal)
        
        // Set up the picker
        self.picker = picker
        // Set the height and width of the picker so that it will not compress on smaller phones nor get much wider on large phones
        self.picker.addConstraint(NSLayoutConstraint(item: self.picker, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 50))
        self.picker.addConstraint(NSLayoutConstraint(item: self.picker, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 130))
        picker.setContentHuggingPriority(UILayoutPriority.defaultLow, for: .horizontal)
        picker.setContentCompressionResistancePriority(UILayoutPriority.required, for: .horizontal)
        // Create the stackView and add the label, textField, and picker to it
        stack = UIStackView(arrangedSubviews: [lblName, txtVal, self.picker])
        
        // Set the stackview as horizontal and define how its elements are arranged
        stack.axis = .horizontal
        stack.distribution = .fillProportionally
        stack.alignment = .center
        stack.spacing = 7
        stack.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func viewDidLoad() {
        // Make the txtVal like a textField
        txtVal.layer.cornerRadius = 5
        txtVal.layer.borderColor = UIColor.black.withAlphaComponent(0.5).cgColor
        txtVal.layer.borderWidth = 0.5
        txtVal.clipsToBounds = true        
    }

}
