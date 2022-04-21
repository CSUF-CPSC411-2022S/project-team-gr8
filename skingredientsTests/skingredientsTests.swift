//
//  skingredientsTests.swift
//  skingredientsTests
//
//  Created by csuftitan on 4/13/22.
//

import XCTest
@testable import skingredients
import Foundation

class skingredientsTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }
    func testCapitalizeIngredients() {
        var initial: [MyResult] = [
            MyResult(id:1,
                     brand:"amorepacific",
                     name:"age spot brightening pen",
                     ingredient_list:["carbomer"]),

            MyResult(id:2,
                     brand:"amorepacific",
                     name: "all day balancing care serum",
                     ingredient_list: ["camellia sinensis leaf water"]),

            MyResult(id:3,
                     brand:"amorepacific",
                     name: "bio-enzyme refining complex",
                     ingredient_list: ["panax ginseng root extract"])
        ]
        let p: ProductsDatabase = ProductsDatabase()
        p.capitalizeNames(of: &initial)
        let expected: [MyResult] = [
            MyResult(id:1,
                     brand:"Amorepacific",
                     name:"Age Spot Brightening Pen",
                     ingredient_list:["Carbomer"]),

            MyResult(id:2,
                     brand:"Amorepacific",
                     name: "All Day Balancing Care Serum",
                     ingredient_list: ["Camellia Sinensis Leaf Water"]),

            MyResult(id:3,
                     brand:"Amorepacific",
                     name: "Bio-Enzyme Refining Complex",
                     ingredient_list: ["Panax Ginseng Root Extract"])
        ]
        for i in 0...initial.endIndex-1 {
            XCTAssertEqual(initial[i].brand, expected[i].brand)
            XCTAssertEqual(initial[i].name, expected[i].name)
            for j in 0...initial[i].ingredient_list.endIndex-1 {
                XCTAssertEqual(initial[i].ingredient_list[j], initial[i].ingredient_list[j])
            }
        }
    }

    func testFilterIngredients() {
        var initial: [MyResult] = [
            MyResult(id:1,
                     brand:"amorepacific",
                     name:"age spot brightening pen",
                     ingredient_list:["carbomer"]),

            MyResult(id:2,
                     brand:"amorepacific",
                     name: "all day balancing care serum",
                     ingredient_list: ["camellia sinensis leaf water"]),

            MyResult(id:3,
                     brand:"amorepacific",
                     name: "bio-enzyme refining complex",
                     ingredient_list: ["panax ginseng root extract"])
        ]
        let p: ProductsDatabase = ProductsDatabase()
        p.items = initial
         p.filterData(searchString: "bio-enzyme")
        let expected: [MyResult] = [
            MyResult(id:3,
                     brand:"amorepacific",
                     name: "bio-enzyme refining complex",
                     ingredient_list: ["panax ginseng root extract"])
        ]
        XCTAssertEqual(p.displayedItems, expected)
    }

}
