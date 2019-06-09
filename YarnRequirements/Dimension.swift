//
//  Dimension.swift
//  Knitting Yarn Calc
//
//  Created by Deborah Engelmeyer on 6/9/19.
//  Copyright © 2019 The Inquisitive Introvert. All rights reserved.
//

import Foundation

class Dimension {
    var cell:DimensionCell!
    let name:String!
    let units:[String]!
    
    init (name:String, unitText:[String]) {
        self.name = name
        self.units = unitText
    }
}
