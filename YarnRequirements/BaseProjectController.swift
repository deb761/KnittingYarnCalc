//
//  BaseProjectController.swift
//  Knitting Yarn Calc
//
//  Created by Deborah Engelmeyer on 6/9/19.
//  Copyright © 2019 The Inquisitive Introvert. All rights reserved.
//

import UIKit

class BaseProjectController: UITableViewController, DimensionCellDelegate {

    var project:Project!
    var dimensionCells:[String : DimensionCell] = [:]
    var tagCells:[Int : DimensionCell] = [:]


    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        self.clearsSelectionOnViewWillAppear = false
    }

    // MARK: Dimension Cell Delegate
    func didChangeDimension() {
        project.calcYarnRequired()
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? 1 : project.dimensions.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "NameImage", for: indexPath) as! NameImageCell
            // Configure the cell...
            cell.nameLabel.text = project.name
            cell.projectImage.image = project.image
            return cell
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "DimensionRow", for: indexPath) as! DimensionCell
        let name = project.dimensionOrder[indexPath.row]
        let dimension = project.dimensions[name]
        // Configure the cell...
        cell.units = dimension?.units
        cell.textLabel?.text = dimension?.name
        cell.didCreate(controller: self, dimension: dimension!, tag: indexPath.row)
        dimensionCells[name] = cell
        tagCells[indexPath.row] = cell
        
        return cell
    }

}
