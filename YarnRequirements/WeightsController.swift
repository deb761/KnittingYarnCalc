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

    var yarnWeights:[AnyObject]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        var format = NSPropertyListFormat.XMLFormat_v1_0 //format of the property list
        let plistPath:String? = NSBundle.mainBundle().pathForResource("YarnWeight", ofType: "plist")!
        let plistXML = NSFileManager.defaultManager().contentsAtPath(plistPath!)!
        do {
            yarnWeights = try NSPropertyListSerialization.propertyListWithData(plistXML, options: .MutableContainersAndLeaves, format: &format)
                as! [AnyObject]
        }
        catch {
            print("Error reading plist: \(error), format: \(format)")
        }
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
        let name = weight["name"] as! String
        cell.lblName?.text = NSLocalizedString(name + "-yarn", value: name.capitalizedString,
                                               comment: "Label for yarn weight name")
        var needles:[KnittingNeedle] = []
        for size in weight["needles"] as! [NSNumber] {
            needles.append(KnittingNeedle(size: size as Double))
        }
        let locale = NSLocale.currentLocale()
        let country = locale.objectForKey(NSLocaleCountryCode) as? String
        var sizes:String = ""

        // If the user is in the US, show US needle sizes first
        if country == "US" {
            if (needles.count == 2) {
                sizes = "\(needles[0].us)-\(needles[1].us) US, "
            } else {
                sizes = "\(needles[0].us)+ US, "
            }
        }
        // Always show international needle sizes
        if (needles.count == 2) {
            sizes += "\(needles[0].mm)-\(needles[1].mm)mm"
        } else {
            sizes += "\(needles[0].mm)+ mm"
        }
        
        cell.lblNeedles?.text = NSLocalizedString("needle-size", value: "Needle sizes",
                                                  comment: "Label representing a range of knitting needle sizes") + ": " + sizes
        // Show the gauge
        let gauges = weight["gauge"] as! [NSNumber]
        var gauge:String
        if gauges.count == 2 {
            gauge = "\(gauges[0])-\(gauges[1]) "
        } else {
            gauge = "\(gauges[0]) "
        }
        cell.lblGauge?.text = NSLocalizedString("gauge", value: "Gauge", comment: "Density of knitted stitches per 10cm") +
            ": " + gauge + NSLocalizedString("gauge-length", value: "stitches/4\" or 10cm",
                                                   comment: "Length over which gauge is counted, either 4\" or 10cm")
        
        // format windings string
        var wpi:String
        let windings = weight["windings"] as! [NSNumber]
        if windings.count == 2 {
            wpi = "\(windings[0])-\(windings[1])"
        } else {
            wpi = "\(windings[0])"
        }
        
        let length = weight["length"] as! NSNumber
        let ball = weight["weight"] as! NSNumber
        
        cell.lblWpi?.text = "\(wpi) " + NSLocalizedString("wpi", value: "wpi (windings/inch)", comment: "label for windings per inch")
        cell.lblDensity?.text = "\(length)" + NSLocalizedString("m", value: "m", comment: "Abbreviation for meters") + " " +
            NSLocalizedString("per", value: "per", comment: "indicate relationship between two things: 100m per 100g") +
            " \(ball)" + NSLocalizedString("g", value: "g", comment: "Abbreviation for grams") + " " +
            NSLocalizedString("yarn-ball", value: "ball", comment: "A ball of yarn")
        
        return cell
    }
}

