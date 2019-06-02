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
        Mittens(name: "Mittens", thumb:UIImage(named:"Mittens")!, image: UIImage(named:"Mittens")!),
        Gloves(name: "Gloves", thumb: UIImage(named:"Gloves")!, image: UIImage(named:"Gloves")!),
        Socks(name: "Socks", thumb: UIImage(named:"Socks")!, image: UIImage(named:"Socks")!),
        Tam(name: "Tam", thumb: UIImage(named:"Tam")!, image: UIImage(named:"TamImg")!),
        Scarf(name: "Scarf", thumb: UIImage(named:"Scarf")!, image: UIImage(named:"ScarfImg")!),
        Toque(name: "Toque", thumb: UIImage(named:"Toque")!, image: UIImage(named:"Toque")!),
        Sweater(name: "Sweater", thumb: UIImage(named:"Sweater")!, image: UIImage(named:"SweaterImg")!),
        Vest(name: "Vest", thumb: UIImage(named:"Vest")!, image: UIImage(named:"VestImg")!),
        Blanket(name: "Blanket", thumb: UIImage(named:"Blanket")!, image: UIImage(named:"Blanket")!)
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
        let svc = segue.destination as! BaseProjectController;
        svc.project = project
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
        cell.image.image = project!.thumb
        cell.backgroundColor = UIColor.clear
        cell.lblName.text = NSLocalizedString(project!.name.lowercased(), value: project!.name, comment: "Project name")
    
        return cell
    }
    
    func collectionView(_ collectionView : UICollectionView, layout collectionViewLayout:UICollectionViewLayout, sizeForItemAtIndexPath indexPath:IndexPath) -> CGSize
    {
        let cellSize:CGSize = CGSize(width: 108, height: 126)
        return cellSize
    }

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath){
        project = projects[(indexPath as NSIndexPath).row]
        project!.controller.project = project
        _ = project?.controller.view
        show(project!.controller, sender: self)
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
