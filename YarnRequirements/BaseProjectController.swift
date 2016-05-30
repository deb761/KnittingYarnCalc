//
//  BaseProjectController.swift
//  YarnRequirements
//
//  Created by Deb on 5/22/16.
//  Copyright © 2016 The Inquisitive Introvert. All rights reserved.
//

import UIKit

class BaseProjectController: UIViewController, UIPickerViewDelegate, UITextFieldDelegate {
    
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
        projectImg.image = project.image
        projectImg.addConstraint(NSLayoutConstraint(item: projectImg, attribute: .Width, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1, constant: 178))
        projectImg.addConstraint(NSLayoutConstraint(item: projectImg, attribute: .Height, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1, constant: 193))
        
        // Create the stack with the Gauge
        gaugeRow = DimensionRow(name: "Gauge", picker: pkGauge, delegate: self)
        txtGauge = gaugeRow!.txtVal
        txtGauge.addTarget(self, action: #selector(BaseProjectController.changeGauge(_:)), forControlEvents: UIControlEvents.EditingDidEndOnExit)

        // Create the stack with the yarn needed
        yarnRow = DimensionRow(name: "Yarn Needed", picker: pkYarnUnits, delegate: self)
        txtYarnNeeded = yarnRow!.txtVal
        txtYarnNeeded.userInteractionEnabled = false
        
        // Create the stack with the ball size
        ballRow = DimensionRow(name: "Ball Size", picker: pkBallUnits, delegate: self)
        txtBallSize = ballRow!.txtVal
        txtBallSize.addTarget(self, action: #selector(BaseProjectController.changeBallSize(_:)), forControlEvents: UIControlEvents.EditingDidEndOnExit)
        
        // Create the stack with the balls needed
        nBallsRow = DimensionRow(name: "Num Balls", picker: UIPickerView(), delegate: self)
        txtBallsNeeded = nBallsRow!.txtVal
        txtBallsNeeded.userInteractionEnabled = false
        
        // Create the main stack
        mainStack = UIStackView(arrangedSubviews: [nameStack!, gaugeRow!.stack, yarnRow!.stack, ballRow!.stack, nBallsRow!.stack])
        mainStack!.axis = .Vertical
        mainStack!.distribution =  UIStackViewDistribution.EqualSpacing
        mainStack!.alignment = .Fill
        mainStack!.spacing = 10
        mainStack!.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(mainStack!)
        view.backgroundColor = UIColor(red: 212.0/255.0,
                                       green: 216.0/255.0,
                                       blue: 214.0/255.0, alpha: 1.0)
        
        //autolayout the stack view - pin 30 up 20 left 20 right 30 down
        let viewsDictionary = ["mainStack":mainStack!]
        let stackView_H = NSLayoutConstraint.constraintsWithVisualFormat(
            "H:|-20-[mainStack]-20-|",  //horizontal constraint 20 points from left and right side
            options: NSLayoutFormatOptions(rawValue: 0),
            metrics: nil,
            views: viewsDictionary)
        let stackView_V = NSLayoutConstraint.constraintsWithVisualFormat(
            "V:|-80-[mainStack]-50-|", //vertical constraint 30 points from top and bottom
            options: NSLayoutFormatOptions(rawValue:0),
            metrics: nil,
            views: viewsDictionary)
        view.addConstraints(stackView_H)
        view.addConstraints(stackView_V)
        
        pkGauge.loaded(self, tag: 1)
        pkYarnUnits.loaded(self, tag: 2)
        pkBallUnits.loaded(self, tag: 3)
        
        // Set initial value for pickers
        pkGauge.selectRow(project.gaugeUnits.rawValue, inComponent: 0, animated: false)
        pkYarnUnits.selectRow(project.YarnNeededUnits.rawValue, inComponent: 0, animated: false)
        pkBallUnits.selectRow(project.BallSizeUnits.rawValue, inComponent: 0, animated: false)

        // Set initial values for text fields
        UpdateText()
    }
    
    // Set values for text fields
    func UpdateText()
    {
        txtGauge.text = String(project.Gauge)
        txtYarnNeeded.text = String(project.YarnNeeded)
        txtBallSize.text = String(project.BallSize)
        txtBallsNeeded.text = String(project.BallsNeeded)
    }
    // Update all the units on change
    func UpdateUnits()
    {
        project.gaugeUnits = GaugeUnits(rawValue: pkGauge.selectedRowInComponent(0))!
        project.YarnNeededUnits = LongLengthUnits(rawValue: pkYarnUnits.selectedRowInComponent(0))!
        project.BallSizeUnits = LongLengthUnits(rawValue: pkBallUnits.selectedRowInComponent(0))!
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    // Recalc and update units when gauge changes
    func changeGauge(sender: UITextField!) {
        project.Gauge = Double(txtGauge.text!)!
        //UpdateUnits()
        project.calcYarnRequired()
        UpdateText()
    }
    // Recalc and update units when ball size changes
    @IBAction func changeBallSize(sender: AnyObject) {
        project.BallSize = Int(txtBallSize.text!)!
        UpdateUnits()
        project.calcYarnRequired()
        UpdateText()
    }

    // The data to return for the row and component (column) that's being passed in
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return (pickerView as! PickerView).text[row]
    }
    // Update the gauge units and recalculate the yarn needed
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
        switch pickerView.tag {
        case 1:
            project.gaugeUnits = GaugeUnits(rawValue: row)!
        case 2:
            project.YarnNeededUnits = LongLengthUnits(rawValue: row)!
        case 3:
            project.BallSizeUnits = LongLengthUnits(rawValue: row)!
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
