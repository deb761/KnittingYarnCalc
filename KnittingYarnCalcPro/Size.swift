//
//  Size.swift
//  YarnRequirements
//
//  Created by Deborah Engelmeyer on 6/11/16.
//  Copyright © 2016 The Inquisitive Introvert. All rights reserved.
//

import Foundation

public struct Size : Decodable {
    public let name:String?
    public let chest:Double?
    public let neck2cuff:Double?
    public let back2waist:Double?
    public let back2hip:Double?
    public let shoulder:Double?
    public let underSleeve:Double?
    public let upperArm:Double?
    public let armhole:Double?
    public let waist:Double?
    public let hips:Double?
    
    public init?(json: JSON) {
        name = "name" <~~ json
        chest = "Chest" <~~ json
        neck2cuff = "Neck-to-Cuff" <~~ json
        back2waist = "Back-Waist" <~~ json
        back2hip = "Back-Hip" <~~ json
        shoulder = "Cross-Back" <~~ json
        underSleeve = "Under-Sleeve" <~~ json
        upperArm = "Upper-Arm" <~~ json
        armhole = "Armhole" <~~ json
        waist = "Waist" <~~ json
        hips = "Hips"  <~~ json
    }
    
}