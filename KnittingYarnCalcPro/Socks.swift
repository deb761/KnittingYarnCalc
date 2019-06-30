//
//  Socks.swift
//  YarnRequirements
//
//  Created by Deborah Engelmeyer on 5/29/16.
//  Copyright © 2016 The Inquisitive Introvert. All rights reserved.
//

import UIKit

// Define an enumeration for all the shoe size units out there
enum ShoeSizeUnits : Int {
    case child=0, youth, women, men, euro
}

// For now, treat socks as a rectangle wrapped around the foot
class Socks: Project {
   
    var sizeDimension: Dimension<Double, ShoeSizeUnits>?
    // Shoe size
    var size:Double {
        get {
            return defs.doubleForKey("\(name)-size", def: defaults["size"] as! Double)
        }
        set {
            defs.set(newValue, forKey: "\(name)-size")
        }
    }
    // Units for chest size
    var sizeUnits:ShoeSizeUnits {
        get {
            return defs.shoeSizeUnitsForKey("\(name)-sizeUnits",
                                               def: ShoeSizeUnits(rawValue: defaults["sizeUnits"] as! Int)!)
        }
        set {
            defs.set(newValue.rawValue, forKey: "\(name)-sizeUnits")
        }
    }
    
    let unitText = [NSLocalizedString("us-child", value: "US Child", comment: "Short string for picker indicating US Child shoe sizes"),
                    NSLocalizedString("us-youth", value: "US Youth", comment: "Short string for picker indicating US Youth shoe sizes"),
                    NSLocalizedString("us-women", value: "US Women", comment: "Short string for picker indicating US Women shoe sizes"),
                    NSLocalizedString("us-men", value: "US Men", comment: "Short string for picker indicating US Men shoe sizes"),
                    NSLocalizedString("euro", value: "Euro", comment: "Short string for picker indicating European shoe sizes")]

    
    // provide a means of defining a project name and image
    override init(name:String) {
        super.init(name: name)
        
        sizeDimension = Dimension<Double, ShoeSizeUnits>(key: "size", projectName: name, name: NSLocalizedString("shoe-size", value: "Shoe Size", comment: "Wearer shoe size"), unitNames: unitText, defaults: defaults)
        dimensions["size"] = sizeDimension as! DimensionProtocol
        dimensionOrder.insert("size", at: 1)
        // recalc yarn required with finer yarn
        calcYarnRequired()

    }
    
    // Calculate the yarn required for a pair of socks, where the length is
    // is determined by shoe size in a lookup table, and the width is a function
    // of the foot length
    override func calcYarnRequired()
    {
        var length = 0.0
        switch sizeUnits
        {
        case .child:
            length = getLength(usChild, size: size)!
        case .youth:
            length = getLength(usYouth, size: size)!
        case .women:
            length = getLength(usWomen, size: size)!
        case .men:
            length = getLength(usMen, size: size)!
        case .euro:
            length = getLength(eu, size: size)!
        }
        // I calculated a least-squares fit of foot length to circumference,
        // with a decent result for most sizes, although the really big feet
        // are underestimated a bit
        let intercept = 4.8250
        let slope = 0.6263
        let width = intercept + length * slope

        // We'll approximate the length of the sock as 1.75 times the length of the foot,
        // and add 0.5 * width for the the heel turn
        // and there are 2 feet, so multiply width by 2
        calcYarnRequired(length * 1.75 - 0.5 * width, siWidth: width * 2)
    }
    var usChild = [
        // Infant sizes
        0:7.9, 1:8.9, 2:9.5, 3:10.5,
        // Toddler sizes
        4:11.4, 5:12.1, 6:13, 7:14, 8:14.6, 9:15.9, 10:15.5]
    // US youth sizes
    var usYouth = [
        10:15.5, 11:17.1, 12:18.1, 13:19.4,
        // Size wrap
        1:19.7, 2:20.6, 3:21.6, 4:22.2, 5:23.2, 6:24.1, 7:24.8]
    
    // EU shoe size to cm conversion from https://www.shoeshow.com/shoe-sizes.asp
    var eu = [
        15:7.9, 16:8.9, 17:9.2, 18:10.2,
        // Toddler sizes
        19:10.8, 20:12.1, 21:12.7, 22:13, 23:14, 24:14.6, 25:15.2,
        26:15.9, 27:16.5,
        // Kid sizes
        28:17.1, 29:17.8, 30:18.1, 31:19.1, 32:19.7, 33:20.3,
        34:21, 35:21.9, 36:22.2, 37:23.2, 38:24.1, 39:24.8,
        // Mens sizes
        40:24.8, 41:25.5, 42:26, 43:27, 44:27.9, 45:28.6, 46:29.4, 47:30.2, 48:31, 49:31.8]
    
    // US Mens sizes
    var usMen = [6:23.5, 7:24.4, 8:25.4, 9:26, 10:27,
                 11:27.9, 12:28.6, 14:30.2, 15:31, 16:31.8]
    // US Wemens sizes
    var usWomen = [4:20.8, 5:21.6, 6:22.5, 7:23.5,
                   8:24.1, 9:25.1, 10:25.9, 11:26.7, 12:27.6]
    
    // Perform a linear interpolation between the input size and the next
    // highest to get foot length in cm
    func getLength(_ table:[Int:Double], size:Double) -> Double?
    {
        let lowSized = floor(size)
        let lowSize = Int(lowSized)
        
        if ((lowSized == size) && table[lowSize] != nil)
        {
            return table[lowSize]!
        }
        var highSize = lowSize + 1
        // Check for the US youth size rollover from 13 to 1
        if ((sizeUnits == .youth) && (lowSize == 13))
        {
            highSize = 1;
        }
        if let lowLength = table[lowSize] {
            if let highLength = table[highSize] {
                // This is a simple linear interpolation that is simplified a bit
                // because the difference in sizes is always 1
                let length = (size - lowSized) * (highLength - lowLength) + lowLength
                return length
            }
        }
        // We only get to this point if we couldn't find a size, so return default
        return 24 // about a US Women's size 8
    }
    
}


