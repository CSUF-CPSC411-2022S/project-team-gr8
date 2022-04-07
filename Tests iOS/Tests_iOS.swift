//
//  Tests_iOS.swift
//  Tests iOS
//
//  Created by csuftitan on 2/21/22.
//

import XCTest
@testable import skingredients

class Tests_iOS: XCTestCase {

//    override func setUpWithError() throws {
//        // Put setup code here. This method is called before the invocation of each test method in3 the class.
//
//        // In UI tests it is usually best to stop immediately when a failure occurs.
//        continueAfterFailure = false
//
//        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
//    }
//
//    override func tearDownWithError() throws {
//        // Put teardown code here. This method is called after the invocation of each test method in the class.
//    }
//
//    func testExample() throws {
//        // UI tests must launch the application that they test.
//        let app = XCUIApplication()
//        app.launch()
//
//        // Use recording to get started writing UI tests.
//        // Use XCTAssert and related functions to verify your tests produce the correct results.
//    }
//
//    func testLaunchPerformance() throws {
//        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
//            // This measures how long it takes to launch your application.
//            measure(metrics: [XCTApplicationLaunchMetric()]) {
//                XCUIApplication().launch()
//            }
//        }
//    }
    
    func testCapitalizeIngredients() {
//        var initial: [MyResult] = [
//            MyResult(id:1,
//                     brand:"amorepacific",
//                     name:"age spot brightening pen",
//                     ingredient_list:["carbomer"]),
//            
//            MyResult(id:2,
//                     brand:"amorepacific",
//                     name: "all day balancing care serum",
//                     ingredient_list: ["camellia sinensis leaf water"]),
//            
//            MyResult(id:3,
//                     brand:"amorepacific",
//                     name: "bio-enzyme refining complex",
//                     ingredient_list: ["panax ginseng root extract"])
//        ]
//        let p: ProductsDatabase = ProductsDatabase()
//        p.capitalizeNames(of: &initial)
//        let expected: [MyResult] = [
//            MyResult(id:1,
//                     brand:"Amorepacific",
//                     name:"Age Spot Brightening Pen",
//                     ingredient_list:["Carbomer"]),
//            
//            MyResult(id:2,
//                     brand:"Amorepacific",
//                     name: "All Day Balancing Care Serum",
//                     ingredient_list: ["Camellia Sinensis Leaf Water"]),
//            
//            MyResult(id:3,
//                     brand:"Amorepacific",
//                     name: "Bio-enzyme Refining Complex",
//                     ingredient_list: ["Panax Ginseng Root Extract"])
//        ]
//        for i in 1...initial.endIndex {
//            XCTAssertEqual(initial[i].brand, expected[i].brand)
//            XCTAssertEqual(initial[i].name, expected[i].name)
//            for j in 1...initial[i].ingredient_list.endIndex {
//                XCTAssertEqual(initial[i].ingredient_list[j], initial[j].ingredient_list[j])
//            }
//        }
    }
    
    func testFilterIngredients() {
    }
}
