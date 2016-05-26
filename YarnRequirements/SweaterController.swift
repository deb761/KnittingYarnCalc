//
//  SweaterController.swift
//  YarnRequirements
//
//  Created by Deb on 5/22/16.
//  Copyright © 2016 The Inquisitive Introvert. All rights reserved.
//

import UIKit

class SweaterController: ProjectViewController {

    @IBOutlet weak var pkGauge: GaugePicker!
    @IBOutlet weak var pkSizeUnits: ShortLengthPicker!
    @IBOutlet weak var pkYarnUnits: LongLengthPicker!
    @IBOutlet weak var pkBallUnits: LongLengthPicker!
    
    @IBOutlet weak var txtGauge: UITextField!
    @IBOutlet weak var txtChest: UITextField!
    @IBOutlet weak var txtYarnNeeded: UITextField!
    @IBOutlet weak var txtBallSize: UITextField!
    @IBOutlet weak var txtBallsNeeded: UITextField!

    var sweater:Sweater!

    // Set the input items to the current values
    override func viewDidLoad() {
        super.viewDidLoad()

        sweater = project as! Sweater
        // Do any additional setup after loading the view.
        // Connect data:
        pkGauge.loaded(sweater)
        pkSizeUnits.loaded(sweater, mfield: &sweater.ChestUnits)
        pkYarnUnits.loaded(sweater, mfield: sweater.YarnNeededUnits)
        pkBallUnits.loaded(sweater, mfield: sweater.BallSizeUnits)
        
        // Set initial value for pickers
        pkGauge.selectRow(sweater.gaugeUnits.rawValue, inComponent: 0, animated: false)
        pkSizeUnits.selectRow(sweater.ChestUnits.rawValue, inComponent: 0, animated: false)
        pkYarnUnits.selectRow(sweater.YarnNeededUnits.rawValue, inComponent: 0, animated: false)
        pkBallUnits.selectRow(sweater.BallSizeUnits.rawValue, inComponent: 0, animated: false)

        // Set initial values for text fields
        UpdateText()
    }
    
    // Set values for text fields
    func UpdateText()
    {
        txtGauge.text = String(sweater.Gauge)
        txtChest.text = String(sweater.ChestSize)
        txtYarnNeeded.text = String(sweater.YarnNeeded)
        txtBallSize.text = String(sweater.BallSize)
        txtBallsNeeded.text = String(sweater.BallsNeeded)
    }
    // Update all the units on change
    func UpdateUnits()
    {
        sweater.ChestUnits = ShortLengthUnits(rawValue: pkSizeUnits.selectedRowInComponent(0))!
        sweater.YarnNeededUnits = LongLengthUnits(rawValue: pkYarnUnits.selectedRowInComponent(0))!
        sweater.BallSizeUnits = LongLengthUnits(rawValue: pkBallUnits.selectedRowInComponent(0))!
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    // Recalc and update units when gauge changes
    @IBAction func changeGauge(sender: AnyObject) {
        sweater.Gauge = Double(txtGauge.text!)!
        UpdateUnits()
        sweater.calcYarnRequired()
        UpdateText()
    }
    // Recalc and update units when size changes
    @IBAction func changeSize(sender: AnyObject) {
        sweater.ChestSize = Double(txtChest.text!)!
        UpdateUnits()
        sweater.calcYarnRequired()
        UpdateText()
    }
    // Recalc and update units when ball size changes
    @IBAction func changeBallSize(sender: AnyObject) {
        sweater.BallSize = Int(txtBallSize.text!)!
        UpdateUnits()
        sweater.calcYarnRequired()
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
