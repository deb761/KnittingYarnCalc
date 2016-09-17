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
    var projectImg: UIImageView! = UIImageView(frame: CGRect(x: 0, y: 0, width: 178, height: 193))

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
        nameStack!.axis = .horizontal
        nameStack!.distribution = .equalSpacing
        nameStack!.alignment = .fill
        nameStack!.spacing = 10
        nameStack!.translatesAutoresizingMaskIntoConstraints = false
        lblName.text = NSLocalizedString(project.name.lowercased(), value: project.name, comment: "Project name")
        lblName.widthAnchor.constraint(equalToConstant: 50)
        lblName.textColor = Colors.lblColor
        lblName.font = lblName.font.withSize(20)

        projectImg.image = project.image
        projectImg.addConstraint(NSLayoutConstraint(item: projectImg, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 178))
        projectImg.addConstraint(NSLayoutConstraint(item: projectImg, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 193))
        
        // Create the stack with the Gauge
        gaugeRow = DimensionRow(name: NSLocalizedString("gauge", value: "Gauge", comment: "Density of knitted stitches per inch or cm"),
                                picker: pkGauge, delegate: self)
        txtGauge = gaugeRow!.txtVal
        txtGauge.addTarget(self, action: #selector(BaseProjectController.changeGauge(_:)), for: UIControlEvents.editingDidEnd)

        // Create the stack with the yarn needed
        yarnRow = DimensionRow(name: NSLocalizedString("yarn-req-label", value: "Yarn Req",
            comment: "Label next to field showing how much yarn is estimated for a project; needs to be short"),
            picker: pkYarnUnits, delegate: self)
        txtYarnNeeded = yarnRow!.txtVal
        txtYarnNeeded.isUserInteractionEnabled = false
        txtYarnNeeded.textColor = Colors.inactive
        
        // Create the stack with the ball size
        ballRow = DimensionRow(name: NSLocalizedString("ball-size", value: "Ball Size", comment: "Length of yarn in ball"),
                               picker: pkBallUnits, delegate: self)
        txtBallSize = ballRow!.txtVal
        txtBallSize.addTarget(self, action: #selector(BaseProjectController.changeBallSize(_:)), for: UIControlEvents.editingDidEnd)
        
        // Create the stack with the balls needed
        nBallsRow = DimensionRow(name: NSLocalizedString("num-balls", value: "Num Balls", comment: "Number of balls needed for a project; needs to be short"),
                                 picker: pkBallPartial, delegate: self)
        txtBallsNeeded = nBallsRow!.txtVal
        txtBallsNeeded.isUserInteractionEnabled = false
        txtBallsNeeded.textColor = Colors.inactive
        
        // Create the main stack
        mainStack = UIStackView(arrangedSubviews: [nameStack!, gaugeRow!.stack, yarnRow!.stack, ballRow!.stack, nBallsRow!.stack])
        mainStack!.axis = .vertical
        mainStack!.distribution = .equalSpacing
        mainStack!.spacing = 10
        mainStack!.alignment = .fill
        mainStack!.translatesAutoresizingMaskIntoConstraints = false

        let height = view.bounds.height + 200
        let width = view.bounds.width
        scrollView.contentSize.height = height
        scrollView.contentSize.width = width

        scrollView.addSubview(mainStack!)
        
        // Configure the scrollView
        scrollView.frame = view.bounds
        scrollView.isScrollEnabled = true
        scrollView.autoresizingMask = UIViewAutoresizing.flexibleHeight
        view.addSubview(scrollView)
        view.backgroundColor = Colors.background

        //autolayout the scroll view - pin 30 up 20 left 20 right 30 down
        let viewsDictionary = ["scrollView":scrollView]
        let scrollView_H = NSLayoutConstraint.constraints(
            withVisualFormat: "H:|-20-[scrollView]-20-|",  //horizontal constraint 20 points from left and right side
            options: NSLayoutFormatOptions(rawValue: 0),
            metrics: nil,
            views: viewsDictionary)
        let scrollView_V = NSLayoutConstraint.constraints(
            withVisualFormat: "V:|-80-[scrollView]-50-|", //vertical constraint 30 points from top and bottom
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
        
        mainStack!.leadingAnchor.constraint(equalTo: margins.leadingAnchor).isActive = true
        mainStack!.topAnchor.constraint(equalTo: margins.topAnchor).isActive = true
        mainStack!.trailingAnchor.constraint(equalTo: margins.trailingAnchor).isActive = true

        pkGauge.loaded(self, tag: 1)
        pkYarnUnits.loaded(self, tag: 2)
        pkBallUnits.loaded(self, tag: 3)
        pkBallPartial.loaded(self, tag: 4)
        
        // Set initial value for pickers
        pkGauge.selectRow(project.gaugeUnits.rawValue, inComponent: 0, animated: false)
        pkYarnUnits.selectRow(project.yarnNeededUnits.rawValue, inComponent: 0, animated: false)
        pkBallUnits.selectRow(project.ballSizeUnits.rawValue, inComponent: 0, animated: false)
        pkBallPartial.selectRow((project.partialBalls) ? 1 : 0, inComponent: 0, animated: false)

        // Set initial values for text fields
        UpdateText()
    }

    // Add a function to hide the keyboard
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(BaseProjectController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        view.endEditing(true)
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
    // Active text field
    var activeField: UITextField?
    func registerForKeyboardNotifications()
    {
        //Adding notifies on keyboard appearing
        NotificationCenter.default.addObserver(self, selector: #selector(BaseProjectController.keyboardWasShown(_:)),
                                                         name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(BaseProjectController.keyboardWillBeHidden(_:)),
                                                         name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    
    func deregisterFromKeyboardNotifications()
    {
        //Removing notifies on keyboard appearing
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    // Hold on to the contentInset of the scrollView before adjusting for the keyboard
    var insets:UIEdgeInsets!
    // Move the scrollView content up to account for the keyboard
    func keyboardWasShown(_ notification: Notification)
    {
        //Need to calculate keyboard exact size due to Apple suggestions
        self.scrollView.isScrollEnabled = true
        let info : NSDictionary = (notification as NSNotification).userInfo! as NSDictionary
        let keyboardSize = (info[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue.size
        insets = scrollView.contentInset
        let contentInsets : UIEdgeInsets = UIEdgeInsetsMake(0.0, 0.0, keyboardSize!.height, 0.0)
        
        self.scrollView.contentInset = contentInsets
        self.scrollView.scrollIndicatorInsets = contentInsets
        
        var aRect : CGRect = self.view.frame
        aRect.size.height -= keyboardSize!.height
        if activeField != nil
        {
            if (!aRect.contains(activeField!.frame.origin))
            {
                self.scrollView.scrollRectToVisible(activeField!.frame, animated: true)
            }
        }
    }
    
    // Restore the contentInsets
    func keyboardWillBeHidden(_ notification: Notification)
    {
        self.scrollView.contentInset = insets//contentInsets
        self.view.endEditing(true)
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField)
    {
        activeField = textField
    }
    
    func textFieldDidEndEditing(_ textField: UITextField)
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
        project.gaugeUnits = GaugeUnits(rawValue: pkGauge.selectedRow(inComponent: 0))!
        project.yarnNeededUnits = LongLengthUnits(rawValue: pkYarnUnits.selectedRow(inComponent: 0))!
        project.ballSizeUnits = LongLengthUnits(rawValue: pkBallUnits.selectedRow(inComponent: 0))!
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    // Recalc when gauge changes
    func changeGauge(_ sender: UITextField!) {
        if let gauge = Double(txtGauge.text!) {
            project.gauge = gauge
        } else {
            txtGauge.text = String(project.gauge)
        }
        project.calcYarnRequired()
        UpdateText()
    }
    // Recalc and update units when ball size changes
    @IBAction func changeBallSize(_ sender: AnyObject) {
        if let size = Int(txtBallSize.text!) {
            project.ballSize = size
        } else {
            txtBallSize.text = String(project.ballSize)
        }
        UpdateUnits()
        project.calcYarnRequired()
        UpdateText()
    }

    // The data to return for the row and component (column) that's being passed in
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return (pickerView as! PickerView).text[row]
    }
    // Update the units and recalculate the yarn needed
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
        switch pickerView.tag {
        case 1:
            project.gaugeUnits = GaugeUnits(rawValue: row)!
        case 2:
            project.yarnNeededUnits = LongLengthUnits(rawValue: row)!
        case 3:
            project.ballSizeUnits = LongLengthUnits(rawValue: row)!
        case 4:
            project.partialBalls = Bool(row == 1)
        default: break
        }
        txtGauge.endEditing(true)
        txtBallSize.endEditing(true)
        project.calcYarnRequired()
        UpdateText()
    }

}
