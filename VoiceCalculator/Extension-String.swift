//
//  Extension-String.swift
//  VoiceCalculator
//
//  Created by Elene Akhvlediani on 8/8/17.
//  Copyright © 2017 Elene Akhvlediani. All rights reserved.
//

import Foundation


extension String {
    public var isOperation:Bool {
        get {
            return self == "+" || self == "-" || self == "*" || self == "/"
        }
    }
    
    public var intValue:Int? {
        get {
            if let v = Int(self) {
                return v
            }
            return nil
        }
    }
    public var doubleValue:Double? {
        get {
            if let v = Double(self) {
                return v
            }
            return nil
        }
    }
    
    public var isInt:Bool {
        get {
            return self.intValue != nil
        }
    }
    
    
}
