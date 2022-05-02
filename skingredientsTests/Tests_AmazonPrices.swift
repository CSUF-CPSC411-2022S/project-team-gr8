//
//  Tests_AmazonPrices.swift
//  Tests iOS
//
//  Created by csuftitan on 3/9/22.
//

import Foundation
import XCTest
import skingredients



class Tests_AmazonPrices: XCTestCase {
    
      
    func testAmazonSearchAlgorithm() {
        // tests the logic to create a url that accesses an amazion search for a specific item
        let test_string = "https://www.amazon.com/s?k=batman+poster+"
        let temp = "batman poster "
        let plus = temp.replacingOccurrences(of: " ", with: "+", options: .literal, range: nil)
        let url = "https://www.amazon.com/s?k=" + plus
        XCTAssertEqual(test_string, url)
    }
    
    func testGoogleSearchAlgorithm() {
        // tests the logic to create a url that accesses a google search for a specific item
        let test_string = "https://www.google.com/search?q=batman+poster+"
        let temp = "batman poster "
        let plus = temp.replacingOccurrences(of: " ", with: "+", options: .literal, range: nil)
        let url = "https://www.google.com/search?q=" + plus
        XCTAssertEqual(test_string, url)
    }
    
    func testAmazonlink() {
        //TODO:
        // tests for the application being able to search on amazon for requested item
        // not sure if necessary
    }
    
    func testGooglelink() {
        //TODO:
        // tests for the application being able to search for item on google
        // not sure if necessary
    }
    
    
    // Unit tests
    
}

