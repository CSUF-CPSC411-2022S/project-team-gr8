
 //  AmazonPrices.swift
 //  skingredients (iOS)
 //
 //  Created by Tristan Stewart on 3/9/22
 //

 import Foundation
 import SwiftUI
 
 
class AmazonPrices {
//TODO:
    // modify the following methods in order to search for a specific Item
    // parameters take in a string that contains brand and/or item
    // implemented through the use of buttons
    // Options are either find an alternative means of searching the web from application or
    // add specific links to the productDatabase for easier access
    // find a way around the UI error when using classes
    func AmazonPrices(_brand: String, _item: String){
        // works great
        /*
         let aString = "This is my string"
         let newString = aString.replacingOccurrences(of: " ", with: "+", options: .literal, range: nil)
         */
        let temp = _brand + _item
        let plus = temp.replacingOccurrences(of: " ", with: "+", options: .literal, range: nil)
        
        if let url = URL(string: "https://www.amazon.com/s?k=" + plus){
            UIApplication.shared.open(url)
        }
    } 

    func Amazonbrand(_brand: String){
        let plus = _brand.replacingOccurrences(of: " ", with: "+", options: .literal, range: nil)
        
        if let url = URL(string: "https://www.amazon.com/s?k=" + plus){
            UIApplication.shared.open(url)
        }
    }
    
    
    func GSearch(_brand: String, _item: String){
        // it works
        // need to add brand with item for more info
        let temp = _brand + _item
        let plus = temp.replacingOccurrences(of: " ", with: "+", options: .literal, range: nil)
        if let url = URL(string: "https://www.google.com/search?q=" + plus){
            UIApplication.shared.open(url)
        }
        
    }
}
