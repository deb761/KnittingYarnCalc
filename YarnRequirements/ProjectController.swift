//
//  ProjectController.swift
//  YarnRequirements
//
//  Created by Deb on 5/18/16.
//  Copyright © 2016 The Inquisitive Introvert. All rights reserved.
//

import UIKit

private let reuseIdentifier = "projectCell"

class ProjectController: UICollectionViewController {
    
    // Projects to choose from
    let projects = [
        Mittens(name: "Mittens", thumb:UIImage(named:"Mittens")!, image: UIImage(named:"Mittens")!, control: "ProjectViewController"),
        Gloves(name: "Gloves", thumb: UIImage(named:"Gloves")!, image: UIImage(named:"Gloves")!, control: "ProjectViewController"),
        Socks(name: "Socks", thumb: UIImage(named:"Socks")!, image: UIImage(named:"Socks")!, control: "ProjectViewController"),
        Tam(name: "Tam", thumb: UIImage(named:"Tam")!, image: UIImage(named:"Tam")!, control: "ProjectViewController"),
        Scarf(name: "Scarf", thumb: UIImage(named:"Scarf")!, image: UIImage(named:"ScarfImg")!, control: "ScarfViewController"),
        Toque(name: "Toque", thumb: UIImage(named:"Toque")!, image: UIImage(named:"Toque")!, control: "ProjectViewController"),
        Sweater(name: "Sweater", thumb: UIImage(named:"Sweater")!, image: UIImage(named:"SweaterImg")!, control: "ProjectViewController"),
        Vest(name: "Vest", thumb: UIImage(named:"Vest")!, image: UIImage(named:"Vest")!, control: "ProjectViewController"),
        Blanket(name: "Blanket", thumb: UIImage(named:"Blanket")!, image: UIImage(named:"Blanket")!, control: "ScarfViewController")
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        //let storyboard = UIStoryboard(name: "Main", bundle: nil)

        for project in projects {
            project.controller = BaseProjectController() as! BaseProjectController
        }
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let svc = segue.destinationViewController as! ProjectViewController;
        svc.project = project
    }


    // MARK: UICollectionViewDataSource

    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return projects.count
    }
    
    private var project:Project?

    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! ProjectCell

        // Configure the cell
        project = projects[indexPath.row]
        cell.image.image = project!.thumb
        cell.backgroundColor = UIColor.clearColor()
        cell.lblName.text = project!.name
    
        return cell
    }

    func collectionView(collectionView : UICollectionView, layout collectionViewLayout:UICollectionViewLayout, sizeForItemAtIndexPath indexPath:NSIndexPath) -> CGSize
    {
        let cellSize:CGSize = CGSizeMake(108, 126)
        return cellSize
    }

    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath){
        project = projects[indexPath.row]
        project!.controller.project = project
        _ = project?.controller.view
        showViewController(project!.controller, sender: self)
    }
    
    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(collectionView: UICollectionView, shouldHighlightItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(collectionView: UICollectionView, shouldSelectItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(collectionView: UICollectionView, shouldShowMenuForItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return false
    }

    override func collectionView(collectionView: UICollectionView, canPerformAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) -> Bool {
        return false
    }

    override func collectionView(collectionView: UICollectionView, performAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) {
    
    }
    */

}
