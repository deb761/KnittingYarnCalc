//
//  Chart.swift
//  YarnRequirements
//
//  Created by Deborah Engelmeyer on 6/11/16.
//  Copyright © 2016 The Inquisitive Introvert. All rights reserved.
//

import Foundation

public struct Chart : Decodable {
    public let name:String?
    public let waist2hip:Double?
    public let sizes:[String:Size]?
    
    public init?(json: JSON) {
        name = "Name" <~~ json
        waist2hip = "Waist-Hip" <~~ json
        sizes = "Sizes" <~~ json
    }
    
}