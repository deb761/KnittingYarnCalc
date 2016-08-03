//
//  BaseProjectController.swift
//  YarnRequirements
//
//  Created by Deb on 5/22/16.
//  Copyright © 2016 The Inquisitive Introvert. All rights reserved.
//

import UIKit

class BaseProjectController: UIViewController, UIPickerViewDelegate, UITextFieldDelegate {
    
    // A scrollview is needed to move the textviews up when the keyboard would cover them
    var scrollView:UIScrollView = UIScrollView()
    var mainStack: UIStackView?

    // First row in the stack, the project name and image
    var nameStack: UIStackView?
    var lblName: UILabel! = UILabel()
    var projectImg: UIImageView! = UIImageView(frame: CGRectMake(0, 0, 178, 193))

    // second row in the stack, the gauge and units
    var gaugeRow: DimensionRow?
    var pkGauge: GaugePicker! = GaugePicker()
    
    // third row in the stack, yarn needed and units
    var yarnRow : DimensionRow?
    var pkYarnUnits: LongLengthPicker! = LongLengthPicker()

    // fourth row in the stack, yarn needed and units
    var ballRow : DimensionRow?
    var pkBallUnits: LongLengthPicker! = LongLengthPicker()
    
    // fifth row in the stack, num balls needed
    var nBallsRow : DimensionRow?
    var pkBallPartial: BallPicker! = BallPicker()

    var txtGauge: UITextField!
    var txtYarnNeeded: UITextField!
    var txtBallSize: UITextField!
    var txtBallsNeeded: UITextField!

    var project:Project!

    // Set the input items to the current values
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        // Create the nameStack
        nameStack = UIStackView(arrangedSubviews: [lblName, projectImg])
        nameStack!.axis = .Horizontal
        nameStack!.distribution = .EqualSpacing
        nameStack!.alignment = .Fill
        nameStack!.spacing = 10
        nameStack!.translatesAutoresizingMaskIntoConstraints = false
        lblName.text = project.name
        lblName.widthAnchor.constraintEqualToConstant(50)
        lblName.textColor = DimensionRow.lblColor
        lblName.font = lblName.font.fontWithSize(20)

        projectImg.image = project.image
        projectImg.addConstraint(NSLayoutConstraint(item: projectImg, attribute: .Width, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1, constant: 178))
        projectImg.addConstraint(NSLayoutConstraint(item: projectImg, attribute: .Height, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1, constant: 193))
        
