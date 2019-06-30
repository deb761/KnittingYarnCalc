//
//  BallsDimension.swift
//  Knitting Yarn Calc
//
//  Created by Deborah Engelmeyer on 6/25/19.
//  Copyright © 2019 The Inquisitive Introvert. All rights reserved.
//

import Foundation

class BallsDimension: Dimension<Double, WholePartial> {
    override init(key: String, projectName: String, name: String, unitNames: [String], defaults: [String : AnyObject] = [:], readOnly: Bool = true) {
        super.init(key: key, projectName: projectName, name: name, unitNames: unitNames, defaults: defaults, readOnly: readOnly)
    }
    
    override var valueString: String {
        get {
            return unit == WholePartial.whole ? String(Int(self.value.rounded(.up))) : String.init(format: "%.1f", self.value)
        }
        set {
            if let testValue = Double(newValue) {
                self.value = testValue
            }
        }
    }

}
