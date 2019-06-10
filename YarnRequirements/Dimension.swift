//
//  Dimension.swift
//  Knitting Yarn Calc
//
//  Created by Deborah Engelmeyer on 6/9/19.
//  Copyright © 2019 The Inquisitive Introvert. All rights reserved.
//

import Foundation

protocol DimensionProtocol {
    var name:String { get }
    var units:[String] { get }
    var unitIndex:Int { get }
    var valueString:String { get }
}

class Dimension<T: Numeric, E:RawRepresentable> : DimensionProtocol where E.RawValue == Int {
    let name: String
    let units:[String]

    let key:String!
    let projectName:String!
    let defaults:[String:AnyObject]!
    let defs = UserDefaults.standard

    init (key:String, projectName:String, name:String, unitNames:[String], defaults:[String:AnyObject] = [:]) {
        self.key = key
        self.projectName = projectName
        self.name = name
        self.units = unitNames
        self.defaults = defaults
    }
    
    // guage of the project
    var value:T {
        get {
            if let current = defs.value(forKey: ("\(projectName)-\(key)")) as? T {
                return current
            }
            return defaults[key] as! T
        }
        set {
            defs.set(newValue, forKey: "\(projectName)-\(key)")
        }
    }
    // units for the gauge
    var unit:E {
        get {
            let defaultValue:Int = defaults["\(key)Units"] as? Int ?? 0
            let current = defs.integerForKey("\(projectName)-\(key)Units", def: defaultValue)
            return E(rawValue: current)!
        }
        set {
            defs.set(newValue.rawValue, forKey: "\(projectName)-\(key)Units")
        }
    }

    var unitIndex: Int {
        get {
            return unit.rawValue
        }
    }
    
    var valueString: String {
        get {
            return String("\(self.value)")
        }
    }
}
