//
//  UserDefaults.swift
//  YarnRequirements
//
//  Created by Deborah Engelmeyer on 7/25/16.
//  Copyright © 2016 The Inquisitive Introvert. All rights reserved.
//

import Foundation
import UIKit

extension UserDefaults {
    func gaugeUnitsForKey(_ key: String, def: GaugeUnits) -> GaugeUnits {
        if let value = object(forKey: key) as? Int {
            return GaugeUnits(rawValue: value)!
        } else {
            set(def.rawValue, forKey: key)
            return def
        }
    }
    func longLengthUnitsForKey(_ key: String, def: LongLengthUnits) -> LongLengthUnits {
        if let value = object(forKey: key) as? Int {
            return LongLengthUnits(rawValue: value)!
        } else {
            set(def.rawValue, forKey: key)
            return def
        }
    }
    func shortLengthUnitsForKey(_ key: String, def: ShortLengthUnits) -> ShortLengthUnits {
        if let value = object(forKey: key) as? Int {
            return ShortLengthUnits(rawValue: value)!
        } else {
            set(def.rawValue, forKey: key)
            return def
        }
    }
    func shoeSizeUnitsForKey(_ key: String, def: ShoeSizeUnits) -> ShoeSizeUnits {
        if let value = object(forKey: key) as? Int {
            return ShoeSizeUnits(rawValue: value)!
        } else {
            set(def.rawValue, forKey: key)
            return def
        }
    }
    func doubleForKey(_ key: String, def: Double) -> Double {
        if let value = object(forKey: key) as? Double {
            return value
        } else {
            set(def, forKey: key)
            return def
        }
    }
    func integerForKey(_ key: String, def: Int) -> Int {
        if let value = object(forKey: key) as? Int {
            return value
        } else {
            set(def, forKey: key)
            return def
        }
    }
}
