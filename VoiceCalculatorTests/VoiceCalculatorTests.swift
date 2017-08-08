//
//  VoiceCalculatorTests.swift
//  VoiceCalculatorTests
//
//  Created by Elene Akhvlediani on 8/8/17.
//  Copyright © 2017 Elene Akhvlediani. All rights reserved.
//

import XCTest
@testable import VoiceCalculator

class VoiceCalculatorTests: XCTestCase {
    lazy var calculator = Calculator.sharedInstance
    
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        
        XCTAssertEqual(calculator.calculate(arr: []) , 0)

        XCTAssertEqual(calculator.calculate(arr: [""]) , 0)

        XCTAssertEqual(calculator.calculate(arr: ["1"]) , 1)

        let arr = ["1","+","5", "×","2"]
        let res = calculator.calculate(arr: arr)
        XCTAssertEqual(res , 11)

        
        let res2 = calculator.calculate(arr: ["1","+","4", "/","2"])
        XCTAssertEqual(res2 , 3)

        
        let res3 = calculator.calculate(arr: ["1","+","4", "/","2","-","1"])
        XCTAssertEqual(res3 , 2)
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testComplicated(){
        let arr = ["1","+","5", "×","4", "/" , "2" , "-" , "1"]
        
        let res = calculator.calculate(arr: arr)
        XCTAssertEqual(res,10)
        
        let res2 = calculator.calculate(arr: ["1","+","5","×","4","/","2","×","5","+","9","/","3"])
        XCTAssertEqual(res2,54)
        
        
        let res3 = calculator.calculate(arr: ["1","+","5","×","4","/","2","×","5","+","3","/","9"])
        XCTAssertEqualWithAccuracy(res3!,51.33, accuracy: 0.01)
        
    }
    
    func testDoubles() {
        let res = calculator.calculate(arr: ["1", "/","2"])
        XCTAssertEqual(res , 0.5)
        
        let res2 = calculator.calculate(arr: ["1", "/","3"])
        XCTAssertEqualWithAccuracy(res2! , 0.33, accuracy: 0.01)
    }
    
    func testInvalidArrays() {
        
        let res = calculator.calculate(arr:  ["1", "/","ee", "+" , "1"])
        XCTAssertEqual(res,nil)
        let res2 = calculator.calculate(arr:  ["1", "/","2", "+" ])
        XCTAssertEqual(res2,nil)

        
        let res3 = calculator.calculate(arr:  ["1", "/","/", "2" ])
        XCTAssertEqual(res3,nil)
     
    }
    
    func testValidArray() {

        let res = calculator.isValid(str: "1+5×4/2-1")
        XCTAssertEqual(res,true)
        let res2 = calculator.isValid(str: "1+5×4/")
        XCTAssertEqual(res2,false)

    }
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            _ = self.calculator.calculate(arr: ["1","+","5","×","4","/","2","×","5","+","3","/","9"])
        }
    }
    
}
