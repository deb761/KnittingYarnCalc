//
//  ProjectController.swift
//  YarnRequirements
//
//  Created by Deb on 5/18/16.
//  Copyright © 2016 The Inquisitive Introvert. All rights reserved.
//

import UIKit

private let reuseIdentifier = "projectCell"

class ProjectListController: UICollectionViewController {
    
    // Projects to choose from
    let projects = [
        Mittens(name: "Mittens"),
        Gloves(name: "Gloves"),
        Socks(name: "Socks"),
        Tam(name: "Tam"),
        Scarf(name: "Scarf"),
        Toque(name: "Toque"),
        Sweater(name: "Sweater"),
        Vest(name: "Vest"),
        Blanket(name: "Blanket")
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let cell = sender as! ProjectCell
        let svc = segue.destination as! ProjectController;
        svc.project = cell.project
    }


    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return projects.count
    }
    
    fileprivate var project:Project?

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! ProjectCell

        // Configure the cell
        project = projects[(indexPath as NSIndexPath).row]
        cell.project = project
        cell.image.image = project!.thumbnail
        cell.backgroundColor = UIColor.clear
        cell.lblName.text = NSLocalizedString(project!.name.lowercased(), value: project!.name, comment: "Project name")
    
        return cell
    }
    
    func collectionView(_ collectionView : UICollectionView, layout collectionViewLayout:UICollectionViewLayout, sizeForItemAtIndexPath indexPath:IndexPath) -> CGSize
    {
        let cellSize:CGSize = CGSize(width: 108, height: 156)
        return cellSize
    }

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath){
        project = projects[(indexPath as NSIndexPath).row]
        project!.controller.project = project
      /*  performSegue(withIdentifier: "ShowProject", sender: nil)
        _ = project?.controller.view
        show(project!.controller, sender: self)*/
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
