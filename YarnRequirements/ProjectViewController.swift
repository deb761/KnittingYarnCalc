//
//  ProjectViewController.swift
//  YarnRequirements
//
//  Created by Deb on 5/22/16.
//  Copyright © 2016 The Inquisitive Introvert. All rights reserved.
//

import UIKit

class ProjectViewController: UIViewController, UIPickerViewDelegate {

    @IBOutlet weak var pkGauge: GaugePicker!
    @IBOutlet weak var pkYarnUnits: LongLengthPicker!
    @IBOutlet weak var pkBallUnits: LongLengthPicker!
    
    @IBOutlet weak var txtGauge: UITextField!
    @IBOutlet weak var txtYarnNeeded: UITextField!
    @IBOutlet weak var txtBallSize: UITextField!
    @IBOutlet weak var txtBallsNeeded: UITextField!

    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var projectImg: UIImageView!

    var project:Project!

    // Set the input items to the current values
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        // Connect data:
        pkGauge.loaded(self, tag:1)
        pkYarnUnits.loaded(self, tag:2)
        pkBallUnits.loaded(self, tag:3)
        
        lblName.text = project.name
        projectImg.image = project.image
        
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
    @IBAction func changeGauge(sender: AnyObject) {
        project.Gauge = Double(txtGauge.text!)!
        UpdateUnits()
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
