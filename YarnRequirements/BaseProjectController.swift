//
//  BaseProjectController.swift
//  Knitting Yarn Calc
//
//  Created by Deborah Engelmeyer on 6/9/19.
//  Copyright © 2019 The Inquisitive Introvert. All rights reserved.
//

import UIKit

class BaseProjectController: UITableViewController, UIPickerViewDelegate, UITextFieldDelegate {

    var project:Project!
    var pkGauge: UIPickerView!
    var pkYarnUnits: UIPickerView!
    var pkBallUnits: UIPickerView!
    var pkBallPartial: UIPickerView!
    
    var txtGauge: UITextField!
    var txtYarnNeeded: UITextField!
    var txtBallSize: UITextField!
    var txtBallsNeeded: UITextField!

    let guageText = [NSLocalizedString("sts/inch", value: "sts/inch", comment: "Stitches per inch to determine yarn gauge"),
                     NSLocalizedString("sts/4inch", value: "sts/4inch", comment: "Stitches per 4 inches to determine yarn gauge"),
                     NSLocalizedString("sts/10cm", value: "sts/10cm", comment: "Stitches per 10 cm to determine yarn gauge")]
    
    let ballText = [NSLocalizedString("whole", value: "Whole", comment: "A whole ball of yarn"),
                    NSLocalizedString("partial", value: "Partial", comment: "A partial ball of yarn")]
    
    let longText = [NSLocalizedString("yards", value: "yards", comment: "Short string for picker that indicates using yards for units of measure"),
                    NSLocalizedString("meters", value: "meters", comment: "Short string for picker that indicates using meters for units of measure")]

    var dimensions:[String : Dimension]!
    var dimensionOrder:[String] = ["gauge", "yarn", "ballSize", "balls"]

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        self.clearsSelectionOnViewWillAppear = false
        
        dimensions = [
            "gauge" : Dimension(name: NSLocalizedString("gauge", value: "Gauge", comment: "Density of knitted stitches per inch or cm"), unitText: guageText),
            "yarn" : Dimension(name: NSLocalizedString("yarn-req-label", value: "Yarn Req",
                                                       comment: "Label next to field showing how much yarn is estimated for a project; needs to be short"), unitText: longText),
            "ballSize" : Dimension(name: NSLocalizedString("ball-size", value: "Ball Size", comment: "Length of yarn in ball"), unitText: longText),
            "balls" : Dimension(name: NSLocalizedString("num-balls", value: "Num Balls", comment: "Number of balls needed for a project; needs to be short"), unitText: ballText)]
        
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
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? 1 : dimensions.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) ->
            UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "NameImage", for: indexPath) as! NameImageCell
            // Configure the cell...
            cell.nameLabel.text = project.name
            cell.projectImage.image = project.image
            return cell
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "DimensionRow", for: indexPath) as! DimensionCell
        let name = dimensionOrder[indexPath.row]
        let dimension = dimensions[name]
        // Configure the cell...
        cell.units = dimension?.units
        cell.textLabel?.text = dimension?.name
        setValues(name, cell: cell)
        cell.valueField.delegate = self
        
        return cell
    }
    
    func setValues(_ name: String, cell: DimensionCell) {
        switch name {
        case "gauge":
            txtGauge = cell.valueField
            txtGauge.text = String(project.gauge)
            cell.setUnits(project.gaugeUnits.rawValue)
            pkGauge = cell.picker
            
        case "yarn":
            txtYarnNeeded = cell.valueField
            txtYarnNeeded.text =  String(project.yarnNeeded)
            cell.setUnits(project.yarnNeededUnits.rawValue)
            pkYarnUnits = cell.picker
            
        case "ballSize":
            txtBallSize = cell.valueField
            txtBallSize.text =  String(project.ballSize)
            cell.setUnits(project.ballSizeUnits.rawValue)
            pkBallUnits = cell.picker
            
            
        case "balls":
            txtBallsNeeded = cell.valueField
            txtBallsNeeded.text = String(format: project.partialBalls ? "%.1f" : "%.0f", project.ballsNeeded)
            cell.setUnits(project.partialBalls ? 1 : 0)
            pkBallPartial = cell.picker
            
        default:
            return
        }
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
