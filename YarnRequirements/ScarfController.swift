//
//  ScarfController.swift
//  YarnRequirements
//
//  Created by Deb on 5/25/16.
//  Copyright © 2016 The Inquisitive Introvert. All rights reserved.
//

import UIKit

class ScarfController: ProjectViewController {

    @IBOutlet weak var scarfImg: UIImageView!
    @IBOutlet weak var txtGauge: UITextField!
    @IBOutlet weak var gaugePicker: GaugePicker!
    @IBOutlet weak var txtYarnNeeded: UITextField!
    @IBOutlet weak var yarnNeededPicker: LongLengthPicker!
    @IBOutlet weak var txtWidth: UITextField!
    @IBOutlet weak var widthPicker: ShortLengthPicker!
    @IBOutlet weak var txtLength: UITextField!
    @IBOutlet weak var lengthPicker: ShortLengthPicker!
    @IBOutlet weak var txtBallSize: UITextField!
    @IBOutlet weak var ballSizePicker: LongLengthPicker!
    @IBOutlet weak var txtBallsNeeded: UITextField!
    @IBOutlet weak var ballsNeededPicker: LongLengthPicker!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
