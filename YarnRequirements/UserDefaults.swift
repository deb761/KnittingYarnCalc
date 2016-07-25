//
//  UserDefaults.swift
//  YarnRequirements
//
//  Created by Deborah Engelmeyer on 7/25/16.
//  Copyright © 2016 The Inquisitive Introvert. All rights reserved.
//

import Foundation
import UIKit

extension NSUserDefaults {
    func longLengthUnitsForKey(key: String, def: LongLengthUnits) -> LongLengthUnits {
        if let value = objectForKey(key) as? Int {
            return LongLengthUnits(rawValue: value)!
        } else {
            setObject(def.rawValue, forKey: key)
            return def
        }
    }
    func shortLengthUnitsForKey(key: String, def: ShortLengthUnits) -> ShortLengthUnits {
        if let value = objectForKey(key) as? Int {
            return ShortLengthUnits(rawValue: value)!
        } else {
            setObject(def.rawValue, forKey: key)
            return def
        }
    }
    func doubleForKey(key: String, def: Double) -> Double {
        if let value = objectForKey(key) as? Double {
            return value
        } else {
            setObject(def, forKey: key)
            return def
        }
    }
    func intForKey(key: String, def: Int) -> Int {
        if let value = objectForKey(key) as? Int {
            return value
        } else {
            setObject(def, forKey: key)
            return def
        }
    }
}