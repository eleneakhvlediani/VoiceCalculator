//
//  Calculator.swift
//  VoiceCalculator
//
//  Created by Elene Akhvlediani on 8/8/17.
//  Copyright © 2017 Elene Akhvlediani. All rights reserved.
//

import Foundation




class Calculator {
    public static var sharedInstance = Calculator()
    
    private init(){
        
    }
    
    func calculate(arr:[String])->Double{
        var res = getResultArray(arr: arr)
        if res.count > 0 , let resultValue = Double(res[0]){
            return resultValue
        }
        return 0
        
    }
    
    func isValid(str:String) -> Bool {
        if str.characters.count%2 == 0 {
            return false
        }
        var i = 0
        for char in str.characters {
            if i%2 == 0 {
                if !char.description.isInt {
                    return false
                }
            }else{
                if !char.description.isOperation {
                    return false
                }
            }
            i += 1 
        }
        return true
        
    }
    
    private func getResultArray(arr:[String]) -> [String] {
        var arrayCopy = arr
        var index = arrayCopy.index{$0 == "×" || $0 == "/" }
        if index == nil {
            index = arrayCopy.index{$0 == "+" || $0 == "-" }
            if index == nil {
                return arrayCopy
            }
        }
        
        let firstInt = arrayCopy.remove(at: index! - 1)
        let operation = arrayCopy.remove(at: index! - 1)
        let secondInt = arrayCopy.remove(at: index! - 1)
        let result = getValue(first: firstInt, second: secondInt, operation: operation)
        arrayCopy.insert(result, at: index! - 1)
        return getResultArray(arr: arrayCopy)
        
    }
    
    private func getValue(first:String,second:String, operation:String) -> String {

        var result:Double = 0

        if let firstNumber  = first.doubleValue, let secondNumber = second.doubleValue {

            switch operation {
                case "+":
                    result = firstNumber + secondNumber
                case "-":
                    result = firstNumber - secondNumber
                case "×":
                    result = firstNumber * secondNumber
                case "/":
                    result = firstNumber / secondNumber

                default:
                    result = 0
                }
            }
        
        return result.description
        
    }
}
