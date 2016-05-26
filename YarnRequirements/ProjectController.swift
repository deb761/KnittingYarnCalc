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
        Mittens(name: "Mittens", image: UIImage(named:"Mittens")!, segue: "ScarfSegue"),
        Gloves(name: "Gloves", image: UIImage(named:"Gloves")!, segue: "ScarfSegue"),
        Socks(name: "Socks", image: UIImage(named:"Socks")!, segue: "ScarfSegue"),
        Tam(name: "Tam", image: UIImage(named:"Tam")!, segue: "ScarfSegue"),
        Scarf(name: "Scarf", image: UIImage(named:"Scarf")!, segue: "ScarfSegue"),
        Toque(name: "Toque", image: UIImage(named:"Toque")!, segue: "ScarfSegue"),
        Sweater(name: "Sweater", image: UIImage(named:"Sweater")!, segue: "SweaterSegue"),
        Vest(name: "Vest", image: UIImage(named:"Vest")!, segue: "ScarfSegue"),
        Blanket(name: "Blanket", image: UIImage(named:"Blanket")!, segue: "ScarfSegue")
    ]

    override func viewDidLoad() {
        super.viewDidLoad()

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
        cell.image.image = project!.ThumbImage
        cell.backgroundColor = UIColor.clearColor()
        cell.lblName.text = project!.Name
    
        return cell
    }

    func collectionView(collectionView : UICollectionView, layout collectionViewLayout:UICollectionViewLayout, sizeForItemAtIndexPath indexPath:NSIndexPath) -> CGSize
    {
        let cellSize:CGSize = CGSizeMake(108, 126)
        return cellSize
    }

    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath){
        project = projects[indexPath.row]
        self.performSegueWithIdentifier(project!.segue, sender: self)
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
