//
//  InfoController.swift
//  YarnRequirements
//
//  Created by Deb on 5/23/16.
//  Copyright © 2016 The Inquisitive Introvert. All rights reserved.
//

import UIKit

class InfoController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func touchedIcon8(_ sender: AnyObject) {
        UIApplication.shared.openURL(URL(string:"http://www.icon8.com/")!)
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
