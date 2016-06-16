//
//  SizeCharts.swift
//  YarnRequirements
//
//  Created by Deborah Engelmeyer on 6/11/16.
//  Copyright © 2016 The Inquisitive Introvert. All rights reserved.
//

import Foundation

public struct SizeCharts : Decodable {
    public let charts:[String:Chart]?
    
    public init?(json: JSON) {
        charts = "Charts" <~~ json
    }

}	