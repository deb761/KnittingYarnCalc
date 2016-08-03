//
//  WeightsController.swift
//  YarnRequirements
//
//  Created by Deb on 5/14/16.
//  Copyright © 2016 The Inquisitive Introvert. All rights reserved.
//

import UIKit

class WeightsController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var txtName: UILabel!
    @IBOutlet weak var txtNeedles: UILabel!
    @IBOutlet weak var txtGauge: UILabel!
    @IBOutlet weak var txtWPI: UILabel!
    @IBOutlet weak var txtDensity: UILabel!

    let yarnWeights: [YarnWeight] = [
        YarnWeight(name: "Fingering", needles: "0-2 US, 2-3mm", gauge: "24-32 stitches/4\" or 10cm", wpi: "14", density: "211m per 50g ball"),
        YarnWeight(name: "Sport", needles: "3-6 US, 3-4mm", gauge: "24-26 stitches/4\" or 10cm", wpi: "12", density: "125m per 50g ball"),
        YarnWeight(name: "DK", needles: "3-6 US, 3-4mm", gauge: "22 stitches/4\" or 10cm", wpi: "11", density: "100m per 50g ball"),
        YarnWeight(name: "Worsted", needles: "7-8 US, 4.5-5mm", gauge: "20 stitches/4\" or 10cm", wpi: "9", density: "200m per 100g ball"),
        YarnWeight(name: "Aran", needles: "8-10 US, 5-6mm", gauge: "18 stitches/4\" or 10cm", wpi: "8", density: "150m per 100g ball"),
        YarnWeight(name: "Bulky", needles: "10-13 US, 6-9mm", gauge: "14-15 stitches/4\" or 10cm", wpi: "7", density: "125m per 100g ball"),
        YarnWeight(name: "Super Bulky", needles: "13+ US, 9+mm", gauge: "8-12 stitches/4\" or 10cm", wpi: "5-6", density: "40m per 100g ball")
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    // Return the number of items to display
    func tableView(tableView : UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return yarnWeights.count
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 120
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCellWithIdentifier("WeightCell", forIndexPath: indexPath) as! WeightCell

        let weight = yarnWeights[indexPath.row]
        cell.lblName?.text = weight.name
        cell.lblNeedles?.text = "Needle sizes: " + weight.needles
        cell.lblGauge?.text = "Gauge: " + weight.gauge
        cell.lblWpi?.text = weight.wpi + "wpi (windings/inch)"
        cell.lblDensity?.text = weight.density
        
        return cell
    }
}