        // Create the stack with the Gauge
        gaugeRow = DimensionRow(name: "Gauge", picker: pkGauge, delegate: self)
        txtGauge = gaugeRow!.txtVal
        txtGauge.addTarget(self, action: #selector(BaseProjectController.changeGauge(_:)), forControlEvents: UIControlEvents.EditingDidEnd)

        // Create the stack with the yarn needed
        yarnRow = DimensionRow(name: "Yarn Needed", picker: pkYarnUnits, delegate: self)
        txtYarnNeeded = yarnRow!.txtVal
        txtYarnNeeded.userInteractionEnabled = false
        
        // Create the stack with the ball size
        ballRow = DimensionRow(name: "Ball Size", picker: pkBallUnits, delegate: self)
        txtBallSize = ballRow!.txtVal
        txtBallSize.addTarget(self, action: #selector(BaseProjectController.changeBallSize(_:)), forControlEvents: UIControlEvents.EditingDidEnd)
        
        // Create the stack with the balls needed
        nBallsRow = DimensionRow(name: "Num Balls", picker: pkBallPartial, delegate: self)
        txtBallsNeeded = nBallsRow!.txtVal
        txtBallsNeeded.userInteractionEnabled = false
        
        // Create the main stack
        mainStack = UIStackView(arrangedSubviews: [nameStack!, gaugeRow!.stack, yarnRow!.stack, ballRow!.stack, nBallsRow!.stack])
        mainStack!.axis = .Vertical
        mainStack!.distribution =  UIStackViewDistribution.EqualSpacing
        mainStack!.alignment = .Fill
        //mainStack!.spacing = -5
        mainStack!.translatesAutoresizingMaskIntoConstraints = false
        let height = view.bounds.height
        let width = view.bounds.width
        scrollView.contentSize.height = height
        scrollView.contentSize.width = width
        scrollView.addSubview(mainStack!)
        
        // Configure the scrollView
        scrollView.frame = view.bounds
        scrollView.scrollEnabled = true
        scrollView.autoresizingMask = UIViewAutoresizing.FlexibleHeight
        view.addSubview(scrollView)
        view.backgroundColor = UIColor(red: 212.0/255.0,
                                       green: 216.0/255.0,
                                       blue: 214.0/255.0, alpha: 1.0)
        
        //autolayout the scroll view - pin 30 up 20 left 20 right 30 down
        let viewsDictionary = ["scrollView":scrollView]
        let scrollView_H = NSLayoutConstraint.constraintsWithVisualFormat(
            "H:|-20-[scrollView]-20-|",  //horizontal constraint 20 points from left and right side
            options: NSLayoutFormatOptions(rawValue: 0),
            metrics: nil,
            views: viewsDictionary)
        let scrollView_V = NSLayoutConstraint.constraintsWithVisualFormat(
            "V:|-80-[scrollView]-50-|", //vertical constraint 30 points from top and bottom
            options: NSLayoutFormatOptions(rawValue:0),
            metrics: nil,
            views: viewsDictionary)
        view.addConstraints(scrollView_H)
        view.addConstraints(scrollView_V)
        
        registerForKeyboardNotifications()
        self.hideKeyboardWhenTappedAround() 
        
        // pin the top left of the mainStack to the scrollview
        // Get the superview's layout
        let margins = scrollView.layoutMarginsGuide
        
        // Pin the leading edge of myView to the margin's leading edge
        
        mainStack!.leadingAnchor.constraintEqualToAnchor(margins.leadingAnchor).active = true
        mainStack!.topAnchor.constraintEqualToAnchor(margins.topAnchor).active = true
        mainStack!.trailingAnchor.constraintEqualToAnchor(margins.trailingAnchor).active = true
        mainStack!.bottomAnchor.constraintEqualToAnchor(margins.bottomAnchor).active = true

        pkGauge.loaded(self, tag: 1)
        pkYarnUnits.loaded(self, tag: 2)
        pkBallUnits.loaded(self, tag: 3)
        pkBallPartial.loaded(self, tag: 4)
        
        // Set initial value for pickers
        pkGauge.selectRow(project.gaugeUnits.rawValue, inComponent: 0, animated: false)
        pkYarnUnits.selectRow(project.yarnNeededUnits.rawValue, inComponent: 0, animated: false)
        pkBallUnits.selectRow(project.ballSizeUnits.rawValue, inComponent: 0, animated: false)
        pkBallPartial.selectRow(Int(project.partialBalls), inComponent: 0, animated: false)

        // Set initial values for text fields
        UpdateText()
    }
    // Add a function to hide the keyboard
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(BaseProjectController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
    // Active text field
    var activeField: UITextField?
    func registerForKeyboardNotifications()
    {
        //Adding notifies on keyboard appearing
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(BaseProjectController.keyboardWasShown(_:)),
                                                         name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(BaseProjectController.keyboardWillBeHidden(_:)),
                                                         name: UIKeyboardWillHideNotification, object: nil)
    }
    
    
    func deregisterFromKeyboardNotifications()
    {
        //Removing notifies on keyboard appearing
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillHideNotification, object: nil)
    }
    // Hold on to the contentInset of the scrollView before adjusting for the keyboard
    var insets:UIEdgeInsets!
    // Move the scrollView content up to account for the keyboard
    func keyboardWasShown(notification: NSNotification)
    {
        //Need to calculate keyboard exact size due to Apple suggestions
        self.scrollView.scrollEnabled = true
        let info : NSDictionary = notification.userInfo!
        let keyboardSize = (info[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.CGRectValue().size
        insets = scrollView.contentInset
        let contentInsets : UIEdgeInsets = UIEdgeInsetsMake(0.0, 0.0, keyboardSize!.height, 0.0)
        
        self.scrollView.contentInset = contentInsets
        self.scrollView.scrollIndicatorInsets = contentInsets
        
        var aRect : CGRect = self.view.frame
        aRect.size.height -= keyboardSize!.height
        if activeField != nil
        {
            if (!CGRectContainsPoint(aRect, activeField!.frame.origin))
            {
                self.scrollView.scrollRectToVisible(activeField!.frame, animated: true)
            }
        }
    }
    
    // Restore the contentInsets
    func keyboardWillBeHidden(notification: NSNotification)
    {
        self.scrollView.contentInset = insets//contentInsets
        self.view.endEditing(true)
    }
    
    func textFieldDidBeginEditing(textField: UITextField)
    {
        activeField = textField
    }
    
    func textFieldDidEndEditing(textField: UITextField)
    {
        activeField = nil
    }
    // Set values for text fields
    func UpdateText()
    {
        txtGauge.text = String(project.gauge)
        txtYarnNeeded.text = String(project.yarnNeeded)
        txtBallSize.text = String(project.ballSize)
        txtBallsNeeded.text = String(format: project.partialBalls ? "%.1f" : "%.0f", project.ballsNeeded)
        
    }
    // Update all the units on change
    func UpdateUnits()
    {
        project.gaugeUnits = GaugeUnits(rawValue: pkGauge.selectedRowInComponent(0))!
        project.yarnNeededUnits = LongLengthUnits(rawValue: pkYarnUnits.selectedRowInComponent(0))!
        project.ballSizeUnits = LongLengthUnits(rawValue: pkBallUnits.selectedRowInComponent(0))!
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    // Recalc when gauge changes
    func changeGauge(sender: UITextField!) {
        if let gauge = Double(txtGauge.text!) {
            project.gauge = gauge
        }
        project.calcYarnRequired()
        UpdateText()
    }
    // Recalc and update units when ball size changes
    @IBAction func changeBallSize(sender: AnyObject) {
        if let size = Int(txtBallSize.text!) {
            project.ballSize = size
        }
        UpdateUnits()
        project.calcYarnRequired()
        UpdateText()
    }

    // The data to return for the row and component (column) that's being passed in
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return (pickerView as! PickerView).text[row]
    }
    // Update the units and recalculate the yarn needed
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
        switch pickerView.tag {
        case 1:
            project.gaugeUnits = GaugeUnits(rawValue: row)!
        case 2:
            project.yarnNeededUnits = LongLengthUnits(rawValue: row)!
        case 3:
            project.ballSizeUnits = LongLengthUnits(rawValue: row)!
        case 4:
            project.partialBalls = Bool(row)
        default: break
        }
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
