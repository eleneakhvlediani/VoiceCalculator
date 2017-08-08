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
            return self == "+" || self == "-" || self == "×" || self == "/"
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
    
    public func getExpressionArray()->[String] {
        
        var numbers =  self.components(separatedBy: CharacterSet(charactersIn: "+-×/"))
        
        var operations = self.characters.filter { (c) -> Bool in
            
            return c.description.isOperation
        }
        var arr = [String]()
        
        while true {
            if operations.count == 0 {
                arr.append(numbers.remove(at: 0))
                return arr
            }
            arr.append(numbers.remove(at: 0))
            arr.append(operations.remove(at: 0).description)
        }
        return arr
    }
    
    
}
